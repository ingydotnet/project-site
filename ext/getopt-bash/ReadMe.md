getopt-bash
===========

Easily use the powerful getopt facilities from Git in Bash

# Synopsis

```
#!/bin/bash

source getopt.bash

GETOPT_SPEC="\
  $(basename "$0") <options...>

See 'man foo' for more help.

Options:
--
 
b,bar       Bar bar bar
q,quux=     Quux quux
 
xxx         Xxx xxx
yyy=        Yyy yyy
"

GETOPT_ARGS='@arguments' getopt "$@"

if $option_bar || $option_xxx; then
    echo $option_quux
    echo $option_yyy
    printf "%s\n" "${arguments[@]}"
fi
```

# Description

Git has a little known, but very cool getopt parser built in.
The Git command is:
```
echo "<special-format-getopt-spec-text>" |
  git rev-parse --parseopt <command-line-args>
```

You pipe in a special format that looks like a help text describing the command.
If the parser fails to parse the options, it actually will print a slightly reformatted version of that spec.

This library make the Git facility even more powerful and easy to use.

# License and Copyright

Copyright 2020. Ingy döt Net <ingy@ingy.net>.

getopt-bash is released under the MIT license.

See the file License for more details.

