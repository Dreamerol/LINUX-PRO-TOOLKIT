zadachi - week two
1.Да се направи копие на файла в home directory /etc/passwd и да се прекръсти на my_passwd
cp /etc/passwd ~/my_passwd

2.cd ~
mkdir practise-test
cd practise-test
mkdir testone

second way in one command
mkdir -p ~/practise-test/testone
mv test.txt ../ -> it means with relative path to move the file to the upper directory
->move the file test.txt to the practise-test directory

3.create dirs. then create files and copy them to other directory
s0600443@astero:~$ mkdir dirone
s0600443@astero:~$ mkdir -p practice/01
s0600443@astero:~$ mkdir practice/zeroone
s0600443@astero:~$ cd practice/zeroone
s0600443@astero:~/practice/zeroone$ man touch
s0600443@astero:~/practice/zeroone$ touch fileone filetwo filethree
s0600443@astero:~/practice/zeroone$ ls
fileone  filethree  filetwo
s0600443@astero:~/practice/zeroone$ cp fileone filetwo filethree ~/dirone
s0600443@astero:~/practice/zeroone$ cd ~/dirone
s0600443@astero:~/dirone$ ls
fileone  filethree  filetwo

4.create new directory where we move a filetwo file and rename it as numbers
s0600443@astero:~/dirone$ cd ~
s0600443@astero:~$ mkdir dirtwo
s0600443@astero:~$ cd ~/dirone
s0600443@astero:~/dirone$ mv filetwo ~/dirtwo/numbers
s0600443@astero:~/dirone$ ls
fileone  filethree
s0600443@astero:~/dirone$ cd ~/dirtwo
s0600443@astero:~/dirtwo$ ls

5.list all directories in home dir
ls -d */ -> the / tells shell match only ahaa/ ->directories
find . -maxdepth 1 -type d -> list all the directories
. ->means current directory
-type d-> it means we search directories
on maxdepth one - so they are children of current dir

6.create a file for user - read  group - write and execute, others - read, execute
-r---wxr-x -the three bits for the user, for the groupr ,for the others we have 
s0600443@astero:~$ cd ~
s0600443@astero:~$ touch permissions.txt
s0600443@astero:~$ chmod u=r,g=wx,o=re permissions.txt
chmod: invalid mode: ‘u=r,g=wx,o=re’
Try 'chmod --help' for more information.
s0600443@astero:~$ chmod u=r,g=wx,o=rx permissions.txt
s0600443@astero:~$ ls -l permissions.txt
-r---wxr-x 1 s0600443 students 0 Mar  9 15:00 permissions.txt
s0600443@astero:~$ chmod 435 permissions.txt
s0600443@astero:~$ ls -l permissions.txt
-r---wxr-x 1 s0600443 students 0 Mar  9 15:00 permissions.txt

SEVEN
7.find the files modified in the last hour  
find . -type f -mmin -66
./practice/zeroone/filethree
./practice/zeroone/fileone
./practice/zeroone/filetwo
./.lesshst
./dirone/filethree
./dirone/fileone
./dirtwo/numbers
./permissions.txt
--only the files accessed in the last hour
find . -type f -amin 66

8.read from file if file exists
s0600443@astero:~$ if [ -f /etc/services ]; then
> cat /etc/services
> else cat /foo
> fi
# Network services, Internet style

9.create a symlink with name
ln -s /etc/passwd passwd_symlink

10.find all the regular files - not directories
find /etc -type f

11.get the first 5 lines of the file
cat /etc/services | head -n 5
 
12.get all the directories
find /etc -mindepth 1 -maxdepth 1 -type d
mindepth means etc/... so ~ is at level zero
find . /etc/*

13.get the first five lines -> of the previous command and write them in the file
s0600443@astero:~$ find /etc -mindepth 1 -maxdepth 1 -type d | head -n 5 > output.txt
s0600443@astero:~$ cat output.txt
/etc/perl
/etc/selinux
/etc/apticron
/etc/opt
/etc/kernel

14.find all the files from dir with size +bigger 56 bytes
c - bytes
+5c > bigger than
-6c < smaller than 6 bytes

15.find all files with write rights for the group or write rights of the others
find /tmp -group $(id -gn) -perm /g=w,o=w or 022

16.find all files created after this directory/or with file
find . -type f -newer practise-test

17.
find . -type f ! -newer practise-test -> the opposite of newer -> the previous files created before 
the practise-test

18.remove all the files from home directory newer than practice test
{} - placeholder ->here stays the name of the found file
find . -type f -newer practise-test -exec rm -i {} \; 
interactive mode -> first we must get a permission before deleting the file
rm: remove write-protected regular empty file './permissions.txt'?
 
find ~ -type f -size +56c

19.find all the files from bin - where the files can be read/write/executed from 
user, others, group
find /bin -type f -perm /777

20.find and copy all the readable files from everyone from one directory to the other
find /etc -type f -perm /444 -exec cp {} myetc \;

21.compress all the files starting with c.. in the myetc directory
tar -cvf c_start.tar myetc/c*
rm -r myetc -> deletes recursively all the files and subdirs in the current directory

22.print the count of lines of each ordinary file
find /etc -type f -exec wc -l {} \;

23.copy the smallest file to a dir
 cp "$(find /etc -type f -exec ls -l {} + | sort -k5 -n | head -n 1 | awk '{print$NF}' )" /tmp
$ - this means first executes the command in brackets and cp "result" -> the result from the function
cp "result" /tmp









