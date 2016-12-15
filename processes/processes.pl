#!/usr/bin/perl
#Скрипт мониторинга процессов которые жрут более 1.2 Гб ОЗУ. На выходе количество процессов которые более 1.2 Гб

#Массив из процессов отсортированные по Working Set(WS - реальная величина в ОЗУ, без учета подкачки)
@ps=`powershell -NoProfile -ExecutionPolicy Bypass -File C:\\zabbix-agent\\_win_zabbix_mod\\processes\\processes.ps1`;
#Переменная число процессов
$n=0;

#Цикл в массиве, в котором по регулярке отыскивается 4ая колонка ($7) в каждой строке и если ее значение больше 1.2Гб то в переменную $n прибавляется 1
foreach my $a (@ps){
if ($a =~ /(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(\d+)(\s+)(.*)/){
if ( "$7" > 1258291 ) {$n = $n + 1;} }
}
#Вывод количества процессов больше 1.2Гб
print $n;