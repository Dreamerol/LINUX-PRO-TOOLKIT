tasks sbornik

\--zad1

grep -E '\[^a-w]\*' philip.txt | grep -E '\[02468]' | wc -l - matches

\-> first we pass the name of the file

then we get the lines when matching not a-w

'.'- means random symbol



then we match the lines - '\[abv]' -> does anything from the class \[56..] - is in the line

cat /srv/sample-data/01-shell/2016-SE-01/philip-j-fry.txt

| grep -E '\[02468]' | grep -E -v  --color  '\[a-w]' | wc -l

\-v -> means inverted



grep -E '\[02468]' | grep -E --color  '^\[^a-w]\*$' -from the beginning to the end symbols that are not a to w

^ - start

$ - end



\--zad2

idea

ls -l | awk -F' ' -v id="$(whoami)" '{ if(id==$3) print $0 }' | wc -l

ls -l ->works only for the current directory

solution:

find / -user "$(whoami)" 2> /dev/null | wc -l

find / -> searches from the whole filesystem



\-exec command {} + - run it as many files as you can

\-exec command {} \\; -> end of command

awk by default if we dont pass delimiter removes all the whitespaces



find / -exec ls -l {} \\; 2> /dev/null | awk -v user="$(whoami)" '{if($3 == user) print user}' | wc -l

super slow



find / -exec ls -l {} + 2> /dev/null | awk -v user="$(whoami)" '{if($3 == user) print user}' | wc -l



\--zad3

a/ find / -type f -empty -printf "%f\\n" 2> /dev/null

-find / -type f -size 0 -printf "%f\\n" 2> /dev/null

\->print all the empty files

print all the empty files -empty

b/ ls -l | sort -nr -k5 | head -n 5 | awk '{for(i=9;i<=NF;i++) printf $i " "; print ""}'

\-> print the filenames of the biggest files in ls the fifth field is the size and from the ninth it is the name



\--zad4

echo djhdjdj | head -c 3 | tail -c +2 -> to get the 2nd and 3rd symbol

\-> split method \[field, array,delimiter]

\-> \~ like regex like



grep ",,,,SI" /etc/passwd | awk -F: '{split($5,n,",");split(n\[1], m, " ");

-if(m\[2] \~ /а$/) print $0}' | cut -d: -f1 | head -c 3 | tail -c +2

| sort | uniq -c | sort -nr | head -n 1



\--zad5

print the files with the most hardlinks

the second field of ls

ls -l | sort -nr -t' ' -k2 | head -n 5 | awk -F' ' '{for(i=9;i<=NF;i++) printf $i " "; print " " }'

ls / -l | sort -nr -t' ' -k2 | head -n 5 | awk -F' ' '{for(i=9;i<=NF;i++) printf $i " "; print " " }' -from the current directory



\--zad6

find \~ -type d -exec chmod 755 {} \\;

or

find \~ -type d -exec chmod 755 {} +



chmod changes the permissions

so dirs are 777 and the umask is 022 -> so we get 755



\--zad 7

or \~

find /home/pesho -type f -links +1 -printf "%T@ %i %p\\n" | sort -nr | head -n1 | awk '{print $2}'

T@ -> gives as the modified time by seconds

%i -> gives us the inode

%p -> path

\-links +1 -> means the file has more than one hardlink -> more than one name



\--zad 8

cat /etc/passwd | awk -F: '{split($5, n ,","); print n\[1] ":" $6}' | sort -t/ -k4

\-> sort by faculty number and print the name, directory of the student



\--zad 9

vim file.txt

redactor

:q! -> quit every time

:w -> writes ina file



first way the first planet of the type of the last planet printed

typi="$(cat planets.txt |tail -n +2| sort -t';' -k3|tail -n1|cut -d';' -f2)"

cat planets.txt | tail -n +2 | sort -t';' -k3

| awk -v user="$typi" -F';' '{if($2 == user) print $0}' |

-head -n 1 | awk -F';' '{print $1 " " $4}'



checking whether the closest and the farthest planet are from the same type if yes print the name and mass of the planet

cat planets.txt | tail -n +2 | sort -t';' -k3 | head -n 1 | awk -v user="$typi" -F';' '{if(user == $2) print $1 "\\t" $4}'

\->prints with tabs formatted

cat planets.txt | awk -F';' '{print $1 "\\t" $2}'





\--10

date -d @4242425 "%Y%m%d%H%M"

date -d @2656262 "%Y%m%d%H%M"

touch -t 425242222 start

touch -t 425425452 end

find /home/SI -mindepth 1 -maxdepth 1 -type d -cnewer start ! -cnewer end \\

> | xargs -n1 basename \\\\\\\\

> | xargs -I{} grep "^{}:" /etc/passwd \\\\\\\\

> awk -F: '{ fn=substr($1,2); split($5, a, ","); print fn "\\\\\\\\t" a\\\\\\\[1] }'



\--11

a/ino=$(find /home/velin -type f -printf '%@T %i %p\\n' | sort -n | tail -n 1 | awk '{print $2}')

find /home/velin -type f -inode "$ino" -printf '%d'

%d - means depth

%@T - get the time of modification

%i - gets the inode

%p - gets the path



b/find /home/velin -type f -printf '%d %p' | sort -n | head -n 1| awk '{print $2}'| xargs -n1 basename



\--12

find \~ -type f -perm 644 -exec chmod g+w {} \\;



\--13

uniq -c -> count

cosmo=$(cat cosmos.txt | tail -n +2 | awk -F'|' '{if($3=="Failure") print $2}' | sort | uniq -c| sort -nr | head -n 1)

cat cosmos.txt | awk -v com="$cosmo" -F'|' '{if($2==com) print $0}' | sort -t' ' -k1 | tail -n 1 | cut -d'|' -f4



\--14

first version

-find \~ -type f -maxdepth 1 -exec ls -l {} \\; | awk -v user=$(whoami) -F' ' '{if(user==$3) print $NF }' | xargs-n chmod 664

find \~ -type f -maxdepth 1 -user $(whoami) -exec chmod 664 {} \\;



\--15

find \~ -type f -user "$(whoami)" |grep -E '.blend<\[0-9]+>$'



\--16

find /var/log/my\_logs -type f | grep -Eo '<\[a-zA-Z0-9\_]+>\_<\[0-9]+>.log' | xargs -n1 grep -o 'error' | wc -l



s0600443@astero:\~$ cat philip.txt | grep -o '3' | wc -l -> prints all the parts matching

3

s0600443@astero:\~$ cat philip.txt | grep '3' | wc -l -> prints the lines matching

2



\[ks...] - match any character inside

\[a-zA-Z0-9\_.]+@(mail|gmail).com - email regex

\-script



\--17

-1 #!/bin/bash

- 2

- 3 dir="$1"

- 4

- 5 if \[ -d "$dir" ]; then

- 6     find "$dir" -type l -exec test -d {} \\; -print

- 7 else

- 8     echo "Not a directory"

- 9 fi



zad 18

-1 #!/bin/bash

- 2

- 3 LIMIT=$1

- 4

- 5 if \[ "$EUID" -ne 0 ]; then

- 6 echo "This script is root"

- 7 exit 2

- 8 fi

- 9

-10 ps -eo user,pid,rss --no-headers | awk -v limit="$LIMIT" '

-11 {

-12 user=$1; pid=$2; rss=$3

-13 total\[user]+=rss

-14 if(rss>max\_rss\[user]) {max\_rss\[user]=rss; max\_pid\[user]=pid}

-15 }

-16 END

-17 {

-18 for(u in total){

-19 print "User: " u ", TOTAL RSS: " total\[u]

-20 if(total\[u]>limit){

-21 print "Exceeds limit"

-22 system("kill -15" max\_pid\[u])

-23 }

-24 }

-25 }'

\--pid - process id we get the process ID

\--kill -15 -> means kill immediately



\--19

-1 #!/bin/bash

- 2 for dir in /home/\*; do

- 3 user=$(basename "$dir")

- 4 if \[ -w "$dir" ]; then

- 5 echo "User $user cannot write $dir"

- 6 fi

- 7 done



\-w means is dir writable from the user

also we can use for file in $(find \~ -type f) -> we can loop through files



\--20

\#!/bin/bash



dirone="a"

dirtwo="b"

dirthree="c"

mkdir "$dirone" "$dirtwo" "$dirthree"



first=$1

second=$2





for file in ./\*; do

-   if \[ -d "$file" ]; then continue

-   fi

-   lines=$(wc -l < "$file")



-   if \[ "$lines" -lt "$first" ]; then

-       mv "$file" "$dirone"

-   elif \[ "$lines" -ge "$first" ] \&\& \[ "$lines" -lt "$second" ]; then

-       mv "$file" "$dirtwo"

-   else

-       mv "$file" "$dirthree"

-   fi

done



\--21

sed 's/^\[\[:space:]]\*//' -> removes all the leading empty spaces



-#!/bin/bash

- 2

- 3 fileone="$1"

- 4 filetwo="$2"

- 5

- 6 nameone="$(basename "$fileone")"

- 7 nametwo="$(basename "$filetwo")"

- 8

- 9->grep -o gets 'only' the matching part

-10 numlinesone=$(cat "$fileone" | grep "$nameone" | wc -l)

-11 numlinestwo=$(cat "$filetwo" | grep "$nametwo" | wc -l)

-12

-13 if \[ $numlinesone -ge $numlinestwo ]; then

-14 cat "$fileone" | awk -F' - ' '{print $2}' | sort > "$nameone.songs"

-15 else

-16  cat "$filetwo" | awk -F' - ' '{print $2}' | sort  > "$nametwo.songs"

-17 fi



\--22

cat books.txt | awk -F' - ' '{ print NR ". " $2 $3 }' | sort -t' ' -k2

-#!/bin/bash

- 3 file="$1"

- 5 cat "$file" | awk -F' - ' '{ print NR ". " $2 $3 }' | sort -t' ' -k2



\--23

-#!/bin/bash

- 2 file="$1"

- 3 key1="$2"

- 4 key2="$3"

- 5

- 6 str1=$(grep "^$key1=" "$file"|cut -d"=" -f2)

- 7 str2=$(grep "^$key2=" "$file"|cut -d"=" -f2)

- 8

- 9 newval=""

-10 for term in $str2; do

-11 if ! \[\[ "$str1" =\~ "$term" ]]; then

-12 newval="$newval$term "

-13 fi

-14 done

-15 newval=$(echo "$newval" | sed 's/ $//')

-16

-17 sed -i "s/^$key2=.\*/$key2=$newval/" "$file"



=\~ - means does the left operand contains the right \[\[]]

only in double quotes we can get the variables' value "$var"

\--we need sed with double quotes cause of the key



\--24

\#!/bin/bash



if \[ $# -ne 1 ]; then

exit 1

fi

-$# - means number of positional arguments

FOO="$1"

if \[ "$EUID" -ne 0 ]; then

echo "Not root"

exit 2

fi



a/

foo\_count=$(ps -u "$FOO" --no-headers | wc -l)

\--ps -u shows all the current processes of the user



for user in $(cut -d: -f1 /etc/passwd); do

-   count=$(ps -u "$user" --no-headers | wc -l)

-   if \[ "$count" -gt "$foo\_count" ]; then

&#x09;echo "$user"

-   fi

done



b/

total\_time=0

total\_count=0



for time in $(ps -eo time --no-headers); do

h=$(echo "$time" | cut -d: -f1)

m=$(echo "$time" | cut -d: -f2)

s=$(echo "$time" | cut -d: -f3)



seconds=$((10#$h\*3600 + 10#$m\*60 + 10#$s))

total\_time=$((total\_time + seconds))

total\_count=$((total\_count + seconds))

done

avg=$((total\_time/ total\_count))



echo "AVG: $avg"

c/

//pid= means take the lines without the headers

ps -u "$FOO" -o pid=,time= | while read -r pid time; do

h=$(echo "$time" | cut -d: -f1)

m=$(echo "$time" | cut -d: -f2)

s=$(echo "$time" | cut -d: -f3)



seconds=$((10#$h\*3600 + 10#$m\*60 + 10#$s))

if \[ "$seconds" -gt $((2 \* avg)) ]; then

kill -15 "$pid"

fi

done



\--25

\#!/bin/bash

if \[ "$EUID" -ne 0 ]; then

echo "Run as root"

exit 1

fi



recent\_file=$(find /home -type f -printf "%T@ %u %p\\n" | sort -nr | head 1)

if \[ -z "$recent\_file" ]; then

echo "No files"

exit 1

fi



user=$(echo "$recent\_file" | awk '{print $2}')

file=$(basename "$(echo "$recent\_file" | cut -d' ' -f3-)")

\-> -f3- means take everything from the third field to the end



echo "User $user"

echo "File: $file"



\--26

\->number of hard links the second field from ls

\#!/bin/bash

dir="$1"

one=$2

two=0

if \[ ! -d "$dir" ]; then

exit 1

fi



if \[ #$ -gt 2]; then

two=$2

fi



if \[ $two -ne 0]; then

for line in $(find \~ -type f -exec ls -l {} +); do

h=$(echo line |cut -d' ' -f2)

if \[ $h -gt two ]

echo "$file"

fi

done



else

find "$dir" -type l ! -exec test -e {} \\;

fi



\->test -e means check if exists

find \~ -type f -exec ls -l {} + | sort -t' ' -k2

find \~ -type l ! -exec test -e {} \\;

\--finds all broken symlinks



\--27

\#!/bin/bash



src="$1"

dst="$2"



niz="$3"



if \[ ! -d "$src" ] || \[ ! -d "$dst" ]; then

exit 1

fi



find "$src" -type f -name "\*$niz\* -exec mv {} "$dst" \\;



\--28

\#!/bin/bash

if \[ "$EUID" -ne 0 ]; then

echo "Run as root"

exit 1

fi



ps -eo pid,rss,user --no-headers | awk '

{

pid=$1

rss=$2

user=$3

count\[user]++

total\_rss\[user]+=rss

if(rss > max\_rss\[user]){

max\_rss\[user]=rss

max\_pid\[user]=pid

}

-}

END {

for u in count {

print "Count" count\[u] total\_rss\[u]

}

for u in count {

avg = total_rss[u] / count\[u]

if(max_rss[u] > 2*avg) {

-   cmd = "kill -15" max_pid[u]

-   system(cmd)

-   print "Killing process" max_pid[u]

-       }

}

}'



\--29

\#!/bin/bash

dir="$1"

file="$2"



brokenlinks=$(find \~ -type l ! -exec test -e {} \\; | wc -l)



if \[ -z $file ]; then

---prints to the stdout

-find \~ -type l -exec ls -l {} \\; | grep -Eo "/.\*"

-print "Num broken $brokenlinks"

else

\--prints to the file

-find \~ -type l -exec ls -l {} \\; | grep -Eo "/.\*" > "$file"

-print "Num broken $brokenlinks" >> "$file"

with >> -> not overwriting

fi



\--30

\#!/bin/bash

dir="$1"

niz="$2"

find "$dir" -type f -exec basename {} \\; | grep -E "$niz$" | sort -t- -k2 | tail -1



\--31



\--32

\->In awk we can only assign field values like that $i only in the '{}' outside we can't do this

\--solution

\#!/bin/bash

file="$1"

out="$2"

cat "$file" | awk -F',' '{ key =$2 "," $3 "," $4

if(mp\[key] < $1) mp\[key] = $1} END { for(l in mp) print mp\[l] "," l}' > "$out"





\--35

a/

\#!/bin/bash

tmp=$(touch tmp.txt)

cat > "$tmp.txt"

max\_abs=0



while read line; do

if \[\[ "$line" =\~ ^-?\[0-9]+$ ]]; then

abs=$(echo "$line" | sed 's/-//')

if \[ $abs -gt $max\_abs ]; then

max\_abs=$abs

fi

fi

done < "$tmp"



sort "$tmp" | uniq | while read line; do

if \[\[ "$line" =\~ ^-?\[0-9]+$ ]]; then

abs=$(echo "$line" | sed 's/-//')

      if \[ $abs -e $max\_abs ]; then

-       echo "$line"

-      fi

-

fi

done



b/

\#!/bin/bash

tmp=$(touch tmp.txt)

cat > "$tmp"



grep "^-?\[0-9]+$" "$tmp" | awk '

function digit\_sum(n){

if(n < 0) n =-n

s = 0

for(i = 1;i<length(n); i++) {

-   d = substr(n, i, 1)

-   s += d

-   }

return s

}



{ val = $0

- s = digit\_sum(val)

if(s > max) {

max\_sum = s

}



\--sums the digits in a number

cat /etc/passwd | awk -F: '{s=0; for(i = 1; i <= length($3);i++) s+=substr($3, i, 1); print s}'

\-getting the biggest sum of digits

cat numbers.txt | sed 's/-//' | awk '{s=0; for(i = 1; i <= length($0);i++) s+=substr($0, i, 1);print s}' | sort -nr | head -1





\--

biggestsum=$(cat numbers.txt | sed 's/-//' | awk '{s=0; for(i = 1; i <= length($0);i++) s+=substr($0, i, 1);print s}' | sort -nr | head -1



-cat numbers.txt | awk '{s=0;word=$(sed 's/-//' "$0"); for(i = 1; i <= length(word);i++) s+=substr(word, i, 1);if(biggestsum == s)print $0}' | sort -nr | head -1



\--final solution b/-----------------------------------

\#!/bin/bash

tmp=$(touch tmp.txt)

cat > "$tmp"



grep "^-?\[0-9]+$" "$tmp" > numbers.txt

biggestsum=$(cat numbers.txt | sed 's/-//' | awk '{s=0; for(i = 1; i <= length($0);i++) s+=substr($0, i, 1);print s}' | sort -nr | head -1)



cat numbers.txt | awk  '{word = ($0 \~ /^-/ ? substr($0, 2) : $0); s=0; for(i = 1; i <= length($word);i++) s+=substr($word, i, 1);if(biggestsum == s)print $0}' | sort -nr | head -1



\--substr(str, idx\_start, how\_long) by default to the end of the str

\~ is like /^-/ -> if it starts with -



\--zad 52

\#!/bin/bash



isJava=''

hasJar=''



main\_args=''

options=''

filename=''

\-z -> checks is an empty string

while \[\[ "${#}" -gt 0 ]]; do

-   if \[\[ "${1}" == 'java' ]]; then

-   isJava='true'

-   elif \[\[ "${1}" == '-jar' ]]; then

-   hasJar='true'

-   elif \[\[ ! -z "${hasJar}" ]] \&\& \[\[ -z "${filename}" ]] \&\& echo "${1}" | grep -qE '^\[^-]'; then

filename="${1}"

-   elif \[\[ ! -z "${hasJar}" ]] \&\& echo "${1}" | grep -qE '^-D\[^\[:space:]]+=\[^\[:space:]]+$'; then

options=$(echo "${1} ${options}")

-   elif \[\[ -z "${hasJar}" ]] \&\& echo "${1}" | grep -qE '^-D\[^\[:space:]]+=\[^\[:space:]]+$'; then

shift

continue

elif echo "${1}" | grep -qE '^\\-'; then

variables=$(echo "${1} ${variables}")

fi

shift

done



if \[\[ -z "${isJava}" ]]; then

echo "Missing java command"

exit 1

fi



if \[\[ -z "${hasJar}" ]]; then

echo "Missing jar command"

exit 2

fi



echo "java ${options} -jar ${filename} ${variables}"



\--zad 53

!#/bin/bash



if \[\[ "${#}" -ne 1 ]]; then

echo "Invalid amount of parameters" 1>\&2 

exit 1

fi

\--1>\&2 -> redirect the normal output stream to the stderr



if \[\[ ! -d "${1}" ]]; then

echo "not a valid dir" 1>\&2

exit 2

fi



if \[\[ ! -e "${1}/foo.conf" ]]; then

echo "${1}/foo.conf not found" 1>\&2

exit 3

fi



if \[\[ ! -e "${1}/foo.pwd" ]]; then

echo "${1}/foo.pwd not found" 1>\&2

exit 4

fi



if \[\[ ! -e "${1}/cfg" \&\& ! -d "${1}/cfg" ]]; then

echo "${1}/cfg not found" 1>\&2

exit 5

fi



if \[\[ ! -e "${1}/validate.sh" ]] \&\& \[\[ ! -f "${1}/validate.sh" ]]; then

echo "not a valid script" 1>\&2

exit 6

fi



\-> -e means does exist

new\_conf=$(mktemp)



while read conf\_file; do

err\_file=$(mktemp)



${1}/validate.sh "${cont\_file}" > "${err\_file}"

if \[\[ "${?} -eq 0 ]]; then

\--> "${?}" - stores the last exit status of the last executed command

cat "${conf\_file}" >> "${new\_conf}"



\--grep pattern filename

user="$(basename ${cont\_file} | cut -d '.' -f 1)"

if grep -q "${user}" "${1}/foo.pwd"; then

continue

else

password=$(pwgen -1)

echo "${user}:$(mkpasswd ${password})" >> "${1}/foo.pwd"
--mkpasswd hashes the password
fi

elif [[ "${?}" -eq 1 ]]; then
cat "${err_file}" | awk -v user="${conf_file}:" '{print user, $0} 1>&2
else
echo "Validating ${conf_file} failed" 1>& 2
rm "${new_conf}" "${err_file}"
exit 3
fi

rm "${err_file}"

done < <(find "${1}/cfg" -type f -name '*.cfg')

cat "${new_conf}" > "${1}/foo.conf"
rm "${new_conf}"

grep -v -> inverts the match

ls -i /tmp/file.txt - gets the inode - File ID

--zad 60



if [[ "${#}" -ne 2 ]]; then

-   echo "Wrong number of params"

-   exit 1

fi



fi [[ -d "${2}" ]]; then

-   echo "${2} is not a dir"

-   exit 2

fi



while read filename; do

-   while read word; do

-   censor=$(echo "${word}" | tr '\[A-Za-z]' '\*')

-   sed -iE "s/\b${word}/\b${censor}/g" "${filename}"

-   done < "${1}"

done < <(find "${2}" -type f -name '\*.txt')



--zad 61 

number="${1}"

shift

-> means get the next arguments without the first one

counter=0

elapsed\_time=0



while [ $(echo "${elapsed\_time} ${number}" | awk '$1 < $2 {}' '\*') == 1 ]; do

before=$(date +'%s.%N')

(s{@} &>/dev/null)

after=$(date +'%s.%N')

duration=$(echo "${after} -${before}" | bc)

elapsed_time=$(echo "${elapsed\_time} + ${duration}" | bc)

counter=$(( "${counter} + 1))

done

avg=$(echo "scale=2; ${elapsed\_time} / ${conter}" | bc)

rounded=$(echo "scale=2; ${elapsed\_time} | bc)

echo "AVG ${avg}"

echo "Ran ${@} for ${rounded} seconds ${counter} times"

--zad 62
#!/bin/bash

if [[ ${#} -ne 1 ]]; then
echo "Invalid number of args"
exit 1
fi

dir="${1}"
if [[ ! -d "$dir" ]]; then
echo "Not a dir"
exit 2 
fi
words=$(find "$dir" -type f -exec cat {} \; | grep -Eo "[a-z]+" | sort | uniq)
stop_words=$(mktemp)

num_files=$(find "$dir" -type f | wc -l)
half=$((num_files/2))

for word in $words; do
total_occ=0
files_with_three=0
while read -r file; do
count=$(grep -Eo "\b$word\b" "$file" | wc -l)
total_occ=$((total_occ + count))

if [[ $count -ge 3 ]]; then
files_with_three=$((files_with_three + 1))
fi
done < <(find "$dir" -type f)

if [[ $files_with_three -ge $half ]]; then
echo "$word $total_occ" >> "$stop_words"
number=$(find "$dir" -type f -exec grep -E "${word}" {} \; | wc -l)
if [[ $number -ge 3 ]] && [[ $number -gt $num_files ]]; then
${word} $number >> stopwords
done

sort -t' ' -nr -k2 | head -n 10
cat "$tmp" | sort -t' ' -nr -k2 | head -n 10

tr -s -> remove repeated characters

--zad 68
file="${1}"
shift

rules=$(mktemp)
temps=$(mktemp)

for arg in "$@"; do
   if [[ "$arg" =~ ^-R ]]; then 
   echo "$arg" | sed 's/-R//' >> "$rules"
   pwgen -s 16 1 >> "temps"
   else
   echo "Invalid arg"
   exit 1
fi
done

paste "$rules" "$temps" | while read rule tmp; do
old=$(echo "$rule" | cut -d= -f1)
sed -i -E "s/\b${old}\b/${tmp}/g" "$file"
done

paste "$rules" "$temps" | while read rule tmp; do
new=$(echo "$rule" | cut -d= -f2)
sed -i -E "s/\b${tmp}\b/${new}/g" "$file"
done

rm -f "$rules" "$temps"

-> paste concatenates two files
fileone
a
b
c
filetwo
d
e
f
->
a d
b e
c f

--zad 69
#!/bin/bash

-> -z checks whether the string is empty

if [ -z "$PASSWD" ]; then
    lu=$(cat /etc/passwd)
    lu_arr=$(cat /etc/passwd | cut -d':' -f1)
else
     u=$(cat "$PASSWD")
    lu_arr=$(cat "$PASSWD" | cut -d':' -f1)
fi

pu=$(./occ user:list) // list all the users
pu_arr=$(./occ user:list | grep "user_id" | cut -d ':' -f2 | tr -d ' ')

for user in ${lu_arr[@]}; do
   if echo "$pu" | grep -q "$user"; then
      if echo $(./occ user:info "$user") | grep -q "disable"
./occ user:unable "$user"
fi
else
./occ user:add "$user"
fi

done

for user in ${pu_arr[@]}; do
    if ! echo "$lu" | grep -q "$user"; then
        if echo $(./occ user:info "$user") | grep -q "enable"; then ./occ user:disable "$user"
        fi
fi
done

--zad 76

#!/bin/bash

if [[ "{#}" -ne 2 ]]; then

-  echo "Incorrect amount of parameters" >\&2

-  exit 1

fi



if [[ ! -f "${1}" ]]; then

-  echo "${1} not a proper file" >\&2

-  exit 2

fi



if [[ ! -f "${2}" ]]; then

-  echo "${2} not a proper file" >\&2

-  exit 3 

fi



antlrfile="${1}"

input_file="${2}"



base_input=$(basename "${2}" | cut -d '.' -f 1)



while read line; do

lang=$(echo "${line}" | cut -d ' ' -f 1)

base_dir=$(echo "${line}" | cut -d "'" -f 2)

new_dir=$(echo "${base_dir}/${base_input}")

options=""



if echo "${line}" | grep -qE "^\[ ]\*${lang}\[ ]+(\[^-]\*)visitor(.\*)'\[ ]\*\\$"; then

options="${options} -visitor"

fi



if echo "${line}" | grep -qvE "^\[ ]\*${lang}\[ ]+(\[^-]\*)listener(.\*)'\[ ]\*\\$"; then

options="${options} -no-listener"

fi



echo "antlr4 -Dlanguahe=${lang} ${options} -o ${new\_dir} ${input\_file}"



done < "${antlrfile}"



grep -v ->invert the match


--zad 77





--zad 80

!#/bin/bash

dir="$1"



if \[\[ ! -d "$dir" ]]; then

echo "Not valid"

exit 1

fi



if \[\[ $EUID -eq 0 ]]; then

chgrp -R "$(stat -c "%G" "$DIR")" "$DIR"

chmod -R 770 "$DIR"

chmod g+s "$DIR"

\->g+s -> means for all groups set the bits

else

if id -nG "$USER" | grep -qw "$(stat -c "%G" "$DIR")"; then

umask 007

else

exit 2

-fi

fi









\--zad 81

\#!/bin/bash

if \[\[ "${#}" -ne 1 ]]; then

echo "Invalid" >\&2

exit 1

fi



if \[\[ ! -d "${1}" ]]; then

echo "Is not a dir">\\\&2

exit 2

fi



DIR="${1}"

mkdir -p "${DIR}/.data"



while read filename; do

hashed=$(sha256sum "${filename}" | cut -d ' ' -f 1)

if \[\[ -f "${DIR}/.data/${hashed}" ]]; then

rm "${filename}"

else

mv "${filename} "${DIR}/.data/${hashed}"

fi





relative\_symlink=$(realpath "${DIR}/.data/${hashed}" --relative-to="$(dirname ${filename})")

ln -s "${relative\_symlink}" "${filename}"

\-> --relative-to - gets the relative path to the file 

\-> absolute paths dont work for symlinks when moving dirs

\-> so we need to get the relative path

done < <(find "${1}" -type f | grep -vE "^${DIR}/\\.data")

-







\--zad 83

-#!/bin/bash

-k=$1

- 4 filepath=$2

- 5

- 6 words=$(cat "$filepath" | tr "$(echo {A..Z} | tr -d ' ')" "$(echo {A..Z} | tr -d ' ' \\

- 7 |cut -c $((k+1))-)$(echo {A..Z} | tr -d ' ' | cut -c -$k)"| sort | uniq)

- 8

- 9

-10 for word in $words; do

-11     if grep -i "\\<$word\\>" /usr/share/dict/words; then

-12     count=$((count + 1))

-13     fi

-14 done

-15

-16 echo "Number of words: $count"

-17





(()) - means arithmetic operation

\-i ignore lower/upper letters
chmod a=u -> change
g+w - means add group permissions write
g-w - means remove the write permissions of the group

chmod a=rw is like chmod g=rw, u=rw, o=rw - o for others
chmod 556 rwx -> is like 2^2 + ..
user - firts number
group - second number
others - third number

set special UID - for special IDs
when executing we set the permissions 
xxd - read binary files
tr -s <symbols>
tr -s 'abd' means squeeze all the sequential characters from the subset - abd
comm - gets the columns from the files
comm - works only on sorted files
-1 -> means remove the words only in the first file
-2 -> only in the second file
-3 -> in both files

--> comm -1, -2 -> means get only the words in both files
join - joins the lines with equal key
filleone.txt
5 lolo
6 oli
filetwo.txt
5 ui
6 ki
-->
5 lolo ui
6 oli ki

join fileone.txt filetwo.txt
grep -n -> prints also the number of the line
