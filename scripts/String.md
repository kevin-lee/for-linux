# Handle String

## Split
* Separate String by `-`
```shell
SOME_VAR="abc-123"
SOME_PREFIX=(${SOME_VAR//-*/ })

echo $SOME_PREFIX

# Result
abc
```

```shell
SOME_VAR="abc-123"
SOME_SUFFIX=(${SOME_VAR//*-/ })

echo $SOME_SUFFIX

# Result
123
```
## Trim
```shell
SOME_VAR="  abc-123  "
TRIMMED_VAR=(${SOME_VAR// })

echo "SOME_VAR='$SOME_VAR'"
echo "TRIMMED_VAR='$TRIMMED_VAR'"

# Result:
SOME_VAR='  abc-123  '
TRIMMED_VAR='abc-123'
```
