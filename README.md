# pwsh-man-highlighting
Coloring PowerShell manual pages.

![Preview](https://github.com/digitalguy99/pwsh-man-highlighting/assets/52367722/eebfb032-d0d0-41d9-9cc6-0e2e61868875)

## Installation & Usage

### PowerShell 7.2 and Up
---

1. Run PowerShell as Administrator.

2. Execute the following command:

    ```pwsh
    Install-Module man-highlighting
    ```
    
    and if you face any errors running that command, run:
    
    ```pwsh
    Install-Module man-highlighting -AllowClobber
    ```
 
3. Restart PowerShell and run:

   ```pwsh
   Import-Module man-highlighting
   ```
   
   or simply:
   
   ```pwsh
   echo "Import-Module man-highlighting" >> $profile
   ```
   
   so you don't have to import the module every time you open PowerShell.
   
4. Execute the program:
   
   ```pwsh
   Get-Help <name of cmdlet>
   ```

### Other PowerShell Versions
---

1. Clone the repository to local machine:

   ```pwsh
   git clone https://github.com/digitalguy99/pwsh-man-highlighting.git
   ```

2. Use `cd` to navigate to local repository: 

   ```pwsh
   cd <path of directory>
   ```

3. Put `man.ps1` in your `$env:PATH` directory:

   ```pwsh
   mv man.ps1 <$env:PATH directory>
   ```

4. Execute the program:

   ```pwsh
   man <name of cmdlet>
   ```

## Credits

<table>
  <tr>
    <td align="center"><a href="https://stackoverflow.com/users/7571258/zett42" target="_blank"><img src="https://i.sstatic.net/cIcvv.jpg?s=256" width="100px;" alt=""/><br /><sub><b>zett42</b></sub></a><br /></td>
  </tr>
</table>
