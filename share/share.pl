#!/usr/bin/perl
# Алерт = 1, успех = 0

$sharelist=`NET SHARE`;

sub root {
#Если расшарен корень любого диска
if ($sharelist =~ /[А-Яа-яA-Za-z0-9](\s+)(\w:\\)(\s+)(\w+)?/) {print '1';}
else {print '0';}
}


sub users {
#Если расшарен каталог Users на корне любого диска
if ($sharelist =~ /[А-Яа-яA-Za-z0-9](\s+)(\w:\\users)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}


sub czdir {
#Если есть шара в любую папку на дисках C и Z
if ($sharelist =~ /[А-Яа-яA-Za-z0-9](\s+)(C|Z)(:\\.*)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}


sub bases {
#Если есть шара в каталог с именами bases|base|базы|база
if ($sharelist =~ /[А-Яа-яA-Za-z0-9](\s+)(.*)(bases|base|Базы|базы|База|база)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}



$param=@ARGV[0];
if ( $param eq "root" )				{root();exit 0;}
if ( $param eq "users" )			{users();exit 0;}
if ( $param eq "czdir" )			{czdir();exit 0;}
if ( $param eq "bases" )			{bases();exit 0;}f