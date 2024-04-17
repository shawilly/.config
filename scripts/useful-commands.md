## What is this?

Things that I don't really get, but really need. I store commands here that I always forget along with short explanations to try and ingrain them deep into my thick skull

```
┌─────────────────────────────────────────────┐                   ______________________
│                                             │                 { Being a good developer }
└┐                                            │                   ______________________
 │    ┌───────────┐                       ┌───▼────               
 │    │           │                       │ My Brain              
 │    │           │    ┌────────────────┐ │       │               
 │    │           │    │                │ └───────┘               
 │    │  Information   │                │                         
 │    │           │    │                │                         
 │    │           ├────┼───┐            │                         
 │    │           │    │   │            │                         
 │    └───────────┘    │   │            │                         
 │                     │   │            │                        │
 └─────────────────────┼───┼────────────┼────────────────────────┤
                       │   │            │                        │
                       │   └────────────┘                        │
                       │                                         │
                       │                     ┌─────────────┐     │
                       │                     │             │     │
                       └────────────────────►│  This doc   ├─────┘
                                             │             │      
                                             └─────────────┘
```

---
``` bash
sudo lsof -nP -iTCP -sTCP:LISTEN | grep PORTNUMBER
```
#### Used for finding processes listening on a specific port

The `sudo lsof -nP -iTCP -sTCP:LISTEN` command lists all open files (including network sockets) and filters them to show only those in a listening state:

- `sudo` is used to execute the command with superuser privileges, necessary for accessing detailed information about all processes.
- `lsof` stands for "list open files" and is a command-line utility used to list information about files opened by processes.
- `-nP` prevents the conversion of network numbers to host names and port numbers to service names, ensuring faster execution.
- `-iTCP` limits the output to only TCP connections.
- `-sTCP:LISTEN` filters the output to display only those connections in a listening state.

`grep PORTNUMBER` is then used to further filter the results to display only processes listening on a specific port, where `PORTNUMBER` should be replaced with the desired port number.``` bash
ps -ef | grep vim

---
``` bash
ps -ef | grep vim
```
#### Used for finding open vim sessions

The `ps` command writes the status of active processes:

- `-e` writes information to standard output about all processes, except kernel processes.
- `-f` generates a full listing.
- `grep` is used to search files for the occurrence of a string of characters that matches a specified pattern.

---
