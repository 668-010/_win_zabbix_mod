@echo off
copy C:\ProgramData\DevLine\Linia\servers.cfg C:\zabbix-agent\_win_zabbix_mod\devline\ServersUCS.txt /Y > nul
C:\zabbix-agent\_win_zabbix_mod\shell\iconv\bin\iconv.exe -f UCS-2LE -t utf-8 C:\zabbix-agent\_win_zabbix_mod\devline\ServersUCS.txt > C:\zabbix-agent\_win_zabbix_mod\devline\ServersUTF.txt
copy C:\ProgramData\DevLine\Linia\groups.cfg C:\zabbix-agent\_win_zabbix_mod\devline\GroupsUCS.txt /Y > nul
C:\zabbix-agent\_win_zabbix_mod\shell\iconv\bin\iconv.exe -f UCS-2LE -t utf-8 C:\zabbix-agent\_win_zabbix_mod\devline\GroupsUCS.txt > C:\zabbix-agent\_win_zabbix_mod\devline\GroupsUTF.txt