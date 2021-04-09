# Scripts
## Devops Bootcamp Scripts 
#
Simple scripts that ware task from the bootcamp, Additional docunentation at each script.
#### Current included scripts:
#
##### My-Task-For-Task-Sheduler.ps1:
 - Prints text to notepad, open notepad then print text by vertical direction
 ##### Usage: 
#
 ```sh
.\My-Task-For-Task-Sheduler.ps1 -TextInput "TextThatIWantToBePrinted" -Miliceconds 120
```
 #####  Task-Sheduler-Manipulations.ps1:
- include 3 fsimple functions to manipulate task sheduler (create task,disable\enable task,show all tasks from sheduler)
 ##### Usage: 
#
 ```powershell
.\Task-Sheduler-Manipulations.ps1 -CreateTask:$true -DisableTask:$false -PrintAllTasks:$false -EnableTask:$false -TaskName "Some Name of task in task sheduler" -PathToExeForShedulerTask "C:\scripts\script.ps1" -RunTaskEveryMinute 10 -MaxTasksPrint 10
```
##### password-validator:
- simple sh script to validate strong password (include numeric num,lowercase,uppercase,len > 10)
##### Usage: 
#
 ```sh
./password-validator.sh "MyG00dPasswordThatHaveAllItsNeedToBeStrong991"
```
