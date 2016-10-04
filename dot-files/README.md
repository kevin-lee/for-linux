# Common Dot Files

## For Docker,

Add following lines to `.bashrc` or `.zshrc`.

**Currently it's only for z-shell**

```shell
if [ -f ~/dot-files/zsh/.my-docker-common ]; then
  . ~/dot-files/zsh/.my-docker-common
fi
```

Now you can do
```shell
# Stop all running processes
dk-stop-all 

# Clean all stopped processes
dk-clean-ps 

# Clean all dangling images
dk-clean-images 

# Clean all iamges
dk-clean-images-all 

# Print Docker version info including Docker Machine's and Docker Compose's
dk-versions 

# Get Docker container IP
dk-ip CONTAINER_ID 
e.g.) dk-ip 33dc22bb443c

```
