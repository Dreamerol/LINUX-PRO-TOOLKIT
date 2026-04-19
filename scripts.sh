Scripts
()

--1
-change prompt -> the prompt -> s6566:~$
#!/bin/bash
OLDPS=$PS1
PS1="HelloMan"

--2
~/.profile - this is the file that executes, affecting your profile
 #!/bin/bash
  echo 'echo "Hello man"' >> ~./profile
  -> we add this command 'echo "Hello man"' to the file

--3
alias lo='ls -l'
-> we write alias -> rename the command

--4
#!/bin/bash
echo "Man can you enter a niz"
read name
echo "Hello $name"
--gets the input from the user
--read -r name -> means get the input ignoring the /

--5
[] - ge, gt, lt... for comparing numbers
[[]] -> for extended operations like comparing symbols

#!/bin/bash
param=$1
if [[ $param =~ [0-9A-Za-z]+ ]]; then
echo "Valid param"
else
echo "No"
fi

--6
#!/bin/bash
user="$1"
ps -e $user
-get all the processes of the given user

--7
#!/bin/bash
dir="$1"

numfiles=$(find $dir -type f | wc -l)
numdirs=$(find $dir -type d | wc -l)

echo "Number of files: $numfiles, Number of dirs.: $numdirs"

--8
#!/bin/bash
read fileone
read filetwo
read filethree


cat "$fileone" >> "$filetwo"
cat "$filetwo" | sort >> "$filethree"


--9
#!/bin/bash
read filename
read niz
if [[ $filename =~  "$niz" ]]; then
echo "Consists"
else echo "no"
fi

left side -> string
right side -> pattern

--05-b-4400.txt
#!/bin/bash

if [ $# -lt 1 ]
exit 1
fi

src="$1"
dest="$2"

if [ ! -d "$dst" ]; then
echo "not valid"
fi

mkdir -p "$dst"

find "$src" -type f -mmin -55 -exec cp {} "$dst" \;
--copy all the files, modified in tha last 55 min to the dst dir

--05-b-4500.txt
#!/bin/bash
[ a -ne b ] - means not equal

user=$1
while true; do
if who|awk '{print $1 }' | grep "^$user$" ;then
echo "User logged in"
sleep 1
fi

--05-b-4600.txt
#!/bin/bash
num=$1
left=$2
right=$3

if [[ $num =~ ^-?[0-9]+ ]] || [[ $left =~ ^-?[0-9]+$ ]] || [[ $right =~ ^-?[0-9]+$ ]]; then
echo "one whole number"
fi

-> only works for integers
if [ $num -ge $left ] && [ $num -le $right ]; then
echo "In interval"
else echo "No"

-> for non-whole numbers - bc -l 
if [ $(echo "$num >= $left" | bc -l) -eq 1 ] && [ $(echo "$num <= $right" | bc -l) -eq 1 ]; then
echo "In interval"
fi

--05-b-4700.txt
#!/bin/bash
num=$1
del="$2"

echo "$num" | awk -v delim="$del" '{
newnum=""
count=0
for(i=length($0);i>=1;i--){
count += 1
newnum=substr($0, i, 1) newnum
if(count % 3 == 0 && i > 1) newnum=delim newnum
} print newnum}'

--05-b-4800.txt
#!/bin/bash
file="$1"
dir="$2"

while read -r line; do
if cmp -s "$file" "$f"; then
echo "$f"
fi
done < <(find "$dir" -type f)

--> cmp -s ->compares the two files byte by byte

--05-b-5500.txt
#!/bin/bash
file="$1"
html="$2"

echo "<table>" >> "$html"
echo  "<tr>" >> "$html"
echo    "<th>Username</th>" >> "$html"
echo    "<th>group</th>" >> "$html"
echo    "<th>login shell</th>" >> "$html"
echo    "<th>GECOS</th>" >> "$html"
echo  "</tr>" >> "$html"

cat "$file" | awk -F':' '{

print  "<tr>"
print    "<th>$5</th>"
print    "<th>$4</th>"
print    "<th>$6</th>"
print    "<th>$5</th>"
print  "</tr>" }' >> "$html"

--05-b-6600.txt
#!/bin/bash
dir="$1"
file="$2"
--creates temporary file

tmp=$(mktemp)
while read -r line; do
if cmp -s "$file" "$line"; then
echo "$line" >> tmp
fi
done < <(find "$dir" -type f)

cat tmp | sort -n | tail -n +2 | xargs rm
ls -a -> finds all the hidden files
->getting only the files with uniq content

for f in *; do
   [ -f "$f" ] || continue
   unique=1

   for g in *; do
      [ -f "$g" ] || continue
      if [ "$g" != "$f" ]; then
         if cmp -s "$g" "$f"; then
             unique=0
             break
         fi
      fi
   done
   
   if [ $unique -eq 1 ]; then
       echo "$f"
   fi
done

-> eq, ge... -> only for whole numerical operations

--05-b-7000.txt
#!/bin/bash
niz="${!#}" -> means get the last positional argument
for file in "${@}"; do
if [ "${file}" = "${niz}" ]; then
continue
fi
echo $(grep -E "$niz" "$file" | wc -l)
done

--05-b-7100.txt
#!/bin/bash
dir="$1"
num=$2

find "$dir" -type f -size +"${num}c"

-> find -size +number means the files bigger than this number

--05-b-7200.txt
#!/bin/bash

for arg in "$@"; do
if [[ -f "$arg" ]]; then
    if [[ -r "$arg" ]]; then
       echo "Readable"
    else
       echo "Not readable"
	fi
   elif [[ -d "$arg" ]]; then
    count=$(find "$arg" -type f | wc -l)
   find "$arg" -type f -size -"${count}c"
 else
echo "Neither file/dir"
fi
done

--05-b-7500.txt
#!/bin/bash
a=5
b=55
rand=$(( (RANDOM % b) + a  ))

echo "Guess"
while read -r line; do
echo "Guess"
if [[ $line -gt $rand ]]; then
echo "DOWN"
elif [[ $line -lt $rand ]]; then
echo "UP"
else echo "YOU GUESSED it"
break
fi
done

--05-b-7550.txt
#!/bin/bash
user=$1
count=$(ps -eo, pid= -u "$user" | wc -l)
echo $count
for pr in $(ps -eo, pid= -u "$user"); do
kill $pr
done

--05-b-7700.txt
#!/bin/bash
dir="$1"
number=$2
find "$dir" -type f -size +"${number}c" -printf "%s\n" | awk '{count+=$0} END {print count}'

--05-b-7800.txt
#!/bin/bash
count=0

for dir in ${PATH/*/}; do
    if [ -d "$dir" ]; then
	for file in "$dir/*"; do
	   if [ -x "$file" ] && [ -f "$file" ]; then
              count=$((count + 1))
           fi
      done
    fi
done

--05-b-8000.txt
#!/bin/bash
user=$1
 ps -eo vsz=,rss= -u "$user" | awk '{ if($2!= 0) print $1/$2 " " $1 }' | sort -t' ' -k2

--

--05-b-6800.txt
#!/bin/bash
if [ $# -ge 2 ]; then
if [ $3 -eq "a" ]; then

dir="$1"
find "$dir" -type f -printf "%s size %f"
find "$dir" -type d
ls -a ->shows and the hidden files


--05-b-9100.txt
#!/bin/bash
dest="$1"
src="$2"


find "$src" -type f | grep -Eo  "\.[^./]+$" | sed 's/.//' | sort |uniq | xargs -I {} mkdir -p "$dest"/"{}"

while line ; do

ext=$(grep "$line" -Eo "\.[^./]+$" | sed 's/.//')
mv "$line" "$dest/$ext"

done < <$(find "$src" -type f)

chown :groupname file -> changes the groupowner of the file
chown user file -> changes the user owner of the file
chown -R user dir
