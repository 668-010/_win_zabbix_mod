echo "script-start11" # Это надо обязательно!!!!!!!

# Типо инициализация, задаем значения перменных
#
# Общие переменные:

$pathTemp_old = 'C:\zabbix-agent\_win_zabbix_mod\schtasks\list_schtasks_old'
$pathTemp_new ='C:\zabbix-agent\_win_zabbix_mod\schtasks\list_schtasks_new'

# Zabbix переменные:
$path_zabbix_sender = "C:\zabbix-agent\bin\win64\zabbix_sender.exe"
$path_zabbix_conf = "C:\zabbix-agent\conf\zabbix_agentd.win.conf"
$zabbix_key = "trap.schtasks_list"


################

### тут Ф-ии ###
#
#


function ConvertTo-Encoding ([string]$From, [string]$To){  # Конвертирует кодировку
    Begin{  
        $encFrom = [System.Text.Encoding]::GetEncoding($from)  
        $encTo = [System.Text.Encoding]::GetEncoding($to)  
    }  
    Process{  
        $bytes = $encTo.GetBytes($_)  
        $bytes = [System.Text.Encoding]::Convert($encFrom, $encTo, $bytes)  
        $encTo.GetString($bytes)  
    }  
} 


function zabbix-send { # Отправляет на заббикс-вервер данные с помощью сендера
    param($zabbix_value)
    
    &$path_zabbix_sender -c $path_zabbix_conf -k $zabbix_key -o $zabbix_value | ConvertTo-Encoding windows-1251 utf-8 | Out-Null
}


Function Dump-SchTasks { # Ф-я получает список заданий, немного их обрабатывает и скидывает в файл
param($file_path)        # Перменная которая будет передаваться в ф-ю (путь к файлу)

if(Test-Path $file_path) {
    Remove-Item $file_path   # Удаляем файл, если существует, перед тем как писать
}
foreach ($str_list in schtasks.exe /QUERY /fo TABLE /NH) # В цикле будем построчно обрабатывать список заданий
    {
        $str_list = $str_list.Split(" ")[0].Replace("Папка:","").Replace("ИНФОРМАЦИЯ.","").Trim("") # Вырезаем из строки ненужное
        if ($str_list -ne "") {
            $str_list = $str_list | ConvertTo-Encoding windows-1251 utf-8 # Конвертируем в UTF-8
            $str_list | Out-File $file_path -Append # Если строка не пустая, дописываем в файл
        }
     }
}


 
Function Compare-TextFile {    # Ф-я для сравнения файлов
param ($file1, $file2)         # Инициализация (Принимаем параметры)
 
$refObj = Get-Content $file1 
$tarObj = Get-content $file2 
$send = ''
 
$lengths = New-Object 'object[,]' ($refObj.Length + 1), ($tarObj.Length + 1) 
 
for($i = 0; $i -lt $refObj.length; $i++) { 
  for ($j = 0; $j -lt $tarObj.length; $j++) { 
    if ($refObj[$i] -ceq $tarObj[$j]) { 
      $lengths[($i+1),($j+1)] = $lengths[$i,$j] + 1 
    } else { 
      $lengths[($i+1),($j+1)] = [math]::max(($lengths[($i+1),$j]),($lengths[$i,($j+1)])) 
    } 
  } 
} 
 
$lcsobj = @() 
$x = $refObj.length 
$y = $tarObj.length 
while (($x -ne 0) -and ($y -ne 0)) { 
  if ( $lengths[$x,$y] -eq $lengths[($x-1),$y]) {--$x} 
  elseif ($lengths[$x,$y] -eq $lengths[$x,($y-1)]) {--$y} 
  else { 
    if ($refObj[($x-1)] -ceq $tarObj[($y-1)]) {     
      $lcsobj = ,($refObj[($x-1)],($x-1),($y-1)) + $lcsobj 
    } 
    --$x 
    --$y 
  } 
} 
 
$linefmt = "000" 
$refPos = 0 
$tarPos = 0 
$lcsPos = 0 


$is_del = "Удалено:"
$is_add = "Добавлено:"
 
$is_del = $is_del | ConvertTo-Encoding windows-1251 utf-8
$is_add = $is_add | ConvertTo-Encoding windows-1251 utf-8
##########
 
  while ($lcsPos -lt ($lcsObj.length)) {  
    while ($refPos -le $lcsObj[$lcsPos][1] ) { 
      if ($refPos -ne $lcsObj[$lcsPos][1]) { 
        $send = $send+$is_del+$refObj[$refPos]+" " 
      } 
      $refPos++ 
    } 
 
    while ($tarPos -le $lcsObj[$lcsPos][2] ) { 
      if ($tarPos -ne $lcsObj[$lcsPos][2]) { 
        $send = $send+$is_add+$tarObj[$tarPos]+" "
      } 
      $tarPos++ 
    } 

    $lcsPos++
  } 
 
  while ($refPos -lt $refObj.length ) { 
    $send = $send+$is_del+$refObj[$refPos]+" " 
    $refPos++ 
  } 
  while ($tarPos -lt $tarObj.length ) { 
    $send = $send+$is_add+$tarObj[$tarPos]+" "
    $tarPos++ 
  } 
 
 if ($send -ne "") { # Если есть изменения шлем на заббикс сервер
    zabbix-send($send)
 } else {
    zabbix-send("nochanges")
 }
}

############################

#### А тут сам скрипт пойдет
#
#
#

if (Test-Path $pathTemp_old) { # Проверяем, существует ли файл со старым списком задач
        # Если файл старых заданий есть, пишем новый, сравниваем и шлем изменения на заббикс сервер, обновлеяем список задач
        Dump-SchTasks $pathTemp_new # Пишем новый файл со списоком задач
        Compare-TextFile $pathTemp_old $pathTemp_new # Сравниваем, если есть изменения, шлем на заббикс сервер
        Dump-SchTasks $pathTemp_old # Обновляем старый файл сос списком задач
    } else {
        # Типо файл не существует, значит первый запуск, надо получить список задач, и занести все это дело с OLD файл
        Dump-SchTasks $pathTemp_old
    }