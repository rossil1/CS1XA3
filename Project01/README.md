# Repo Analysis

This project gives access to the use of methods which allow the user
to keep track of key information generated from within the
repository.

When launched, the script will show the user all available functions,
and it will ask the use to enter the number of the function they
would like to use. After this point the script loops through the
following:

	1. Preform the action it describes.
	2. Displays the result.
	3. Asks the user to press a key to continue.
	4. Clear the screen and return to the initial menu.

When asked for input at any point of the program, if improper input
is given the user is given an error report and is returned to the
initial menu.

From this point forward, all functions within the script are named,
and their purpose and results will be listed directly after.

## File Type Count
   Here the script polls the repository for all files related to
HTML, JavaScript, CSS, Bash, Python, and Haskell.Once a count of all
files directly related to these topics is taken, a grid of
"fileType: value" is presented.

## Merge Log Search
   The script generates a list of the hashes where the topic of a
merge was mentioned. When chosen, the script asks the user if
they would like a minimum report, or a detailed report. The minimum
report lists only the hash codes of all matching cases. The detailed
report gives a bit more per match, with the notation:

       hashcode - authorName, dateOfCommit : commitMessage

## Todo Log Compilation
   The script searches recursively from the parent folder through all child folders for parts of the code marked 'todo' directly following the initial comment flag.

## Move to Another Folder
   The final method is available to make the resources of this script useful in a user's own project. The user is asked for the path to the parent folder, if there are no mistakes and the directory exists the script creates a 'diagnostics' directory and recreates the script in that directory. At the end of the method, the user is asked if they'd like to continue to use the script in the new location they've specificed.
   
## Exit
   As the script is set within an infinite loop, when exit is
selected the script breaks from the loop and ends the script.