# tmux

## Create

* Create a new session with a name

  ```shell
  tmux new -s NAME
  ```
  e.g.)
  ```shell
  tmux new -s my-session-1
  ```
  
## List

* List all existing sessions
  ```shell
  tmux ls
  ```

## Re-attach

* Re-attach an existing named session

  ```shell
  tmux a -t NAME
  ```
  e.g.)
  ```shell
  tmux a -t my-session-1
  ```

* Reattach an existing session

  ```shell
  tmux attach 
  ```

## Shortcuts

* Detach from tmux (everything running will be in background)
  ```
  ctrl+B, D
  ```

* New tmux session
  ```
  ctrl+B, C 
  ```

* Switch session
  ```
  ctrl+B, 0~9
  ```

* Select a session from the list (Use the left and right arrow keys to see the list)
  ```shell
  ctrl+B, s
  ```

* Terminate the session
  ```
  ctrl+D
  ```

* scroll (Use the up and down arrow keys)
  ```
  ctrl + b + [
  ```
