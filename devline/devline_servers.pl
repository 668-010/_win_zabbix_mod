#!/usr/bin/perl


	# Ф-я считает кол-во каналов видео, данные берет из конфиг. файла ЛИНИИ
sub channels_count{
	my $file = 'C:\Program Files\DevLine\Line\CFG\CURRENT\video_state.cfg'; # Путь к файлу со списком каналов
	my $count = 0;
	
	open(FILE,$file);	# Открываем файл настроек ЛИНИИ
	while(my $line = <FILE>){
		if($line=~/device/){	# Считаем кол-во каналов (слов: device)
			$count++;
		}
	}
	print $count;	# Выводим кол-во каналов
	close(FILE);
}


$param=@ARGV[0];
if ( $param eq "channels" )				{channels_count();exit 0;}