# Windows helper script

## Stay Online (Move)

Scripts in the `Move` folder can help keep you online

### How to run the script
1. Open "Start"
2. Search and open "Windows PowerShell ISE" application
3. Press "Ctrl + O" to open the folder with Move scripts
4. Select the script/file you want to open
5. Press the Green button on top or go to "File" -> "Run" to run the script 

### Types of scripts
1. move.ps1 - Keep the system active indefinitely

## Cleanup
Scripts in the `Cleanup` folder can help you cleanup and organize the work folders 

### How to run the script

1. Open "Start"
2. Search and open "Windows PowerShell ISE" application
3. Press "Ctrl + O" to open the folder with Move scripts
4. Select the SingleCleanup.ps1 script/file and open
5. Press the Green button on top or go to "File" -> "Run" to run the script 


## Troubleshoot
### move.ps1 cannot be loaded because running scripts is disabled

```
PS C:\Users\vivek> move.ps1
File move.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
    + CategoryInfo          : SecurityError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnauthorizedAccess

```
Solution

The error you're seeing indicates that PowerShell's execution policy is set to restrict the running of scripts. You can change the execution policy to allow script execution. Here’s how to do it:

1. **Open PowerShell as Administrator**:
   - Right-click on the Start button and select "Windows PowerShell (Admin)" or "Terminal (Admin)" if you're on Windows 11.

2. **Check Current Execution Policy**:
   ```powershell
   Get-ExecutionPolicy
   ```

3. **Set Execution Policy**:
   You can change the policy to `RemoteSigned` or `Unrestricted`. Here’s how to set it to `RemoteSigned`, which allows scripts created on your local machine to run:
   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```
   If prompted, type `Y` to confirm.

4. **Run Your Script Again**:

#### Note
- Changing the execution policy can expose your system to risks if you're not careful about the scripts you run. Always ensure that scripts come from a trusted source.
- If you want to revert the policy later, you can use:
  ```powershell
  Set-ExecutionPolicy Restricted
  ```
