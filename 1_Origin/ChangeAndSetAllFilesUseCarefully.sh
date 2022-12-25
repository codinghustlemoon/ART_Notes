#!/bin/bash

find . -path '*/*/*' -type f -print -exec sh -c '
   f="$1"
   d="${f%/*}"
   cd "$d" || exit 1
   d="${d##*/}"
   f="${f##*/}"
   e="${f##*.}"
   if [ "$e" = "$f" ]; then
      e=""
   else
      e=".$e"
   fi

   if [ "$f" = "directsubfolder.txt" ]; then
       filepath="$(pwd)"
	   filename="${d:2}"
	   filetitle="### $filename"
	   
	   childrenlink=$(find . -maxdepth 1 -type d | sed 's/$/]]/' | cut -c 3- | cut -c 3-)
	   echo "$childrenlink" > "$f"
	   sed -i -e 's/^/[[/' "$f"
	   sed -i 1d "$f"
   else
      echo ""
   fi
  ' find-sh {} \;

find -type d -links -3 -print0 | while read -d '' dir
do
    # check if it contains some files
    if ls -1qA "$dir" | grep -q .
    then
        echo "$dir"
	filename=$(find "$dir" -maxdepth 1 -type d | cut -c 3- | wc -l)
        if [ "$filename" -gt 1 ]; then
	        echo "not green file"
		echo "#Folder/Category" >> "$dir/directsubfolder.txt"
		echo "#Folder/Color/Blue" >> "$dir/directsubfolder.txt"
		echo "#Folder/Subcolor/2" >> "$dir/directsubfolder.txt"
	else
		echo "is a green file"
		echo "#Folder/Reference" >> "$dir/directsubfolder.txt"
		echo "#Folder/Color/Green" >> "$dir/directsubfolder.txt"
		echo "#Folder/Subcolor/1" >> "$dir/directsubfolder.txt"
        fi
    fi
done

find . -path '*/*/*' -type f -print -exec sh -c '
   f="$1"
   d="${f%/*}"
   cd "$d" || exit 1
   d="${d##*/}"
   f="${f##*/}"
   e="${f##*.}"
   if [ "$e" = "$f" ]; then
      e=""
   else
      e=".$e"
   fi

   filename="${d:2}"
   if [ "$f" = "$filename.md" ]; then
       echo "f is $f and d is $d"
       filepath="$(pwd)"
	   filetitle="### $filename"

	   echo "$filetitle" > "$f"
	   echo "$filepath" | cut -c 46- | sed 's/[1-9]_/#Root/' | sed 's/[1-9]_//g' | cut -c2- > "$f"
	   echo "#### Links" >> "$f"

	   echo "##### Parent Links" >> "$f"
	   parentdirpath="$(dirname "$filepath")"
	   parentdirname="${parentdirpath##*/}"
	   parentlink="[[${parentdirname:2}]]"
	   echo "$parentlink" >> "$f"

	   echo "##### Children Links" >> "$f"
	   cat directsubfolder.txt >> "$f"
	   cat manualnotation.md | tail -n +2 >> "$f"
   else
      echo "not folder file"
   fi
  ' find-sh {} \;
