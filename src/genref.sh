#!/bin/bash

needs_new_line=false

function pick_one { # symbols
    local symbols=$1
    local num_symbols=${#symbols}
    local idx=$[ $[ $RANDOM % $num_symbols ] + 1 ]
    printf $(echo "$symbols" | cut -c$idx-$idx)
    needs_new_line=true
}

function pick_some { # symbols count
    local symbols=$1
    local count=$2
    local i
    for ((i=0; i<$count; ++i)); do
        pick_one $symbols
    done
}

function some_abc { # count
    pick_some "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" $1
}

function some_lower { # count
    pick_some "abcdefghijklmnopqrstuvwxyz" $1
}

function some_upper { # count
    pick_some "ABCDEFGHIJKLMNOPQRSTUVWXYZ" $1
}

function some_digit { # count
    pick_some "0123456789" $1
}

function some_hex { # count
    pick_some "0123456789abcdef" $1
}

function some_hexaf { # count
    pick_some "abcdef" $1
}

function some_text { # text
    printf "%s" "$1"
    needs_new_line=true
}

function new_line {
    printf "\n"
    needs_new_line=false
}

function render {
    OPTIND=1
    while getopts "h:f:d:l:u:a:c:n" opt; do
        case "$opt" in
            'h') some_hex "$OPTARG";;
            'f') some_hexaf "$OPTARG";;
            'd') some_digit "$OPTARG";;
            'l') some_lower "$OPTARG";;
            'u') some_upper "$OPTARG";;
            'a') some_abc "$OPTARG";;
            'c') some_text "$OPTARG";;
            'n') new_line;;
            *) exit 1;;
        esac
    done
    if $needs_new_line; then
        new_line
    fi
}

if [ "-v" == "$1" ]; then
    echo "genref v1.0.0";
elif [ -z $1 ]; then
    render -f1 -h7
else
    render $@
fi
