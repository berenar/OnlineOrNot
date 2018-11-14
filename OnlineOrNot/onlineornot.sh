#!/bin/bash
# Website status checker 2.0

# list of websites. Each website in new line. Leave an empty line in the end.
LISTFILE=websites.lst

# Temporary dir
TEMPDIR=cache

function test {
  response=$(curl -L --write-out %{http_code} --silent --output /dev/null $1)
  filename=$( echo $1 | cut -f1 -d"/" )
  echo -n "$p ";

  if [ $response -eq 200 ] ; then
    # website working
      echo -n "$response "; echo -e "\033[38;5m OK \033[0m";
    # remove .temp file if exist 
    if [ -f $TEMPDIR/$filename ]; then rm -f $TEMPDIR/$filename; fi
  else
    # website down
    echo -n "$response "; echo -e "\033[1;31m DOWN \033[0m";
  fi
}

# main loop
while read p; do
  test $p;
done < $LISTFILE;
