#!/bin/bash

#CheckScript.sh

#Program:
#	This program is used to console check function. 

#History
#2016/11/24	zhabi	First release


fileDate=$(date +%Y%m%d%H%M);
telnetLog=${fileDate}.log;
ScanResult=ConsoleCheck_${fileDate}.txt;

for ipAddr in $(cat ./list/cm32IpList.txt)
do
	echo -e "\n\n+++++" $ipAddr "+++++" >> ./Result/$telnetLog;
	
	#Take a ping test
	count=$(ping $ipAddr -c 10 | grep 'received' | awk -F ',' '{print $2}' | awk '{print $1}');

	if [ $count -ge 9 ]; then
		port=7001;
		while [ "$port" != "7033" ]
		do
			echo -e "\n####" $port "####" >> ./Result/$telnetLog;
			(sleep 2; echo -e "\n"; sleep 2;)| telnet $ipAddr $port >> ./Result/$telnetLog;
			port=$(($port+1));
		done;

	elif [ $count -lt 9 ]; then
		echo -e "!!!!unreachable!!!!\n"  >> ./Result/$telnetLog;
	fi

done;

for ipAddr in $(cat ./list/moxaIpList.txt)
do
	echo -e "\n\n+++++" $ipAddr "+++++\n" >> ./Result/$telnetLog;
	
	#Take a ping test
	count=$(ping $ipAddr -c 10 | grep 'received' | awk -F ',' '{print $2}' | awk '{print $1}');
	
	if [ $count -ge 9 ]; then
		port=4001;
		while [ "$port" != "4033" ]
		do
			echo -e "\n####" $port "####" >> ./Result/$telnetLog;
			(sleep 2; echo -e "\n"; sleep 2;)| telnet $ipAddr $port >> ./Result/$telnetLog;
			port=$(($port+1));
		done;
		
	elif [ $count -lt 9 ]; then
		echo -e "!!!!unreachable!!!!\n"  >> ./Result/$telnetLog;
	fi
	
done;

cat ./Result/$telnetLog | while read line;
do
	test=${line:0:2};
	#base on the device naming
	case $test in
		"++")
			echo $line >> ./$ScanResult
			;;
		"##")
			echo $line >> ./$ScanResult
			;;
		"AB")
			echo $line"......OK" >> ./$ScanResult
			;;
		"CD")
			echo $line"......OK" >> ./$ScanResult
			;;
		"!!")
			echo $line >> ./$ScanResult
			;;
	esac;
done;
