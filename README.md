Read the documentation at the scripts that will provide additional information.

Scripts usage:

My-Task-For-Task-Sheduler:
Language: PS
Description: Print text to notepad
Usage: ./My-Task-For-Task-Sheduler [[optional][string]"Text input"] [[optional][uint32][miliceconds]80]

Task-Sheduler-Manipulations:
Language: PS
Description: Task sheduler manipolator script, can create task,disable or enable task,show all task with limit to show.
Usage: ./Task-Sheduler-Manipulations [[optional][switch]CreateTask:$true] [[optional][switch]DisableTask:$false] [[optional][switch]PrintAllTasks:$false] [[optional][switch]EnableTask:$false] [[optional][string]"Task Name"] [[optional][string]PathToExeForShedulerTask] [[optional][int][Run Task Every Minute] 10] [[optional][int][Max Tasks Print] 10]

password-validator:
Language: Shell
Description: Validate password for at least 10 len + one upper and one lower case char + at least one number
Useage: ./password-validator "MyG00dPassword"
