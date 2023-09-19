export bashProfileVersion="4.6.9"

#--------------------------------------
# Personalized additions
#--------------------------------------

projectsFolder=$HOME/Projects
scriptsFolder=$projectsFolder/bash_scripts/Mac_Personal

# cd & ls in one
function chpwd() {
    emulate -L zsh
    ls
}

runCleanupScripts(){
	mkdir -p $projectsFolder
	$scriptsFolder/cleanup $HOME
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

echo $PATH