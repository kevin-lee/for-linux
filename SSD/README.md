SSD
===

## fstab


## Using rc.local
Add the folloing lines to the `/etc/rc.local` file.
```shell
LOG=/var/log/trim.log

echo "*** rc.local ***" >> $LOG
echo "*** $(date -R) ***" >> $LOG
fstrim -v / >> $LOG
echo "" >> $LOG
```
