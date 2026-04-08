--zadachi week3
--1
sort by userID
cat /etc/passwd | tr ':' ' '
sort -t: -k5 /etc/passwd

-t: - means delimiter we separate by :
-k5 - means sort by fifth field

sort -t: -k3 -k4 /etc/passwd -> sort by two fields first k3 and then k4

--2
sort -t: -k5 -n /etc/passwd - means numerical sort

--3
cut -d: -f1,5 /etc/passwd
get the first and the fifth column from the file

--4
cat /etc/passwd | cut -c 2-5
-get the symbols from the 2nd to 5th char on each row

--5
head -n 1 /etc/passwd | cut -c 2-6
get from 2-6th character in the file

cat /etc/passwd | cut -c 2-6 -> get from each row from 2-6char

--6
cut -d: -f5,6 /etc/passwd -> get the user names and their home directories

--7
cut -d/ -f2 /etc/passwd
get the second column with delimeter /

--8
wc -l /etc/passwd - gives the number of lines
wc -c /etc/passwd - the number of bytes
wc -m /etc/passwd - symbols
wc -w /etc/passwd - words

--9
a/ head -n 12 /etc/passwd
b/ head -c 26 /etc/passwd -first 26 symbols
c/ head -n -4 /etc/passwd
d/ tail 17 /etc/passwd
e/ head -n 151 /etc/passwd | tail -n 1 /etc/passwd
f/ head -n 13 /etc/passwd | tail -n 1 | tail -c 5

--10
we write in the filo
df -P > filo
cat filo | tail -n +1 | sort -n -k2
and get all the lines without the first one -sort by the second field

--11
cat /etc/passwd | cut -d: -f5 > users.txt
-write all the users in a file users.txt

--12
cat users.txt | tr '[:lower:]' '[:upper:]'
echo ahga | tr 'a' 'l'

--13
-A - after, -B -before prints the lines two lines before my name
grep searches strings
cat /etc/passwd | grep 'Михаела'
cat /etc/passwd | grep -B 2 'Михаела'
cat /etc/passwd | grep -A 3 -B 2 'Михаела'
cat /etc/passwd | grep -B 2 'Михаела' | head -n 1

--14
find the count of lines where the user is using bash
cat /etc/passwd | grep '/bin/bash' | wc -l
cat /etc/passwd | grep -v '/bin/bash' | wc -l
-v inverts the condition

--15
cut -d: -f5 /etc/passwd | cut -d' ' -f2 | awk '{
line=$0
gsub(/[^[:alpha:]]/,"",line)
if (length(line) >= 6) print $0
}'
--print all the surnames with size >= 6
-awk gets an expression that is evaluated independently of shell
gsub - replaces pattern,newpattern,target
^-negotiation
[]-character class

--16
names with len <= 7
cut -d: -f5 /etc/passwd | cut -d' ' -f2 | awk '{
line=$0
gsub(/[^[:alpha:]]/,"",line)
if (length(line) <= 7) print $0
}'

--17
awk -F: '{
> split($5,a," ")
> name = a[2]
> gsub(/[^[:alpha:]]/, "", name)
> if (length(name) >= 6) print $0
> }' /etc/passwd
 --print the whole line
split(from, container,delimiter)
name = a[2] - we get the second name

--18
wc -l /etc/passwd
cat /etc/passwd | head -n 3 | tail -n 1
awk '{ print $NF }' /etc/passwd
cat /etc/passwd | awk -F: '$1 == "565" {print $0}'
-print the line where the first field is 565
tail -n 1 /etc/passwd | awk '{ print $NF }'
-last field of the last line
cat /etc/passwd | awk -F: '{ if( NF >= 4) print $0 }'
-print the lines with number of fields >= 4 NF - means number of fields
cat /etc/passwd | awk -F: '{ if (length($NF) >= 4) print $0}' print if the last field is >= 4
cat /etc/passwd | awk '{ sum += NF} END { print sum }'
-all the number of fields from the file
cat /etc/passwd | awk '{ if($0 ~ /home/) print $0 }'
-print where home is a substring line is ~ home is in the line
cat /etc/passwd | awk '{ if(NF > 1) print $0 }'
cat /etc/passwd | awk '{ if(length($0) > 17) print $0 }'
-more than 17 symbols on a line
cat /etc/passwd | awk '{ print NF; print $0 }'
two prints
cat /etc/passwd | awk -F: '{ print $2; print $1 }'
-swap the fields
cat /etc/passwd | awk -F: '{ print $2; print ":"; print $1
for(i=3;i<=NF;i++) print $i; print ":" }'
-print and the other fields
 cat /etc/passwd | awk -F: '{ printf "%s:%s", $2, $1 }'
-printing the second column is the number of lines NF
cat /etc/passwd | awk -F: '{printf "%s:%d", $1, NF; for(i=3;i<=NF;i++)printf ":%s", $i; print "\n" }'
cat /etc/passwd | awk -F: '{count+=1;printf "%s:%d", $1,count ; for(i=3;i<=NF;i++)printf ":%s", $i;print }'
-the number of row
cat /etc/passwd | awk -F: '{printf "%s:", $1; for(i=3;i<=NF;i++)printf ":%s", $i;print }'
-without the second line
cat /etc/passwd | awk -F: '{ count = $1 + $2; print count }'
- sum the values of the second and first field
cat /etc/passwd | awk -F: '{
if(maxi > length($3)) maxi = length($3);maxilen = $0} END { print maxilen; print maxi; }'
print the line with biggest 3rd field

--print all the lines with biggest third field
cat /etc/passwd | awk -F: '{
len = length($3)
if(len > maxlen){
maxlen = len
delete lines
lines[NR] = $0
} else if(len == maxlen){
lines[NR] = $0
}} END {
for(i in lines) print lines[i]; print maxlen }'

--19
id -g s0600443
get the group id

--20
grep -o "#" /etc/services | wc -l
-count the number of comments-#

grep -c "2" /etc/services
count the number of lines containing 2

--21
file /bin/* | grep 'shell script' | wc -l
file - type of file command - get all the shell files

--22
find . -maxdepth 3 -type d ! -readable
-find the inaccessible files

--23
cat file1 file2 file3 | wc -l -> count all lines
s0600443@astero:~$ mkdir dir5
s0600443@astero:~$ cd dir5
s0600443@astero:~/dir5$ touch file1
s0600443@astero:~/dir5$ touch file2
s0600443@astero:~/dir5$ touch file3
s0600443@astero:~/dir5$ 1 > file1
-bash: 1: command not found
s0600443@astero:~/dir5$ echo 1 > file1
s0600443@astero:~/dir5$ echo 2 > file1
s0600443@astero:~/dir5$ echo 3 echo 4
3 echo 4
s0600443@astero:~/dir5$ echo 33 44 > file1
s0600443@astero:~/dir5$ echo a s e d > file2
s0600443@astero:~/dir5$ s "\n" > file2
-bash: s: command not found
s0600443@astero:~/dir5$ echo 1 > file3
s0600443@astero:~/dir5$ echo 2 >> file3
s0600443@astero:~/dir5$ cat file3
1
2
s0600443@astero:~/dir5$ cat file1 file2 file3 | wc -l
3
s0600443@astero:~/dir5$ ^C
s0600443@astero:~/dir5$ cat file1 | wc -l
1
s0600443@astero:~/dir5$ cat file1 | wc -m
6
s0600443@astero:~/dir5$ cat file2 | wc -w
0
s0600443@astero:~/dir5$ cat file1 file2 file3 | wc -w
-creating dir with files then we count the lines/words/symbols from the three files altogether

--24
cat file2 | tr '[:lower:]' '[:upper:]' > f2
sed -i 's/.*/\U&/' file2

-sed for replacement -> substitute .* - whole line \U& -> to uppercase
-i -> means in place - we modify the file in place

--25
sed -i 's/1//' file1 - replace all ones with nothing

--26
 fold -w1 file2 | uniq -c | sort -nr | head -n 1
find the most frequent character -> fold separates the files into characters than we sort it
and with unique function - we get the count of each of them/characters/ -nr sort descending get the first one

--27
 cat file1 file2 file3 > filiq
-write the files into one place

--28
cat file2 | tr '[:lower:]' '[:upper:]' >> file1
from lower to upper case and then write them to the file

--29
grep -o '[^a]' file1 | wc -l
-print the number of characters which are not 'a'

--30
cat /etc/passwd | cut -d: -f1 | fold -w1 | sort | uniq -c | wc -l
first we sort then uniq - cause uniq removes the consecutive characters
count the unique symbols from field one

--31
grep -v "ов" /etc/passwd
-v -inverts the condition -> grep the substring matching


--32
cat /etc/passwd | cut -d: -f1 | head -n 46 | tail -n 19 | rev | cut -c1
from the 28/46 get the last character -> rev reverses the word and cut -c1 -> get the first/last
character 

--33
find . -type f -readable -exec ls -l {} \;
list the permissions of all the files that are readable

--34
 find . -type f -mtime -1 | sort -nr | head -n 10
-mtime -number in the last number days 
sort -nr -> sort descending
print the last 10 modified files
mtime - modified
atime - accessed

--35
find /usr/include -type f | grep -Eo '\.h|\.s' |wc -l
-find all the files with .h or .s in the end
| -means or in regex
Eo - extended regex with or, and
-o -> print only the match

find /usr/include -type f -name "*.h" -o -name "*.s"
-o means or name like .h ending or .s ending

find /usr/include -type f -name "*.h" | wc -l
count .h files

--36
grep -Eo '\w+' /etc/services | sort | uniq -c | sort -nr | head -n 10
get the most frequent words from a file \w+ -> get the words

--37
cat /etc/passwd | cut -d: -f1 | sort > si.txt

--38
mygrp=$(id -gn) -> get the value inside the brackets
cat /etc/group | awk -F: -v line="$mygrp" '{
if(line == $1)
printf "Hello,I am here %s\n", line
else printf "HELLO %s\n", $1 }'

awk -v means execute the command $var ->get the value behind the var
%s -> replace with the word after the ,

--39
find /usr -type f -name "*.sh" -exec head -n 1 {} \; /
| sed 's/!#//' \ -removes these symbols with nothing
| grep -o '<[^>]+>' | tr -d '<>' \ -> -d -means deletes these symbols
| sort | uniq -c | sort -nr | head -n1

--40
cat /etc/passwd | cut -d: -f4 | sort | uniq -c | sort -nr | head -n 5
get the GID group ids with the most users

--41
find ~ -type f -mmin -15 -printf "%p %T@\n" > eternity
-> get the files that were modified in the last fifteen minutes
printf -> p - path, T@ - date

--42
cp /etc/passwd ~/lolo
-> copy a file

--43
cat population | awk -F: '{if($1 == 55) print $2 }'
print the value if the number is 55

--44
cat population | awk -F: '{
if($1 == "bulgaria" && maxi < $3){
maxi = $3
year = $2
}} END {
print year }'
-print the year with the most population in bulgaria 

--45
cat population | awk -F: '{
if($2 == 5 && maxi < $3){
maxi = $3
country = $1
}} END {
print country }'
-get the country with the most population in 5 year

-with the least population
cat population | awk -F: '{
if($2 == 5 && mini > $3){
mini = $3
country = $1
}} END {
print country }'

--46
pop=$(cat population | awk -F: '{ if($2 == 5) print $3 }' | sort -nr | head -n 1 | tail -n 1)
-get the population of the n/first/number-th country in year 5
cat population | awk -F: -v pop="$pop" '{ if($3 == pop) country = $1 } END { print country; print pop}'
-v execute the command and print the country with that population found in the first command /the nth country

--47
curl -o songs.tar.gz "http://fangorn.uni-sofia.bg/misc/songs.tar.gz"
curl  transfer data from the link and download the file behind the name songs.tar.gz

--48
tar -xzf songs.tar.gz -C ~/songs -rearchive gz files -xzf for gz files
-C means -> change directory to ~/songs and there tar the file
find songs -type f -exec basename {} \;

--49
find songs -type f -exec basename {} \; | cut -d- -f2 | grep -Eo "^[^(]+" | sed 's/^ //'
sed 's/^ //' remove the leading space 
^[^(]+ -> means the ^ in fornt of the [] - from the beginning of the line get if is not (
+ in Eo - extended -o
 echo "   ishs jka" | sed 's/^[ \t]*//'
-removes all the leading spaces

--50
find songs -type f -exec basename {} \; | cut -d- -f2 | grep -Eo "^[^(]+" | sed 's/^ //' | tr "[:lower:]" "[:upper:]" | sed 's/ /_/g' | rev | sed 's/_//' | rev | sort
-translates lower with upper , empty space with _ and rev - reverses the word
-sed 's/char//' replace th first occurrence
's/char//g' -> global - so replaces all the occurences
how to replace the last occurrence -> reverse the word and then use sed

--51
find songs -type f -exec basename {} \; | sort -t',' -k2 -n
-t - separator -k2 by the second field numerically

--52
cat songs.txt | awk -F- '{ if($1=="Beatles ") print $2 }' | grep -Eo "^[^(]+"
 cat songs.txt | awk -F- '{ if($1=="Beatles ") print $2 }' | wc -l
-get the names and the count of Beatles' albums
-analogically for Pink
cat songs.txt | awk -F- '{ if($1=="Pink ") print $2 }' | wc -l

--53
cat songs.txt | cut -d- -f1 | sed 's/ //g' | sort | uniq | while read album; do mkdir "$album"; done
while read var ->gets each line from the pipe output ,do sth and done is the end

--54
%s - gets the size, %p get the path -
file=$(find /etc -type f -printf "%s %p\n" 2>/dev/null | sort -nr | head -n 1 | cut -d' ' -f2)
perm=$(stat -c "%A" $file) - prints %A prints the permissions
ls -l | awk -F' ' -v p="$perm" '{ if(p==$1) print $0 }' -print the matching permissions
for each line if p==perm get the line/print/

--55
grep -Eo "[a-z]+@(gmail|mail)\.com" lolo
-matching regex for emails

--56
cat /etc/passwd | awk -F: '{
for(i=NF;i>=1;i--)
{ printf "%s", $i; 
if(i>1) printf ":"
} 
print "" }'
-print the fields in reverse order

--57
awk '/lolo/ { print $2}' lolo
-prints the second field and if the /pattern/ matches or is in a line - get the line

awk ' {/^Array / { array=$2 } 
/^physicaldrive/ { disk=$2 }
/Current Temperature/ { curr=$NF }
/Maximum Temperature/ { max=$NF; print array "-" disk, curr, max } ' ssa-input.txt
-print the right format
