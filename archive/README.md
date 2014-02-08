# Create and Split Tar File into Several Files
## There are many large files to be archived and split
* create archives 

 ```shell
$ tar cz large_file_1 large_file_2 | split -b 1024MiB - result_files.tgz_ 
```

* uncompress 

 ```shell
$ cat result_files.tgz_* | tar xz 
```

 * This solution avoids the need to use an intermediate large file when (de)compressing.
 * Use the tar -C option to specify a different directory for the resulting files. 


## There is one large file to be archived and split
* If only one file needs to be split, tar with a single source file is still fine but in this case, gzip can be used as well.

* create archives 

 ```shell
$ gzip -c one_large_file | split -b 1024MiB - result_files.gz_ 
```

* uncompress 

 ```shell
$ cat result_files.gz_* | gunzip -c > one_large_file 
```
