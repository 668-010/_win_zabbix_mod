#!/usr/bin/perl

########################################################################################
# Проверка Intel RAID
# STATE проверяет статус RAID'a, если статус Normal, то отправляет 1, иначе 0
# CHECKING првоеряет установлен и работает ли Intel RAID, 0 - не работает, 1 - работает\не установлен, 2 - версии не совместимы.
########################################################################################

sub state  {
$rstcli=`rstcli -I -v 2>nul`;

if ($rstcli =~ /(.*)(State:)(\s*)(\w+)/) {
if ($4 eq "Normal") {$state = '1'}
else {$state = '0'}
}
print $state;
}


sub checking  {
$regexist=`C:\\zabbix-agent\\_win_zabbix_mod\\intelraid\\reg_exist.bat`;	#Батник проверяет есть ли каталог IRST в реестре.
$checking=`rstcli -V 2>nul`;
if ($regexist =~ /(.*)(installed)(.*)/)
{
	if (grep{/cannot be used/} $checking) {$status = "2"}
	else {
		if (grep{/Intel/} $checking) {$status = "1"}
		else {$status ="0"}
		 }
print $status;
}
else {print "1"}
}


$param=@ARGV[0];
if ( $param eq "state" )        {state();exit 0;}
if ( $param eq "checking" )      {checking();exit 0;}