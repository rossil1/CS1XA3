#!/bin/bash

if [ ! -d logs ]; then
    mkdir logs
fi

cd ..

while [ 1 ] #TODO - look at new features to put into the file
do          #TODO - optimize and rethink the stock desc. for all
    clear   #TODO - named features. Rethink for things maybe wanted
    echo -e 'Hello and welcome to the menu! Possible actions include:'
      echo -e '1) File Type Count\t\t2)Merge Log Search'
      echo -e '3) Exit\n\n'

      read -p "Enter the number of the action you'd like to preform: " SEL
      if [[ $SEL =~ [^0-9]+ ]]; then
	  echo -e "\nInput Error: Enter the number of the action you'd like to preform."
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  echo -e '\n\n'
	  continue

     elif [ $SEL -eq 1 ]; then

	  ftcHTML="HTML:   "$(find . -regextype sed -regex ".*/*\.x\?html\?" -type f -printf '.' | wc -c)    
	  ftcJS="Javascript: "$(find . -regextype sed -regex "./*\.js" -type f -printf '.' |wc -c)
	  ftcCSS="CSS:    "$(find . -regextype sed -regex "./*\.css" -type f -printf '.' | wc -c)
	  ftcSH="Bash: "$(find . -regextype sed -regex "./*\.sh" -type f -printf '.' | wc -c)
	  ftcPY="Python: "$(find . -regextype sed -regex ".*/*\.py[cdomtwxz]\?w\?" -type f -printf '.' | wc -c)
	  ftcHSK="Haskell: "$(find . -regextype sed -regex ".*/*\.[hl][aih]\?[st]" -type f -printf '.' | wc -c)
	  echo -e "Some of the types of files in the repository, and the number of that type are as follows:\n"
	  echo -e $ftcHTML"\t\t"$ftcJS
	  echo -e $ftcCSS"\t\t"$ftcSH
	  echo -e $ftcPY"\t"$ftcHSK"\n"
    
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  echo -e '\n\n'

      elif [ $SEL -eq 2 ]; then

	  echo -e "All the commits to this repo involving merges will have their hashs written into the local file merge.log.\n"
	  read -p 'Would you like the details of each change alongside the hashes(y/n):' DTLS
	  
	  if [[ ! $DTLS =~ [yYnN].* ]]; then
	      echo -e "Input Error: y or n, try again later.\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  elif [[ $DTLS =~ ^[yY].* ]]; then
	      git log --date=short --pretty=format:"%h - %an, %ad : %s" | grep -Ei "*merge*" >./Project01/logs/merge.log
	      echo -e "File created in the local logs folder\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  
	  elif [[ $DTLS =~ ^[nN].* ]]; then
              git log --oneline | grep -Ei "*merge*" | cut -d' ' -f1 > ./Project01/logs/merge.log
	      echo -e "File created in the local logs folder\n\n"
	      read -p 'press a key to continue' -i "\n" -n 1 -s
	      
	  fi
	  
      fi
      if [ $SEL -eq 3 ]; then
	  clear
	  break
      fi
done
