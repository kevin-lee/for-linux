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

```shell
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[M] | sort -n  
```
