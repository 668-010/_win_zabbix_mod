#!/usr/bin/perl

########################################################################################
#                    APCUPSD perl script for Zabbix monitoring                         #
#           by Tabaev Ilfat, Store IT Solutions, Orenburg, 2016.10.17                  #
#                                                                                      #
########################################################################################

#Checking Operating System (Windows or Linux)
$isWindows=`echo %OS%` eq "Windows_NT\n";


if ($isWindows) {
$apcupsd=`C:\\Program Files\\apcupsd\\bin\\apcaccess.exe`;
} else
{
$apcupsd=`apcaccess`;
}




#################################################################

sub battv  {
if ($apcupsd =~ /(BATTV)(\s*)(\:)(\s)(\d+\.?\d*)/) {
print $5;
}
}

sub bcharge  {
if ($apcupsd =~ /(BCHARGE)(\s*)(\:)(\s)(\d+)/) {
print $5;
}
}

sub dwake  {
if ($apcupsd =~ /(DWAKE)(\s*)(\:)(\s)([+-]?\d+)/) {
print $5;
}
}

sub itemp  {
if ($apcupsd =~ /(ITEMP)(\s*)(\:)(\s)(\d+)/) {
print $5;
}
}

sub linev  {
if ($apcupsd =~ /(LINEV)(\s*)(\:)(\s)(\d+\.?\d*)/) {
print $5;
}
}

sub loadpct  {
if ($apcupsd =~ /(LOADPCT)(\s*)(\:)(\s)(\d+\.?\d*)/) {
print $5;
}
}

sub model  {
if ($apcupsd =~ /(MODEL)(\s*)(\:)(\s)(.*)/) {
print $5;
}
}

sub nombattv  {
if ($apcupsd =~ /(NOMBATTV)(\s*)(\:)(\s)(\d+\.?\d*)/) {
print $5;
}
}

sub outputv  {
if ($apcupsd =~ /(OUTPUTV)(\s*)(\:)(\s)(\d+\.?\d*)/) {
print $5;
}
}

sub sense  {
if ($apcupsd =~ /(SENSE)(\s*)(\:)(\s)(\w+)/) {
    if ($5 eq "High" ) {print "0"}
    else {print "1"}

}
}

sub status  {
if ($apcupsd =~ /(STATUS)(\s*)(\:)(\s)(\w+)/) {
    if ($5 eq "ONLINE" ) {print "1"}
    if ($5 eq "REPLACEBATT" ) {print "2"}
    if ($5 eq "ONBATT" ) {print "3"}
    if ($5 eq "COMMLOST" ) {print "4"}
    if ($5 eq "LOWBATT" ) {print "5"}
}
}

sub testdata  {
if ($apcupsd =~ /(HOSTNAME)(\s*)(\:)(\s)(\w+)/) {
    if ($1 eq "HOSTNAME" ) {print "1"}
    else {print "0"}
}
}

sub timeleft  {
if ($apcupsd =~ /(TIMELEFT)(\s*)(\:)(\s)(\d+)/) {
print $5;
}
}


$param=@ARGV[0];
if ( $param eq "battv" )        {battv();exit 0;}
if ( $param eq "bcharge" )      {bcharge();exit 0;}
if ( $param eq "dwake" )        {dwake();exit 0;}
if ( $param eq "itemp" )        {itemp();exit 0;}
if ( $param eq "linev" )        {linev();exit 0;}
if ( $param eq "loadpct" )      {loadpct();exit 0;}
if ( $param eq "model" )        {model();exit 0;}
if ( $param eq "nombattv" )     {nombattv();exit 0;}
if ( $param eq "outputv" )      {outputv();exit 0;}
if ( $param eq "sense" )        {sense();exit 0;}
if ( $param eq "status" )       {status();exit 0;}
if ( $param eq "testdata" )     {testdata();exit 0;}
if ( $param eq "timeleft" )     {timeleft();exit 0;}