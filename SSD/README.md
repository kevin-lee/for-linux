SSD
===

## fstab


## Using rc.local
Add the folloing lines to the `/etc/rc.local` file.
```shell
echo "*** rc.local ***" >> /var/log/trim.log
echo "*** $(date -R) ***" >> /var/log/trim.log
fstrim -v / >> /var/log/trim.log
echo "" >> /var/log/trim.log
```
