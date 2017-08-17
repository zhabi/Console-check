#!/bin/bash

#Tree:
#├──start.sh
#└──folder
#    ├──scanner.sh
#    ├──infoAdd.sh
#    ├──list
#    │   ├──devInfoList
#    │   └──popInfoList
#    ├──log
#    │   └──$rawLog
#    └──testResult
#        └──$scanResult

echo -e '#####################################################################################################'
echo -e '#                                                                                                   #'
echo -e '#  This Script is used for console server port scanning. Kindly follow the guide to take the test.  #'
echo -e '#                                                                                                   #'
echo -e '#####################################################################################################'

# Menu
menu=1
while [ $menu == '1' ]
do
	echo -e '[1] Start the scanning;\n[2] Add New Device;\n[3] Exit'
	read -p 'ENTER YOUR SELECTION: ' slt
	if [ $slt == '1' ]; then
		cd folder
		sh ./folder/scanner.sh
		let menu++
	elif [ $slt == '2' ]; then
		cd folder
		sh ./folder/infoAdd.sh
		let menu++
	elif [ $slt == '3' ]; then
		exit
	else
		echo 'ILLEGAL INPUT'
	fi
done