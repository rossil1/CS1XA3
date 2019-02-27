#!/bin/bash

if [ ! -d logs ]; then
    mkdir logs
fi
path=$(pwd)

while [ 1 ] 
do
 #TODO - add extra features just to have a good practice    
 #TODO - add more options to the todo comment recognition to allow better use for more programming languages.
      clear   
      echo -e 'Hello and welcome to the menu! Possible actions include:'
      echo -e '1) File Type Count\t\t2)Merge Log Search'
      echo -e '3) Todo Log Compliation\t\t4)Move to Another Folder'
      echo -e '5) Exit\n'
      
      read -t 0.01 -n 1000 tmp
      read -p "Enter the number of the action you'd like to preform: " SEL


      if [[ $SEL =~ [^1-9]+ ]]; then
	  echo -e "\nInput Error: Enter the number of the action you'd like to preform."
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  continue

     elif [ $SEL -eq 1 ]; then

	  ftcHTML="HTML:   "$(find $path/.. -regextype sed -regex ".*/*\.x\?html\?" -type f -printf '.' | wc -c)    
	  ftcJS="Javascript: "$(find $path/.. -regextype sed -regex "./*\.js" -type f -printf '.' |wc -c)
	  ftcCSS="CSS:    "$(find $path/.. -regextype sed -regex "./*\.css" -type f -printf '.' | wc -c)
	  ftcSH="Bash: "$(find $path/.. -regextype sed -regex "./*\.sh" -type f -printf '.' | wc -c)
	  ftcPY="Python: "$(find $path/.. -regextype sed -regex ".*/*\.py[cdomtwxz]\?w\?" -type f -printf '.' | wc -c)
	  ftcHSK="Haskell: "$(find $path/.. -regextype sed -regex ".*/*\.[hl][aih]\?[st]" -type f -printf '.' | wc -c)
	  echo -e "Some of the types of files in the repository, and the number of that type are as follows:\n"
	  echo -e $ftcHTML"\t\t"$ftcJS
	  echo -e $ftcCSS"\t\t"$ftcSH
	  echo -e $ftcPY"\t"$ftcHSK"\n"
    
	  read -p 'press a key to continue' -i "\n" -n 1 -s

      elif [ $SEL -eq 2 ]; then
	  cd $path/..
	  echo -e "All the commits to this repo involving merges will have their hashs written into the local file merge.log.\n"
	  read -t 0.01 -n 500 tmp
	  read -p 'Would you like the details of each change alongside the hashes(y/n):' DTLS
	  
	  if [[ ! $DTLS =~ [yYnN].* ]]; then
	      echo -e "Input Error: y or n, try again later.\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  elif [[ $DTLS =~ ^[yY].* ]]; then
	      git log --date=short --pretty=format:"%h - %cn, %cd : %s" | grep -Ei "*merge*" >$path/logs/merge.log
	      echo -e "File created in the local logs folder\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  
	  elif [[ $DTLS =~ ^[nN].* ]]; then
              git log --oneline | grep -Ei "*merge*" | cut -d' ' -f1 > $path/logs/merge.log
	      echo -e "File created in the local logs folder\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  fi
      elif [ $SEL -eq 3 ]; then
	  cd $path/..
	  n=0
	  for f in "$(grep -cr -E '[#][Tt][Oo][Dd][Oo][- ]' | grep -i -E '[^0]$' | cut -d: -f1)"
	  do
	      if [[ $f == *[/]* ]]; then
		  fn="$(basename $f)"
	      else
		  fn="$f"
	      fi

	      if [ $n -eq 0 ]; then
		  echo "$fn" > $path/logs/todo.log
	      else
		  echo "\n$fn" >> $path/logs/todo.log
	      fi

	      echo "$(grep -o -E '[#][Tt][Oo][Dd][Oo][- ][[:alnum:][:space:][:punct:]]*' $f | cut -d: -f2)" >> $path/logs/todo.log
	       n=$[n+1]
	  done
  
	  echo -e '\nProcess complete, a record of all subjects marked todo have been compiled and saved to todo.log in the logs folder.'
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  continue
    
      elif [ $SEL -eq 4 ]; then
	  read -t 0.01 -n 500 tmp
	  read -p "What is the parent folder of the project you would like to move the diagnostics program to: " tmpPath

	  if [ ! -d $tmpPath ]; then
	      echo -e "\nYou've entered a folder which does not exist. Please check the path, and try again another time."
	      read -p 'press a key to continue' -i "\n" -n 1 -s
    	      continue
	  fi

	  if [ ! -d diagnostics ]; then
	      mkdir $tmpPath/diagnostics
	  fi

	  cp $path/project_analyze.sh $tmpPath/diagnostics/project_analyze.sh

	  read -p "Would you like to switch the program to work on your new location(y/n): " fs

	  if [[ ! $fs =~ [yYnN].* ]]; then
	      echo -e "Input Error: y or n, try again later.\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  elif [[ $fs =~ ^[yY].* ]]; then
	      path=$tmpPath
	      echo -e "All operations done will now affect $path\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  
	  elif [[ $fs =~ ^[nN].* ]]; then
	      echo -e "All operations done will still only affect $path\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  fi
	  continue
      elif [ $SEL -eq 5 ]; then
	  clear
	  break
      fi
      
done
