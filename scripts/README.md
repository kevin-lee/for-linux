Scripts
=======

## report file system disk space usage
```shell
$ df -h 
```

## estimate file space usage
```shell
$ du -sh 
```

* List all the folders and files which are equal to or greater than 1MB.

```shell
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[M] | sort -n  
```

* List all the folders and files which are equal to or greater than 1GB.

```shell
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[G] | sort -n  
```
