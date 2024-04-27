#!/bin/bash


if [[  $# -gt 3 ]]; then
	echo "Error" >&2
	echo "Try 'userhome --help' for more information" >&2
	exit 3  #Too many args
fi


if [[ $# = 3 ]]; then
	if [[ $1 = '-f' ]]; then
		if find "$2" >/dev/null 2>&1; then
			if cut -d ':' -f 1 "$2" | grep -w -q "$3"; then
				echo `cut -d ':' -f 1,6 "$2" | grep -w "$3"":" | cut -d ':' -f 2`
				exit 0
			else echo "Error, login "$3" is not found" >&2
			     exit 1
			fi
		else echo "Error, there is no such file" >&2
		     exit 2
		fi
	else echo "Invalid option $1" >&2
	     echo "Try 'userhome --help' for more information" >&2
	     exit 3
	fi
fi


if [[ $# = 2 ]]; then
	if [[ $1 = '-f' ]]; then
		if find "$2" >/dev/null 2>&1; then
			if cut -d ':' -f 1 "$2" | grep -w -q "$USER"; then
				echo `cut -d ':' -f 1,6 "$2" | grep -w "$USER"":" | cut -d ':' -f 2`
				exit 0
			else echo "Error, login $USER is not found" >&2
			     exit 1
			fi
		else echo "Error, there is no such file" >&2
		     exit 2
		fi
	else echo "Invalid option $1" >&2
	     echo "Try 'userhome --help' for more information"
	     exit 3
	fi
fi


if [[ $# = 1 ]]; then
	login="$1"
	if [[ ${login:0:1} != '-' ]]; then
		if cut -d ':' -f 1 /etc/passwd | grep -w -q $login; then
			echo `cut -d ':' -f 1,6 /etc/passwd | grep -w $login":" | cut -d ':' -f 2`
			exit 0
		else echo "Error, login $login is not found" >&2
		     exit 1
		fi
	elif [[ $login = "--help" ]]; then
		echo userhome '[-f file] [login]'
		echo "Shows the home directory of the specified user"
		exit 0
	elif [[ $login = "--version" ]]; then
		echo "userhome script made by niji"
		exit 0
	else echo "Invalid option "$1"" >&2
	     echo "Try 'userhome --help' for more information" >&2
	     exit 3
	fi
fi


if [[ $# = 0 ]]; then
	echo `cut -d ':' -f 1,6 /etc/passwd | grep -w "$USER"":" | cut -d ':' -f 2`
	exit 0
fi

exit 3
