#!/usr/bin/perl
# ����� = 1, �ᯥ� = 0

$sharelist=`NET SHARE`;

sub root {
#�᫨ ���७ ��७� ��� ��᪠
if ($sharelist =~ /[�-��-�A-Za-z0-9](\s+)(\w:\\)(\s+)(\w+)?/) {print '1';}
else {print '0';}
}


sub users {
#�᫨ ���७ ��⠫�� Users �� ��୥ ��� ��᪠
if ($sharelist =~ /[�-��-�A-Za-z0-9](\s+)(\w:\\users)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}


sub czdir {
#�᫨ ���� �� � ���� ����� �� ��᪠� C � Z
if ($sharelist =~ /[�-��-�A-Za-z0-9](\s+)(C|Z)(:\\.*)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}


sub bases {
#�᫨ ���� �� � ��⠫�� � ������� bases|base|����|����
if ($sharelist =~ /[�-��-�A-Za-z0-9](\s+)(.*)(bases|base|����|����|����|����)(\s+)?(\w+)?/i) {print '1';}
else {print '0';}
}



$param=@ARGV[0];
if ( $param eq "root" )				{root();exit 0;}
if ( $param eq "users" )			{users();exit 0;}
if ( $param eq "czdir" )			{czdir();exit 0;}
if ( $param eq "bases" )			{bases();exit 0;}f