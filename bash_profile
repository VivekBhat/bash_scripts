#!/bin/bash
export bashProfileVersion="3.0.1"

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' 
# printf "By ${RED}Vivek Bhat ${NC}\n"

if [ "$(uname)" == "Darwin" ]; then
    echo "This is Vivek's Mac"
    myHome=/Users/bhatvive
	scriptsFolder=$myHome/Documents/Projects/bash_scripts
	folder="Mac"        
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	export DOCKER_HOST=tcp://localhost:2375
    myHome=/c/Users/bhatvive
	storage=/d
	if [ "$HOSTNAME" = 'bhatvive-DESK' ]; then
		folder="Workstation"	
	else
		folder="Windows"
	fi
	echo "This is Ubuntu $folder"
fi

runCleanupScripts(){
	$scriptsFolder/cleanup $myHome
}
runCleanupScripts

updatebashscript(){
	cp $scriptsFolder/bash_profile ~/.bash_profile
	chmod +x ~/.bash_profile
}

#--------------------------------------
# Function to move to desktop quickly
#--------------------------------------

desktop () {
	cd $myHome/Desktop
	echo "Moved to Desktop :) "
}

#--------------------------------------
# Function to move to CDO Projects quickly
#--------------------------------------

cdo () {
	cd $storage/Documents/Projects/CDO/$folder
	echo "Moved to CDO folder :) "
}

#--------------------------------------
# Function to open Visual studio code
#--------------------------------------

vscode () {
	echo "Opening Visual Studio Code $2" 
	if [ $folder == "Mac" ]; then
		open $1 -a /Applications/Visual\ Studio\ Code.app 
	elif [ $folder == "Windows" ]; then
		$myHome/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe $1
	elif [ $folder == "Workstation" ]; then
		$myHome/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe $1
	fi
}

#--------------------------------------
# Function to open Sublime Text
#--------------------------------------

subl(){
	open ${1} -a /Applications/Sublime\ Text.app 
}

#--------------------------------------
# Function to edit bash_profile
#--------------------------------------

prof(){
	echo "Opening Visual Studio Code to edit the bash profile"
	desktop 1>/dev/null
	vscode Misc/bash_scripts 1>/dev/null
}

#--------------------------------------
# Function to Source bash profile
#--------------------------------------
src(){
	source ~/.bash_profile
	echo "Bash Profile Version: $bashProfileVersion"
}

# Source: http://patorjk.com/software/taag/#p=display&f=Graffiti&t=bhatvive

#--------------------------------------
# :-|
#--------------------------------------
vivek(){
printf "${CYAN}
:'#######::'########::'##::::'##::::'###::::'########:'##::::'##:'####:'##::::'##:'########:
'##.... ##: ##.... ##: ##:::: ##:::'## ##:::... ##..:: ##:::: ##:. ##:: ##:::: ##: ##.....::
 ##'### ##: ##:::: ##: ##:::: ##::'##:. ##::::: ##:::: ##:::: ##:: ##:: ##:::: ##: ##:::::::
 ## ### ##: ########:: #########:'##:::. ##:::: ##:::: ##:::: ##:: ##:: ##:::: ##: ######:::
 ## #####:: ##.... ##: ##.... ##: #########:::: ##::::. ##:: ##::: ##::. ##:: ##:: ##...::::
 ##.....::: ##:::: ##: ##:::: ##: ##.... ##:::: ##:::::. ## ##:::: ##:::. ## ##::: ##:::::::
. #######:: ########:: ##:::: ##: ##:::: ##:::: ##::::::. ###::::'####:::. ###:::: ########:
:.......:::........:::..:::::..::..:::::..:::::..::::::::...:::::....:::::...:::::........::
${NC}
"
}

checking(){
	echo "checking"
}

openexplorer(){
	if [ -z "$1" ]
	then
		path="."
	else
		path="$1"
	fi
	echo "Opening $path"
	explorer.exe `wslpath -w $path`
}


alias ll='ls -l'
alias lla='ls -la'
# alias browser="explorer.exe"
#TODO: explorer.exe `wslpath -w "$PWD"`
# alias exp="explorer.exe `wslpath -w "$1"`"
# alias pip=pip3

DOCKER_ID_USER="vivekbhat"

export AWS_ACCESS_KEY="AKIAQN4XIN6OPIFYL27H"
export AWS_SECRET_KEY="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"

export COINBASE_API_KEY="VREYe8IJnKVJjllf"
export COINBASE_API_SECRET="DF6Geu8qljKTnLAOjfjqbyKUdJZQEHuZ"

export BITTREX_API_KEY="a0e3c0ea743b4e559c570bcd39fd236a"
export BITTREX_API_SECRET="6e8c23ca1a1b492a97f9782ff11ae2b6"

export ALEXA="amzn1.ask.skill.584432f0-752c-4cf9-aa20-1c1792d3e702"


export http_proxy=http://proxy-chain.intel.com:911
export https_proxy=http://proxy-chain.intel.com:912
export ftp_proxy=http://proxy-chain.intel.com:911
export socks_proxy=http://proxy-us.intel.com:1080
export no_proxy=intel.com,.intel.com,localhost,127.0.0.1

export HTTP_PROXY=http://proxy-chain.intel.com:911
export HTTPS_PROXY=http://proxy-chain.intel.com:912
export FTP_PROXY=http://proxy-chain.intel.com:911
export SOCKS_PROXY=http://proxy-us.intel.com:1080
export NO_PROXY=intel.com,.intel.com,localhost,127.0.0.1
export PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

export RPA_DB_USERNAME=retailpromot_0_ro
export RPA_DB_PASSWORD=tRfW6B1Ev0qG5I0
export RPA_DB_NAME=retailpromotionsanalytics_tes
export RPA_DB_HOST=postgres5078-us-fm-in.icloud.intel.com

# export DOCKER_CERT_PATH=$myHome/.docker/machine/certs
# export DOCKER_TLS_VERIFY=1