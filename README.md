---
tags: NonImportant
---
##### Creating New Folder
Make sure to add a directsubfolder.txt and a manualnotation.md file. the directsubfolder.txt is used by the bash script to automatically name what folders the currentfolder has, and to give automatic tags. The manualnotation.md file is used by the bash script to add any tags or other things to the foldername.md. Also make sure that there is a .md file that is the same name as the current folder name. When making a folder name make sure to name it with number_foldername.

```bash
find . -type d -exec sh -c 'for d; do touch "$d/directsubfolder.txt"; done' _ {} +
```
```bash
find . -type d -exec sh -c 'for d; do touch "$d/manualnotation.md"; done' _ {} +
```

To create directdubfolder.txt in all folders use in git bash 
```bash
find . -type d -exec sh -c 'for d;
	if test -f "directsubfolder.txt"; then
		echo "directsubfolder.txt exists"
	else
		do touch "$d/directsubfolder.txt" 
	fi; done' _ {} +
```
To create manualnotation.txt in all folders use in git bash 
```bash
find . -type d -exec sh -c 'for d;
	if test -f "manualnotation.txt"; then
		echo "manualnotation.txt exists"
	else
		do touch "$d/manualnotation.txt" 
	fi; done' _ {} +
```

##### Editing Folder
Remember to name the folder that already exists by using gitbash, git mv foldername newfoldername to properly change the foldername so that git later recognises the change. 

##### Creating New Note
create a folder with name number_Note_NoteFolderName, in that newly created folder make sure to add a directsubfolder.txt, and the name of the NoteFolderName.md file alongside any necessary images or resources. 

##### Graphview useful searches
For including Notes only
can edit tag:#IsNote to other type of Note
can edit tag:#Tier with / to add a certain tier
```bash
 -tag:#NonImportant tag:#RootOrigin tag:#IsNote tag:#Tier
```

For including Notes and Folders
can edit tag:#RootOrigin and add /folderstructure to reduce search to certain branch
```bash
 -tag:#NonImportant tag:#RootOrigin 
```

##### Use with Github

for updating and pushing current
```
git pull
git add **
git commit "message"
git push
```