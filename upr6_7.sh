upr 6
zad nine - sbornik
#!/bin/bash
INPUT=/srv/sample-data/1-shell/-SE-1/input.data

cat "$INPUT" | tail -n +2 | sort -t';' -k 3 -n | tail -n 1 | cut  -d
cat "$INPUT" | tail -n +2 | grep -E "^[^;]{$TYPE} \
 | sort -t';' -k 3 -n | tail -n 1 | cut -d';' -f 1,4
| tr ';' '\t'

->when cutting fields and printing the delimiter also is printed
awk -v ->gets a variable in the awk command
[^;]- ^ -> means NOT ;

zad twenty-three
#!/bin/bash
valueone=a b c d
valuetwo=c e f
comm -13 valueone.txt valuetwo.txt | tr '\n' ' '

COMM command
-1 -> hide only lines in file one
-2 -> hide only lines from file two
-3 -> hide the lines in both files

so -13 -> get only the lines

to find the line
grep -E "${key}=" z.txt | cut -d= -f2
-> {} ->used for protection

-> how to modify

cat z.tx | awk -F '=' '{if($1==key) $2 = "new value" }'
sed -E -i 's/^whole_line$/${key}=${new_value}/'
i -> means inplace

sed -n '/e f/p' z.txt -> print the matching lines
/p - means print

sed '/e f/s/=./replace/' z.txt
/s/ - means substite
/=./ with replace

sed "/${name}/s/=./${replace}/' z.txt

command top - tells us everything about processes
ps -u tgg -> filters the processes of this user
ps -p 5 -> filters the processes witn PID 5
ps -u tgg --sort pid -> sort by PID
RSS - MEMORY
FORMAT SPECIFIER -> attributes for ps -o

whoami - which user does the process

--zadacha twenty-four
ps -u tgg | tail -n +2 | wc -l -> how many processes has FOO

()
number=$(ps -u root -o pid= | wc -l)
pid= -> removes the header
ps -e -o user= | sort | uniq -c | awk -v "min=${number}" '{ if($1 > min) print $2}'

-get the users with more processes than FOO

repo/four/task nine
for all processes
- how many children
- who is the parent PPID

ps -e -o pid=, ppid=

--script

child_count_per_pid="$(mktemp)"
while read curr_pid curr_ppid; do
echo "pid: ${pid}, ppid: ${ppid}"
child_count="$(ps --ppid ${ppid} -o pid= | wc -l)"
done < <(ps -e -o pid=, ppid=)

while read current-pid, current_ppid

done < < child_count_per_pid
--zadachi upr
twenty thousand and twenty four -SE five - 80
two zero two two - SE -four -
twenty  zero twenty one - SE two


--upr 7
ps -u root -o time= | awk -F ':' 'BEGIN { sum=0 } {sum +=
while read line; do
echo "line is: ${line}"
done < <(ps -u root -o time=)
hour= "$(echo "${line}" | cut -d':' -f1)"
arithmetic expansion $((5/6)) -> gives a whole number
while IFS:= read hour, minute, seconds; do

--pregovor
->environment variables -> PATH, USER,..
subshell ->
while IFS=: read hour, minutes, seconds; do.. -splits the line into three vars

---seventy--seven zadacha
Environment variable -> $PATH,
export -> creates an EnvVar

-vim
if [[ -n "${SVC_DIR}" ]]; then
echo "Need a svr dir"
--second way
[[ -n string ]] -> checks whether is an empty string
[[ -n "${SVC_DIR}" ]] || { echo "Need dir"}

[[ -d "${SVC_DIR}" ]] || { echo "Need to be a dir" }

SIGTERM/SIGKILL
kill -SIGTERM 666 ->
(echo one; sleep ; )
$! - gives the PID of the background process
eval -> evaluates - like sleep 5

EXAM Specifics

ls 6666.tar.xz
-rearchive the file
tar -xf 6666.tar.xz -> to rearchive the file
mv 6666 faculty_number
ls faculty_number/1/manage.sh -> here we have the tasks
tar -caf faculty_number.tar.xz faculty_number

tar -tf faculty_number.tar.xz
cd faculty_number to get

---seventy two

date +'%A %h'
date +'%A %H'
A - gives us a day from the week
h ->
echo '55.5 < 55.6' | bc
-> always use bc when comparing double

COMMAND='..'
value="$("$COMMAND")"
echo "$(date +'%s')">> "$2"

--sixty-eight
dict=$mktemp
for arg in "$klomba"; do
   if [[ $arg" =~
   echo "arg: $arg"
   if [[ "$arg" =~ ^- ]]; then
    echo "Not a valide

rm dict
sed -i ->replaces inplace
sed -E 's/\<word>/
sed -E 's/\bEurasia\b
sed -E

pass

-- zad 68
!#/bin/bash
file="${1}"
shift
dict=$(mktemp)
for arg in "${@}"; do
if [[ ! "$arg" =~ ^-R ]]; then
echo "Not valid"
fi
$(sed 's/-R//' "$arg") >> "$dict"

done
for line in $(cat "${file}"); do
for w in $(cat "$dict"); do
prev="$(echo "$w" | cut -d'=' -f1)"
next="$(echo "$w" | cut -d'=' -f2)"
sed -i "$line" 's/\b${prev}\b/${next}'
done
done
