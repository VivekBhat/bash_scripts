# bash_scripts

Run the `installer` to replace your bash_profile with this cool profile

## New OS Setup

* Decide a `$myHome`
* Create a folder called `Projects` to add projects in this `myHome` 
* Clone this repo in the `Projects` folder
* git clone https://github.com/VivekBhat/bash_scripts.git

## Troubleshoot
1. [How to Create Symbolic Links with mklink](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/)
    ```
    mklink /D C:\Users\vivekbhat\Desktop "C:\Users\vivekbhat\OneDrive - Microsoft\Desktop"
    ```
2. Remove carriage 
    ```
    sed -i 's/\r$//' filename
    ```
