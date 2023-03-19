# SysTools

A small collection of random utility scripts. The scripts are written mostly in Ruby. 
These scripts are mostly quick hacks and should not be considered good code or good practice.

Below are a description of some of the utilities here.

## spath

```
Usage: spath <path/to/file> <path/to/file> ...
```
Prints the absolute path the file and if possible via xsel add that path to the clipboard.

**Use Case**: You have two xterm windows and you would like to quickly share a path between them. 
You can run spath with no arguments, and that will print out and put into your clipboard the current path. 
And now you can paste that into other terminal and do whatever you want with it. 
You can run spath to a particular file, and then paste over to some other terminal. 
Paste paths where ever you like, paste paths to your friends. 
If you're on i3wm, you can go around copy and pasting paths without taking your hands off the keyboard.

This was a simple bash script, and was rewritten in Ruby for some reason.
Now supports multiple paths.

## netfirstport

```
Usage: netfirstport <port_beg> <port_end>
```

Give me the first unused port in the specified port range.

**Use Case**: You want to run some local server, you prefer some port range, but you're okay with some of those ports being taken. Written in Perl. This parses the output of netstat and gives you the first unused tcp port in the range provided.

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

## pgsqlrestore

```
Usage: pgsqlrestore <dump_path.sql> [--dbhost (dbhost|localhost)] [--dbuser (dbuser|postgres)]
-h, --help:
  Show help
-a, --dbhost:
  Database Host. Defaults to localhost.
-u, --dbuser
  Database User. Defaults to 'postgres'.
-n, --dbname
  Database Name. Defaults to 'restored_[timestamp]'.

```

This is really ugly and probably wrong. But it does work in most cases.

**Use Case**: Your friend just handed you a SQL dump from a postgres database, not a binary dump from `pg_backup`. 
You need to do some work on this data quickly. 
You try to restore via psql, but there are active connections that you need to disconnect. 
Another issue is that the sql file contains roles that do not exist causing restoration errors. 
This ugly script will take care of it.

## backlight

```
Usage: backlight [get|set] [value]
```

Set or get the backlight value via sysfs. 

**Use Case**: You just installed some minimalistic linux distribution, you do not have X installed, and your screen is too bright or too dark. 
Known only to work on my dell XPS. Use at your own discretion.

## cpp\_debug\_undefined\_ref

Typical usage when used with makefile:
```
$ make 2>&1 | cpp_debug_undefined_ref
```

This is a simple script, it greps all the undefined references and sticks them into a Set. At the end you get a summary of all the undefined references.

**Use Case**: You're trying to compile some large project and you do not really understand what the dependencies are. You can't find the documentation. You run make, you see a giant wall of undefined references. Something is missing, but its hard to see exactly what. You simply pipe the output to this script, and you see that it's mostly openssl functions that are undefined, you link openssl, and now things are working.

## sfind

This started as a build debug tool, but can be used for other things. 
It's mostly a set of optional evals around Ruby's fantastic 'find' library.

**Use Case**: 
Suppose that you want to find all the library files within some directory, 
that directory has some big sudirectories that you do not want to go into, 
you want to grab all the library file names, 
remove the lib part, 
and output a single space separated line of linker flags all starting with '-l'. 
This script will let you do that with some level of ease.

```
Usage: sfind </some/directory> [options]
        --pruneif CONDITION          Prune if this condition is true
        --pruneunless CONDITION      Prune unless this condition is true
        --prunehidden                Prune Preset. Prune hidden directories
        --matchif CONDITION          Match if this condition is true
        --matchext EXT               Match Preset. Match this extension
        --matchunless CONDITION      Match file unless this condition is true
        --omap MAPPING               Output Map
        --omapxrem PATTERN           Output Map Preset. Grab the first match group
        --osep SEP                   Output seperator
        --oset                       Output is a Set (all items unique)
        --osort [dir]                Output is sorted
        --osortbysize                Sort by Size, Lexographic
        --opal                       Output is palindrome
        --omapxbef BEF               Prepend this string to each output element
        --omapxaft AFT               Append this string to each output element

```
Example of finding almost all of the boost libraries in some directory:
```
$ sfind </path/to/boost> --matchunless 'f=~/python|numpy/' --matchext 'a' --omap 'f.basename' --omapxrem 'lib(\w+)\.a' --omapxbef '-l' --osep " "
```

## qcompile

The q here is meant to indicate quick. Written in Perl as a script to run for quickly compiling some tiny demo C or C++ code.
Not meant to compile anything serious. It will look at source files and see if any include `math.h`, if so, it will link against
libm. It names the output file after the lead source file.

```
$ qcompile hello.cpp
```
Will result in the creation of `hello.exe`.

## ipdefault

Get the ip address of the default interface.

## s3backup

Written in Ruby and depends on gem aws-sdk-v1. This one off script was written a long time ago to backup
an s3 bucket to some local directory. It skips files that have already been copied, so it should be safe
to interrupt and resume. 

## strace_watch_stdio

This is mostly a wrapper around strace that lets you watch
the STDOUT, STDERR, and STDIN of some target process. 
It takes a PID or a Regex used to find the PID.

**Use Case**: Suppose some script spawned a process which is misbehaving, you
would quickly like to see what it is doing, and you know already that you are logging
things to STDOUT. No problem, run this script with the PID or uniquely-identifiable name 
of the process, and you will hopefully get a sense of what is happening. This is ideal
for hard to recreate issues where restarting the process with tee or within tmux is not an option
because you would lose whatever conditions caused the process to misbehave.
