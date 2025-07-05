#--------------------------------------
# Personalized additions
#--------------------------------------

bashProfileVersion=1
projectsFolder=$HOME/Projects
scriptsFolder=$projectsFolder/bash_scripts/Mac

# cd & ls in one
function chpwd() {
    emulate -L zsh
    ls
}

runCleanupScripts(){
	mkdir -p $projectsFolder
	$scriptsFolder/cleanup $HOME
}

updatezshcript(){
    echo "Updating zsh script :) "
	cp $scriptsFolder/zshrc ~/.zshrc
	chmod +x ~/.zshrc
    echo "run src to source the new profile"
}

#--------------------------------------
# Function to move to desktop quickly
#--------------------------------------

desktop () {
	cd $HOME/Desktop
	echo "Moved to Desktop :) "
}

openProjects(){
	cd $projectsFolder/$1
	echo "Moved to $1 folder :) "
	# No space after $1 is intentional 
}
#--------------------------------------
# Function to edit zshrc
#--------------------------------------

prof(){
	echo "Opening Visual Studio Code to edit the bash profile"
	cd $scriptsFolder
	code . 1>/dev/null
}

#--------------------------------------
# Function to Source bash profile
#--------------------------------------
src(){
	source ~/.zshrc
	echo "Bash Profile Version: $bashProfileVersion"
}

#--------------------------------------
# Function to write notes
#--------------------------------------

notes(){
	echo "Let's take notes"
	cd $projectsFolder/Notes
	code . 1>/dev/null
}

runCleanupScripts
# export PATH=$PATH:/Users/vivekbht/.toolbox/bin
# export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/node@14/bin:$PATH"
export PATH="/Users/vivekbht/.toolbox/bin:$PATH"
export PATH="/bin:$PATH"

# export PATH="/usr/local/opt/node@14/bin:/Users/vivekbht/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# export PATH="/usr/local/opt/node@14/bin:/Users/vivekbht/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/curl/bin:/Users/vivekbht/aws-cli/bin:/Users/vivekbht/.toolbox/bin"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
echo $PATH
# /Users/vivekbht/.toolbox/bin
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/vivekbht/.toolbox/bin
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/Users/vivekbht/.toolbox/bin