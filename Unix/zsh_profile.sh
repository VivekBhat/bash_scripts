scriptDir=$(dirname "$0")

source $scriptDir/common

#--------------------------------------
# Function to Source bash profile
#--------------------------------------
src() {
	source ~/.zshrc
	echo "ZSH Profile Version: $ProfileVersion"
}
