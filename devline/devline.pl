#!/usr/bin/perl
system("C:\\zabbix-agent\\_win_zabbix_mod\\devline\\devline.bat");

sub servers {

open (MYFILE, '<C:\\zabbix-agent\\_win_zabbix_mod\\devline\\ServersUTF.txt');
while (<MYFILE>) {
        @data = <MYFILE>;
}
close (MYFILE);

if (grep{/"save_password"	:true/} @data) {print "1"}
else {print "0"}
}


sub groups {

open (MYFILE, '<C:\\zabbix-agent\\_win_zabbix_mod\\devline\\GroupsUTF.txt');
while (<MYFILE>) {
        @data = <MYFILE>;
}
close (MYFILE);

if (grep{/"save_password"	:true/} @data) {print "1"}
else {print "0"}
}

$param=@ARGV[0];
if ( $param eq "servers" )				{servers();exit 0;}
if ( $param eq "groups" )				{groups();exit 0;}