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
$ du -sh .[^.]* * | egrep -e "^[ 0-9]*[.]?[0-9]*[M]" | sort -n  
```

* 1GB이상 되는 폴더와 파일 나열하기

```bash
$ du -sh .[^.]* * | egrep -e "^[ 0-9]*[.]?[0-9]*[G]" | sort -n  
```

## 파일 사이즈로 파일 찾기
* 1MiB보다 큰 ZIP 파일들 모두 찾기.

```bash
$ find . -type f -size +1M -name "*.zip" -exec ls -lh {} \; | sort -k 5 -n 
```

## 원하는 단어가 포함된 파일 검색하기
* 현재 위치에서 원하는 단어가 포함된 모든 파일 찾기.

```bash
$ for file in `find . -type f`; do grep -H "원하는단어" $file; done 
```


## 내가 현재 사용중인 쉘 알아내기
* 알아내는 방법이 여러가지.
* `echo $0`

```bash
$ echo $0 
```

* `ps -p $$ ` or `ps --no-headers -p $$ | awk '{ print $4; }'`<br>

```bash
$ ps -p $$ 
3732 pts/6    00:00:00 bash
```
```bash
$ ps --no-headers -p $$ | awk '{ print $4; }' 
```
* `echo $SHELL`

```bash
$ echo $SHELL 
/bin/bash
```

## [ImageMagick](http://www.imagemagick.org/ "ImageMagick")을 이용한 이미지 크기변환
* 현재 디렉토리에 있는 PNG 파일의 이미지 크기 모두 변환하기.

```bash
# 크기: 300x150 (하지만 원본 이미지의 크기 비율을 유지한다.)
$ for file in *.png; do convert $file -resize 300x150 thumbnail-$file; done 
```

```bash
# 크기: 300x150 (원본 이미지의 크기 비율을 무시하고
# 가로 300픽셀, 세로 150픽셀의 크기로 변환한다.)
$ for file in *.png; do convert $file -resize 300x150 thumbnail-$file; done 
```

```bash
# 가로 300픽셀의 이미지로 변환.
$ for file in *.png; do convert $file -resize 300 thumbnail-$file; done 
```

```bash
# 세로 150픽셀의 이미지로 변환
$ for file in *.png; do convert $file -resize x150 thumbnail-$file; done 
```

