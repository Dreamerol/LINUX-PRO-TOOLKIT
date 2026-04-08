upr 4
id -u -n ->get the user id
awk -v username=$(id -u -n) - we keep the result in a var
sort files by frequency
^[expr] - gives us expressions starting with the expr in the brackets []
grep -Eo '[^a-w]+|(2|4|6|8|0)+'  philip.txt

grep -o - prints only the matching part
regex -> grep -E '[02468]' -> means match one of the character from the set

tasks
1/find /usr/include -name "*.C" -o -name /usr/include -name "*.h" | wc -l -> count the lines
-o -> means or
cat merges the files cat fileone filetwo

--count all the lines from the s and h files
find /usr/include -name "*.c" -o -name "*.h" -exec cat '{}' ';' | wc -l
find /usr/include -name "*.c" -o -name "*.h" -exec cat '{}' '+' ';' | wc -l
for every found file we cat/concatenate it/ and then we count all the lines 

find /usr/include -name "*.c" -o -name "*.h" | xargs cat | wc -l
-> faster
-> first we pass the xargs -> the output from theb prev pipe is made into arguments
-> arguments/xargs commmand
wc -l '{}' '+'

Echo ignore the spaces between the variables
s0600443@astero:~$ echo    hello   djhd
hello djhd
s0600443@astero:~$ echo ' haha hahah      jhaj'
 haha hahah      jhaj

; - separates commands
{} - separates blocks
echo i am $(whoami)

COMMAND SUBSTITUTION
$(pipes,commands) - get the output and pass it as an argument

touch $(echo 'one two') it passes touch one ; touch two - it creates two files
but with touch "$(echo 'one two')" - it will create only one file with the name one two

'' - it is not a command
-takes everything literally
""
-it execute the expression
echo "$((5+5))" - prints 10
echo '$((5+5))' prints $((5+5)) - does not interprets it as a command

grep - match
grep - case-sensitive
if we want case-insensitive - we write grep -i

grep -color word file.txt -> it colors only this word in the input
grep -o -> it gets ONLY the matching part
grep -c -> how many lines matches the pattern

grep --color -o is text.txt - gets only the matching part and colors it

task2
grep $(whoami) /etc/passwd - prints the line with our ID
grep -A 5 -B 5 $(whoami) /etc/passwd
grep -B 5 $(whoami) /etc/passwd | head -n 1 ->it gets the fifth line above our user

grep -E '[A-Z]' file.txt - it matches one letter from A-Z
grep -E --color '[A-Z]' file.txt - colors the matched part

REGEX 101 - site for regexes

regexes 
[A-Z]{5,6} - matches between five to six uppercase letters
. - random symbol
.* - zero or more

head -n 1 /etc/passwd | grep --color -E '.*:'
head -n 1 /etc/passwd | grep --color -E '.*:'
^ - beginning of the string
$ - end of the regex
'^[^:]*:' - everything that is not : and the : from the beginning
^...$ - for the whole expression if we want to match

sed - search replace
sed 's/search/replace/' -only the first match
sed 's/search/replace/g' -replace matches from the whole line

sed 's/1/lol/g' philip.txt
equivalent to sed 's:1:lol:g' philip.txt
 
tr 'abc' 'ABC' - works character bu character
sed 's/abc/ABC' - gets the whole stings

awk
prints the sum 
df -P | awk 'BEGIN {sum = 0 } { sum += $2 } END {print sum}'
df -P | awk 'BEGIN {sum = 0 } NR > 1 { sum += $2 } END {print sum}'
we give a condition - number of fields > 1 NR

/srv/01-shell/2016-SE-...
NR - number of lines
NF - number of fields


commands
cat 
cd 
mkdir
grep
cp
ls 
tr
mv
man
cowsay
xargs
sort - k means by key
uniq
KEYDEF - sort
tr
tr -d flag for deleting 
tr -d 'a'
tr "[:lower:]" "[:upper:]"
tr 'a-z''A-Z'
cat file | tail -n +2 -means print all the lines from the second one to the end
translates -> uses mapping two sets with equal length
 
echo "aaa" | head -c 1 ->gets the first byte

. - symbol
\< start of word \>
atom - ()
{3,5} - three to five symbols
grep -E '.{,5}' -> to six symbols

cat /tmp/data | awk '/.{5,} -> means more than five symbols
cat emp.dta | awk '{ print $2="" }'
cat emp.data | awk '{ $2 + $3 } { print }'

VIM
-NORMAL
-INSERT
-VISUAL
:q + enter
w for writing mode to write the text in a file

