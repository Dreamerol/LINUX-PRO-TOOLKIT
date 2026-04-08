upr 5
--print all the count of fields
cat /srv/fmi-os/exercises/data/emp.data | awk 'BEGIN {sum = 0} { sum += NF} END {print sum}'

--print the longest line
NR - returns the current number of the line
cat /srv/fmi-os/exercises/data/emp.data | awk 'BEGIN {max_line = -1; max_len = 999} {if(length($3) > maxlen){max_len = length($3); max_line = NR}} END {print max_len}'

--print if seventeen characters or more per line
cat /srv/fmi-os/exercises/data/emp.data | awk '{if(length($0)>17) print $0}'


--print the current line
cat /srv/fmi-os/exercises/data/emp.data | awk '{$1 = NR; print}'

--swap the first and second field
cat /srv/fmi-os/exercises/data/emp.data | awk '{temp = $1; $1 = $2; $2 = temp} {print}'
cat /srv/fmi-os/exercises/data/emp.data | awk '{print $1 + $2}'

--get the right emails
not two sequent dots
cat file.txt | grep -E '^[a-zA-Z0-9_-]+(\.[._-]*[a-zA-Z0-9]+)*@[a-zA-Z0-9_][a-zA-Z0-9_]*(\.[a-zA-Z0-9_][a-zA-Z0-9_-]*)*$' | wc -l

modal text editor -> different modes / vim
vim -> :Tutor - tutorial 

reading command from shell script file .sh
s0600443@astero:~$ bash myFirstScript.sh
hello
bash file.sh

echo $?
-checking is everything alright
zero - everything is ok
else - an error occurred

if [[ "$#" -ne 5]]; then
-means if number of argumnets not equal to five then
$# - number of arguments

if [[ ! -r "$1"]]; then
echo "$1: can't read" > &2
exit 2
-if we cannot read the file 
fi

[[ ! -r "$1"]] && {"$1: can't read" > &2; exit 2}
-equivalent to the if statement
exit 2

echo 65656 | grep -E '^[0-9]+$'


shell script
  1 #!/bin/bash
  2
  3 echo hello
  4
  5 echo "$1"
  6
  7 if echo test; then
  8
  9 fi
 10
 11 while echo test; do
 12
 13 done
 14
 15 for var in a,b,c; do
 16
 17 done
 18
 19
 20 for var in 'a,b,c'; do
 21
 22 done
 23
 24 for var in $(cat file); do
 25
 26  done
 27

man test for checkin for skripts
[[ -n "$(echo 65656 | grep -E '^[0-9]+$')

if ! echo "$2" | grep -E '^[0-9]+$' >$2; then
echo "not a number"
exit 5
fi


[["$2" =~ [0-9]+$]] || {echo "not a number" } 

--zad eighty tree
echo {A..Z} - A B C ..... the whole alphabet

tr -d ' ' - deletes all the empty spaces

sed - stream/editor 
sed 's/<regex>/<replacement>/[g]'
echo 'Foo' | sed 's/o/a' -> 'Fao'
-just replaces the first match
echo 'Foo' | sed 's/o/a' -> 'Fao'
->global it replaces all the matched parts

cat fileone | tr -d 'o' 
cat fileone -> it deletes all the data in the file

sed -i -E 's/[[:lower:]]/\U&/g' fileone
convert lower to upper  U - means upper
's/[Fo]/&a/g' -it gets the matched part and adds a Faoaoa
if it matches F or o then add a right after it

cat fileone | grep -o '.' | sort |uniq -c|sort -n -r | head -n 5
cat fileone | sed -E 's/./&\n' for each char get a new line
man 5 /etc/passwd

cat /etc/passwd | cut -d':' -f | head -n 66 | tail -n 6 | sed -E 's/^.*(.)(.)$/\2\1/'
--we take the last two chars and swap their places two refers to the sublast char
tar --help
tar -xf songs.tar.gz

find . -type f | sed -E 's/.*-(.*)\(.*/\L\1/'
sed -E 's/^(.*) - .*/\1/' | sort | uniq | tr -d ' '
xargs -I X mkdir X
xargs mkdir {}

zad
zadachi
s0600443@astero:~$ echo "HPPLW ZDV WKH ILUVW WR OLYH RQ WKH URFNV. XUBBE MEHBT!" > izpit.txt
s0600443@astero:~$ cat izpit.txt
HPPLW ZDV WKH ILUVW WR OLYH RQ WKH URFNV. XUBBE MEHBT!
s0600443@astero:~$ mv izpit.txt cipher.txt
s0600443@astero:~$ cat cipher.txt
HPPLW ZDV WKH ILUVW WR OLYH RQ WKH URFNV. XUBBE MEHBT!
s0600443@astero:~$ cat cipher.txt | tr 'ABCDE....' 'DEFGH....'
HPPLW ZGV WKH ILUVW WR OLYH RQ WKH URFNV. XUEEH MHHET!
s0600443@astero:~$ echo {A..Z}
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
s0600443@astero:~$ cat cipher.txt | tr "$(echo {A..Z}

zad 83
 #!/bin/bash
 k=$1
  4 filepath=$2
  5
  6 words=$(cat "$filepath" | tr "$(echo {A..Z} | tr -d ' ')" "$(echo {A..Z} | tr -d ' ' \
  7 |cut -c $((k+1))-)$(echo {A..Z} | tr -d ' ' | cut -c -$k)"| sort | uniq)
  8
  9
 10 for word in $words; do
 11     if grep -i "\<$word\>" /usr/share/dict/words; then
 12     count=$((count + 1))
 13     fi
 14 done
 15
 16 echo "Number of words: $count"
 17


(()) - means arithmetic operation
-i ignore lower/upper letters

--PROCESSES
ps - process
PID - process ID
cmd - command

ps -e

UNIX STYLE: -e
BSD STYLE: a
GNU STYLE: --group

return the top ten oldest processes
ps -e -> to see all the processes
ps -ax
ps -e -o comm -> gives only the commands
-o which columns do we want
ps -e -o time -> gets the time

CPU time -> how much time they have been on the CPU processor
ygj/gjhji

