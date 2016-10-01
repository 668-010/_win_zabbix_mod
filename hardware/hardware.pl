#!/usr/bin/perl

$ohmr = `C:\\zabbix-agent\\_win_zabbix_mod\\shell\\OpenHardwareMonitorReport.exe`; #Переменная вызывающая консольную программу

############################################################################
#Узнаем модель материнской платы

sub mainboard  {												#Функция материнской платы
if ($ohmr =~ /(\+\-\ )(.+) \(\/mainboard\)/)					#Если по регуляр.выражению найден строка
{
	print "$2";													#то вывести значение второй группы регулярки
}
}

############################################################################
#Узнаем температуру процессора

sub cpu_temp  {													#Функция Температуры процессора
if ($ohmr =~ /(\d+)(\.\d+)? \(\/lpc\/.+\/temperature\/0\)/)		#Если по регуляр.выражению найден строка
{
	print "$1";													#то вывести значение первой группы регулярки
}
}


############################################################################
#Узнаем модель процессора

sub cpu_model  {												#Функция модели процессора
if ($ohmr =~ /(\+\-\ )(.+) \(\/intelcpu\/0\)/)					#Если по регуляр.выражению найден строка
{
	print "$2";													#то вывести значение второй группы регулярки
}
}

############################################################################
############################################################################
#Узнаем модели установленных ОЗУ
############################################################################
#DIMM0
sub memory_model0  {											#Функция модели памяти
if ($ohmr =~ /(Memory Device \[0\] Part Number\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$model0 = "$2";												#то присвоить переменной model значение второй группы регулярки
	}
if ($ohmr =~ /(Memory Device \[0\] Manufacturer\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$firma0 = "$2";												#то присвоить переменной firma значение второй группы регулярки
	}
if ($firma0 eq "Manufacturer0")	{print 'none'}					#Если фирма "Manufacturer" (Это значит что нет планки ОЗУ), то вывести "none"
else															#Иначе
	{
print $firma0 .' '. $model0;									#Вывести значения строковых переменных, склеив их. Дополнительно между значениями вставлен пробел
	}
}

############################################################################
#DIMM1
sub memory_model1  {											#Функция модели памяти
if ($ohmr =~ /(Memory Device \[1\] Part Number\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$model1 = "$2";												#то присвоить переменной model значение второй группы регулярки
	}
if ($ohmr =~ /(Memory Device \[1\] Manufacturer\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$firma1 = "$2";												#то присвоить переменной firma значение второй группы регулярки
	}
if ($firma1 eq "Manufacturer1")	{print 'none'}					#Если фирма "Manufacturer" (Это значит что нет планки ОЗУ), то вывести "none"
else															#Иначе
	{
print $firma1 .' '. $model1;									#Вывести значения строковых переменных, склеив их. Дополнительно между значениями вставлен пробел
	}
}


#DIMM2
sub memory_model2  {											#Функция модели памяти
if ($ohmr =~ /(Memory Device \[2\] Part Number\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$model2 = "$2";												#то присвоить переменной model значение второй группы регулярки
	}
if ($ohmr =~ /(Memory Device \[2\] Manufacturer\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$firma2 = "$2";												#то присвоить переменной firma значение второй группы регулярки
	}
if ($firma2 eq "Manufacturer2")	{print 'none'}					#Если фирма "Manufacturer" (Это значит что нет планки ОЗУ), то вывести "none"
else															#Иначе
	{
print $firma2 .' '. $model2;									#Вывести значения строковых переменных, склеив их. Дополнительно между значениями вставлен пробел
	}
}

#DIMM3
sub memory_model3  {											#Функция модели памяти
if ($ohmr =~ /(Memory Device \[3\] Part Number\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$model3 = "$2";												#то присвоить переменной model значение второй группы регулярки
	}
if ($ohmr =~ /(Memory Device \[3\] Manufacturer\:\ )(.+)/)		#Если по регуляр.выражению найден строка
	{
	$firma3 = "$2";												#то присвоить переменной firma значение второй группы регулярки
	}
if ($firma3 eq "Manufacturer3")	{print 'none'}					#Если фирма "Manufacturer" (Это значит что нет планки ОЗУ), то вывести "none"
else															#Иначе
	{
print $firma3 .' '. $model3;									#Вывести значения строковых переменных, склеив их. Дополнительно между значениями вставлен пробел
	}
}




###################
################### Перенаправление внешних переменных
$param=@ARGV[0];
if ( $param eq "mainboard" )		{mainboard();exit 0;}
if ( $param eq "cpu_temp" )			{cpu_temp();exit 0;}
if ( $param eq "cpu_model" )		{cpu_model();exit 0;}
if ( $param eq "memory_model0" )		{memory_model0();exit 0;}
if ( $param eq "memory_model1" )		{memory_model1();exit 0;}
if ( $param eq "memory_model2" )		{memory_model2();exit 0;}
if ( $param eq "memory_model3" )		{memory_model3();exit 0;}