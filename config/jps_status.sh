#!/usr/bin/bash
dir="/vagrant/hadoop/etc/hadoop"
readarray -t line < <(cat $dir/masters $dir/slaves)
for i in ${line[*]} ; do
    status=$(ssh ${i} "jps | grep -v Jps")
    printf '\n%s:\n%s\n' "${i}" "${status}"
done
printf "\n"
