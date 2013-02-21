[English Version](README.md "English Version")
스크립트
=======

## 디스크 사용량 보기
```shell
$ df -h 
```

## 디스크 공간 사용량 보기
```shell
$ du -sh 
```

* 1MB이상 되는 폴더와 파일 나열하기

```shell
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[M] | sort -n  
```

* 1GB이상 되는 폴더와 파일 나열하기

```shell
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[G] | sort -n  
```
