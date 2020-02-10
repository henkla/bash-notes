#!/bin/bash


# Author:	Henrik Larsson
# E-mail:	lthlarsson@gmail.com
# Usage:	<filename> -h
# Date: 	2020-02-03


# GLOBAL VARIABLES
target="${HOME}/notes.txt"
numeric="^[0-9]+$"


# POSSIBLE ACTIONS
verbose=0
do_show_help=0
do_list=0
do_add=0
do_delete=0
do_count=0


# FUNCTIONS DEFINING THE ACTIONS
function print_if_verbose () {
    if [[ $verbose -eq 1  ]]; then
        echo "$*"
    fi
}

function list_entries () {
    if [[ $verbose -eq 1 ]]; then
        cat -n $target
    else
	cat $target
    fi
}

function add_entry () {
    read -r -p "Entry: " entry
    echo "$(date +%y-%m-%d\ %T)	$entry" >> $target
    print_if_verbose "Added entry: \"$(tail -n 1 $target)\""
}

function delete_entries () {
    print_if_verbose "Deleting entry on row $1"
    local answered=
    echo "Are you sure? (y/n)"

    while [[ ! $answered ]]; do
    	read -r -n 1 -s answer
	if [[ $answer = [Nn] ]]; then
            answered="no"
        elif [[ $answer = [Yy] ]]; then
	    answered="yes"
	fi
    done

    if [[ $answered == "yes" ]]; then
	local row=$(sed "${1}q;d" "$target" | cut -f2)
	sed -in "${1}d" $target
	print_if_verbose "Deleted entry: \"$row\""
    else
        print_if_verbose "No entries were deleted"
    fi
}

function show_help () {
    print_if_verbose "Displaying help section"
    echo ""
    echo "note		-a              Add an entry to the notebook"
    echo "note		<ENTRY>		... (quickly add an entry)"
    echo "note		-v		Be verbose"
    echo "note		-l		List all entries"
    echo "note		-d <ROW>  	Delete entry in specific row"
    echo "note		-h            	Show this help section"
    echo "note		-c 		Count the number of entries"
}

function count_entries () {
    local count=$(cat $target | wc -l)
    print_if_verbose "Number of saved entries are:"
    echo $count
}

# if note file doesn't already exist
[[ -f $target ]] || touch $target;

# take a quick note
if [[ $# -gt 0 ]] && [[ $1 != -* ]]; then
    echo "$(date +%y-%m-%d\ %T)	$*" >> $target
    exit 0
    
#show entries
elif [[ $# -eq 0 ]]; then
    do_list=1
    
# parse options and argument
else
    while getopts ":hvlad:c" opt; do
        case "$opt" in
            h)
                do_show_help=1
                ;;
            v)
                verbose=1
                ;;
            l)
                do_list=1
                ;;
            a)
                do_add=1
                ;;
            d)
                [[ ${OPTARG} =~ $numeric ]] || { echo "$0: option -d: ${OPTARG} is not a number." >&2; exit 1; }
                do_delete=$OPTARG
                ;;
            c)
                do_count=1
                ;;
            :)
                echo "$0: option -$OPTARG requires an argument." >&2; exit 1
                ;;
            \?)
                echo "$0: option -$OPTARG is unknown - showing help section." >&2
                do_show_help=1
                ;;
        esac
    done
fi


# PERFORM ACTIONS BASED ON PARSED OPTIONS

if [[ $do_show_help -eq 1 ]]; then
    show_help; exit 0
fi


if [[ $do_count -eq 1 ]]; then
    count_entries
fi


if [[ $do_add -eq 1 ]]; then
    add_entry
fi


if [[ $do_delete -gt 0 ]]; then
    delete_entries $do_delete
fi


if [[ $do_list -eq 1 ]]; then
    list_entries
fi
