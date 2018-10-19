# SysTools

A small collection of random utility scripts. The scripts are written mostly in Ruby. These scripts are mostly quick hacks and should not be considered good code or good practice.

Below are a description of some of the utilities here.

## spath

```
Usage: spath <path/to/file> <path/to/file> ...
```
Prints the absolute path the file and if possible via xsel add that path to the clipboard.

**Use Case**: You have two xterm windows and you would like to quickly share a path between them. You can run spath with no arguments, and that will print out and put into your clipboard the current path. And now you can paste that into other terminal and do whatever you want with it. You can run spath to a particular file, and then paste over to some other terminal. Paste paths where ever you like, paste paths to your friends. If you're on i3wm, you can go around copy and pasting paths without taking your hands off the keyboard.

This started off simple bash script, and was rewritten Ruby for some reason.
Now supports multiple paths.

## pgforcedisconnect

```
Usage: pgforcedisconnect
This script forcefully disconnects all connections
on a particular database.

  -h  Display this help
  -d  Database Name 
  -p  Postgres Port (defaults to 5432)
```

**Use Case**: You're trying to do something to a postgres database and it's complaining that there are connections and therefore it won't do what you want it to do. You know that the connections you have are all managed, they'll reconnect as needed. Use this to disconnect all the active connections to some postgres database.

It supports options like port because someone is bound to be running a postgres server on a non-standard port (maybe they think it makes more secure).

## backlight

```
usage: backlight [get|set] [value]
```

Set or get the backlight value via sysfs. 

**Usage Case**: You just installed minimalistic linux distribution, you do not have X installed, and your screen is too bright or too dark.

