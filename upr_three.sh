zadachi - upr
find /tmp -readable
find /tmp -perm /u=r
find /tmp -readable -printf '%p %m/n'
find /tmp -readable -exec stat -c '%n %a' '{}' ';'

we can write in a file and redirect
s0600443@astero:~$ echo hello > output.txt
s0600443@astero:~$ cat output.txt
hello
s0600443@astero:~$ echo hi > output.txt
s0600443@astero:~$ cat output.txt
hi
s0600443@astero:~$ echo hello >> output.txt
s0600443@astero:~$ cat output.txt
hi
hello


cut -d : -f 5,6 /etc/passwd
cat /etc/passwd | cut-d : -f 5,6

print first 5 lines
cat /etc/passwd | head -n 5

cat /etc/passwd | head -n -5 -> gets all the lines without the final four lines
cat /etc/passwd | tail -c 56 ->the last 56 characters of the file

-c -> characters
-n -> lines

cat /etc/passwd | head -n 56 | tail -n 1
-gets the first 56 lines and then gets the last line from the tail

cat /etc/passwd | tail -n +56 | head -n 1
cat /etc/passwd | head -n 56 | tail -n 1 | tail -c 5
cat /etc/passwd | head -n 56 | tail -n 1 | cut -c 5,6

zad izvedete ot vtori do shesti simvol infoto vyv fajla
cat /etc/passwd | head -c 6 | tail -c +5

translates
s0600443@astero:~$ echo hello > p.txt
s0600443@astero:~$ cat p.txt
hello
s0600443@astero:~$ cat p.txt | tr 'ol' '65'
he556

upr 3 - treta grupa
symlink -> shortcut or like a pointer to a file
ln -s services serv_symlink
symlink - keeps the path to the file to which is pointing
-if we move the file in another directory then the symlink will break

we have inodes -> {inode1, inode2..} and the number of the inode - it says where the location is
on the disk from where to where - one inode cant point to another inode

inode - struct keeping where the file is kept
symlink is like a pointer to the file/dir

hardlink  two files with the same inode
how many hardlinks points to this inode
- its like a shared pointer - when the number of pointing to this inode objects become zero
then the inode is deleted as well as the symlink is like a pointer to pointer it points to the path
of the file

process - an instance of the program
when we start a program we can have multiple processes of the program -> we can
have many instances of the program

stdin -zero 
stdout -one
stderr -two

standart input - from files
head services > some_file.txt
we redirect the process

redirection
> we write to that file

create a file with the last fifteen lines from the document
tail -n 15 /etc/services > somi_file.txt

find -> subgroups
TESTS|-name
      -type
ACTIONS|-exec
        -printf
GLOBAL|-maxdepth

different combinations
s0600443@astero:~$ echo A; echo B
A
B
s0600443@astero:~$ echo A\; echo B
A; echo B
s0600443@astero:~$ echo a{b,c}
ab ac
s0600443@astero:~$ echo {a,x}{b,c}
ab ac xb xc

find . -name banica -exec cat {} \;

wc - word count
composition of multiple processes head /etc/services -n 5 | tail -n 1


pipelines 
in -> [head] -> out -> pipeline -> in -> [tail] -> pipeline -> [cut]
they connect to each other 
find . -type f -printf "%p %s\n" | sort -n | head -n 1 | cut -d ' ' -f 1
sort -n -> it sorts numerically

-xargs it turns the output of a function into an arguments for another function
xargs -I X cp X ~ 
-I means where we write X replace it with the output from the command
