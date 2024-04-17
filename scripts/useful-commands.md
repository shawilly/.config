#### Used for finding open vim sessions

The ps command writes the status of active processes

- -e writes information to standard output about all processes, except kernel processes.
- -f generates a full listing.
- grep used to search files for the occurrence of a string of characters that matches a specified pattern
``` bash
ps -ef | grep vim
```
