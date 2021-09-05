# bash_scripts

### bash_profile
This bash profile is a helper script for me

Prereqs:
1. This project should be cloned only in the `$Home/Projects/` folder

### Installer
Run the `installer` to replace your bash_profile with this cool profile or run the following in terminal/wsl:
```
cp -f bash_profile ~/.bash_profile
chmod +x ~/.bash_profile
source ~/.bash_profile
echo "Bash Profile Version: $bashProfileVersion"
```

## Troubleshoot
1. [How to Create Symbolic Links with mklink](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)
    ```
    mklink /D C:\Users\vivekbhat\Desktop "C:\Users\vivekbhat\OneDrive - Microsoft\Desktop"
    ```
2. Remove carriage 
    ```
    sed -i 's/\r$//' filename
    ```
