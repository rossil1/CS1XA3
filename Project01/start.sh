#!/bin/bash
cd ..
clear
while [ 1 ]
do
      echo -e 'Hello and welcome to the menu! Possible actions include:'
      echo -e '1) File Type Count\t\t2)Merge Log Search'
      echo -e '3) Exit\n\n'

      read -p "Enter the number of the action you'd like to preform: " SEL
      if [[ $SEL =~ [^0-9]+ ]]; then
	  echo -e "\nInput Error: Enter the number of the action you'd like to preform."
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  echo -e '\n\n'
	  continue
      fi

      if [ $SEL -eq 1 ]; then

	  ftcHTML="HTML:   "$(find . -regextype sed -regex ".*/*\.x\?html\?" -type f -printf '.' | wc -c)    
	  ftcJS="Javascript: "$(find . -regextype sed -regex "./*\.js" -type f -printf '.' |wc -c)
	  ftcCSS="CSS:    "$(find . -regextype sed -regex "./*\.css" -type f -printf '.' | wc -c)
	  ftcSH="Bash: "$(find . -regextype sed -regex "./*\.sh" -type f -printf '.' | wc -c)
	  ftcPY="Python: "$(find . -regextype sed -regex ".*/*\.py[cdomtwxz]\?w\?" -type f -printf '.' | wc -c)
	  ftcHSK="Haskell: "$(find . -regextype sed -regex ".*/*\.[hl][aih]\?[st]" -type f -printf '.' | wc -c)
	  echo -e "The main types of files in the repository are:\n"
	  echo -e $ftcHTML"\t\t"$ftcJS
	  echo -e $ftcCSS"\t\t"$ftcSH
	  echo -e $ftcPY"\t"$ftcHSK"\n"
    
	  read -p 'press a key to continue' -i "\n" -n 1 -s
	  echo -e '\n\n'
      fi

      if [ $SEL -eq 2 ]; then

	  echo -e "All the commits to this repo involving merges will have their hashs written into the local file merge.log.\n"
	  read -p 'Would you like the details of each change alongside the hashes(y/n):' DTLS

	  if [[ $DTLS =~ [yY].* ]]; then
	      git log --oneline | grep -Ei "*merge*" >./Project01/merge.log
	      echo -e "\n\n"
	  fi
	  if [[ $DTLS =~ [nN].* ]]; then
              git log --oneline | grep -Ei "*merge*" | cut -d' ' -f1 > ./Project01/merge.log
	      echo -e "\n\n"
	  fi
	  if [[ $DTLS =~ [^nNyY]* ]]; then
	      echo -e "Input Error: y or n, try again later.\n\n"
	  fi
      fi
      if [ $SEL -eq 3 ]; then
	  break
      fi
done
