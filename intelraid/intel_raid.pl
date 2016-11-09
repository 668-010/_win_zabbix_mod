#!/usr/bin/perl

########################################################################################
# Проверка Intel RAID
# STATE проверяет статус RAID'a, если статус Normal, то отправляет 1, иначе 0
# CHECKING првоеряет установлен и работает ли Intel RAID
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
$regexist=`C:\\zabbix-agent\\_win_zabbix_mod\\intelraid\\reg_exist.bat`;
$checking=`rstcli -V 2>nul`;
if ($regexist eq "exist") {
if (grep{/Intel/} $checking) {$status = "1"}
else {$status ="0"}
print $status;
}
else {print "1"}
}


$param=@ARGV[0];
if ( $param eq "state" )        {state();exit 0;}
if ( $param eq "checking" )      {checking();exit 0;}