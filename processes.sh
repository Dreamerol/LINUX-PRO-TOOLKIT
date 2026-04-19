Processes

one/--find the top 5 oldest processes 
ps -e -o etime | sort -r | head -n 5
 ps -e -o etime,comm | sort -r | head -n 5
comm - gets also the names

ps -eo
o - specifies the columns you want to get

two/--get the biggest vsize virtual memory processes
ps -e -o vsize,comm | sort -r | head -n 5

three/--print the command of the oldest process
ps -e -o vsize,comm | sort -r | head -n 1 | awk -F' ' '{print $2}'

ps -eo pid - getting the pid

four/--print all the physical memory used from the processes in root directory
ps -u root -o rss | awk '{sum += $0} END {print sum}'

five/--get the users with at least two vim processes
user -lists the user command
ps -eo user,comm |grep "vim" | sort | uniq -c | awk -F' ' '{if($1 >= 2) print $2}'

six/ get only the unlogged users with life processes
comm -23 \
<(ps -eo -user | sort -u) - get the users with life processes
<(who | awk '{print $1}' | sort u) - get the logged ones

comm -23
-> means get the values only in fileone
<() -> command substitution - treat the output as a file

seven/--get the average of the memory
ps -e -o rss | awk -v number=$numlines '{sum += $0} END {if(number==0)print "NO"; else print sum/number}'

eight/--get the processes that dont have tty so its "?"
ps -e -o tty,cmd | awk '{if($1=="?") print $2}'

nine/
--script

child_count_per_pid="$(mktemp)"
while read curr_pid curr_ppid; do
echo "pid: ${pid}, ppid: ${ppid}"
child_count="$(ps --ppid ${ppid} -o pid= | wc -l)"
done < <(ps -e -o pid=, ppid=)

while read current-pid, current_ppid
...
done < < child_count_per_pid

