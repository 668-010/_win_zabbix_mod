#!/usr/bin/perl
#
# Скрипт для выборки значений из реестра.
# принимает в качестве параметра входные данные, в зависимости от них выдает результат
#
# Путь реестра прописывается следующим образом: HKEY_LOCAL_MACHINE/SOFTWARE/...... 
# В пути использовать символ / вместо \, т.к. заббикс урезает символ \
#
# В скрипте символ / заменяется на нормальный \
#
# Пример запуска скрипта с парметрами:
# regedit.perl "HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Auto Update" "AUoptions"
#
# Соответствует следющей команде:
# REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "AUoptions"
#
# Пример USREPARAMETRS:
# UserParameter=regquery.[*],	C:\zabbix-agent\_win_zabbix_mod\shell\perl.bat   C:\zabbix-agent\_win_zabbix_mod\regquery\regquery.perl "$1" "$2"
#
#######


##################################


##### ПРОГРАММА #####
#
#

my $path = shift; # Считываем вх. аругумент путь
my $arg = shift; # Считываем вх. аругумент

$path =~ s/\//\\/g; # Хитрая фишка , замена / на \ (потому что заббикс не умеет \)

my $cmd = "REG QUERY \"".$path."\" /v ".$arg; # Составляем команду
my $execut=`$cmd`; # Выполняем команду
$execut =~/.*0x([\d]*).*/; # Вырезаем значение то, что после 0x......
printf $1; # Выводим значение
