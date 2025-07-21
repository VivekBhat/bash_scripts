# Bash Scripts

### bash_profile
This bash profile is a helper script for me

## New OS Setup

```bash
export PROJECTS_FOLDER="$HOME/Projects"
git clone git@github.com:VivekBhat/bash_scripts.git $PROJECTS_FOLDER/bash_scripts
$PROJECTS_FOLDER/bash_scripts/installer.sh
```

### Troubleshoot
1. [How to Create Symbolic Links with mklink](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)
    ```
    mklink /D C:\Users\vivekbhat\Desktop "C:\Users\vivekbhat\OneDrive - Microsoft\Desktop"
    ```
2. Remove carriage 
    ```
    sed -i 's/\r$//' filename
    ```
