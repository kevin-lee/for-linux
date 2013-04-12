[English Version](README.md "English Version")
스크립트
=======

## 디스크 사용량 보기
```bash
$ df -h 
```

## 디스크 공간 사용량 보기
```bash
$ du -sh 
```

* 1MB이상 되는 폴더와 파일 나열하기

```bash
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[M] | sort -n  
```

* 1GB이상 되는 폴더와 파일 나열하기

```bash
$ du -sh .[^.]* * | egrep -e ^[0-9]*[.]?[0-9]*[G] | sort -n  
```

## 파일 사이즈로 파일 찾기
* 1MiB보다 큰 ZIP 파일들 모두 찾기.

```bash
$ find . -type f -size +1M -name "*.zip" -exec ls -lh {} \; | sort -k 5 -n 
```

## 현재 사용중인 쉘 알아내기
* 알아내는 방법이 여러가지.
 * `echo $0`

    ```bash
$ echo $0 
bash
```
 * `ps -p $$ ` or `ps --no-headers -p $$ | awk '{ print $4; }'`<br>

   ```bash
$ ps -p $$ 
3732 pts/6    00:00:00 bash
```
    ```bash
$ ps --no-headers -p $$ | awk '{ print $4; }' 
bash
```
 * `echo $SHELL`

   ```bash
$ echo $SHELL 
/bin/bash
```
