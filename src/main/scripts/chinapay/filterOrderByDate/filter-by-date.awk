#!/usr/bin/awk -f
function getStartDate(d) {
    command = "date -d '" d -1 year"'  +%y%m%d"
    command | getline result
    close(command)
    return result
}
function getEndDate(d) {
    command = "date -d '" d -5 day"'  +%y%m%d"
    command | getline result
    close(command)
    return result
}

BEGIN{FS="|";}
{batchDate=substr(FILENAME,16,6);oriDate = substr($9,3,6);  if(oriDate > getStartDate(batchDate) && oriDate <= getEndDate(batchDate)) print $0; }
