[한국어 버전](README-kr.md "한국어 버전")
Scripts
=======

## report file system disk space usage
```bash
$ df -h 
```

## Estimate file space usage
```bash
$ du -sh 
```

* List all the folders and files which are equal to or greater than 1MB.

```bash
$ du -sh .[^.]* * | egrep -e "^[0-9]*[.]?[0-9]*[M]" | sort -n  
```

* List all the folders and files which are equal to or greater than 1GB.

```bash
$ du -sh .[^.]* * | egrep -e "^[0-9]*[.]?[0-9]*[G]" | sort -n  
```

## Find files by size
* Find all zip files which are bigger than 1MiB.

```bash
$ find . -type f -size +1M -name "*.zip" -exec ls -lh {} \; | sort -k 5 -n 
```

## Searching files containing word
* In the current location, Searching all files which contain the given word.

```bash
$ for file in `find . -type f`; do grep -H "WORD_HERE" $file; done 
```


## Find out What Shell I'm Using
* There are several ways to find it out.
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

## Resizing Image using [ImageMagick](http://www.imagemagick.org/ "ImageMagick")
* Resize all PNG files in the current directory.

```bash
# size: 300x150 (But it will preserve the aspect ratio of the source image.)
$ for file in *.png; do convert $file -resize 300x150 thumbnail-$file; done 
```

```bash
# size: 300x150 (It will ignore the aspect ratio of the source image and
# resize it 300 pixels in width and 150 pixels in height.)
$ for file in *.png; do convert $file -resize 300x150 thumbnail-$file; done 
```

```bash
# set width to 300 pixels
$ for file in *.png; do convert $file -resize 300 thumbnail-$file; done 
```

```bash
# set height to 150 pixels
$ for file in *.png; do convert $file -resize x150 thumbnail-$file; done 
```

