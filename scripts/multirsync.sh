#!/bin/bash

# v1.3 | @sbamin
# Source: William Glick at https://wiki.ncsa.illinois.edu/display/~wglick/2013/11/01/Parallel+Rsync

# SETUP OPTIONS
export SRCDIR="$1"
export DESTDIR="$2"
export THREADS="$3"
export FILEPATRN="$4"

if [ ! -f ${HOME}/.myremote ]; then

	if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$#" -lt 3 ] || [[ ! -d "${SRCDIR}" ]] || [[ ! -d "${DESTDIR}" ]]; then

cat <<-ENDOFMESSAGE

	********************* parallel rsync on same system ********************

	Usage: "$(basename $0)" <source_dir_absolute_path> <target_dir_absolute_path_must_exist> <threads_to_use> <file_pattern>

	File pattern argument is optional.

	Both source and target directory must exist or it will fail; provide absolute instead of relative paths or paths with ~

	Example: $(basename $0) /scratch/mydata /home/foo/mydata 4 \"*.bam\"

	********************* parallel rsync over ssh ********************

	same as above but make ${HOME}/.myremote before running multirsync. This file will be removed after multirsync exits.

	Also, make sure to have ssh private key at ~/.ssh/id_rsa with file permission, chmod 600 ~/.ssh/id_rsa. You need to copy contents of matching public key file, id_rsa.pub to remote server's remote:~/.ssh/authorized_keys file.

	Example: touch ${HOME}/.myremote && $(basename $0) /scratch/mydata \"foo@remote:/home/foo/mydata\" 4 \"*.bam\"

	File pattern argument is optional.

ENDOFMESSAGE

		exit 0

	else

		# RSYNC DIRECTORY STRUCTURE
		rsync -zr --stats -f"+ */" -f"- *" "${SRCDIR}"/ "${DESTDIR}"/
		# FOLLOWING MAYBE FASTER BUT NOT AS FLEXIBLE
		# cd $SRCDIR; find . -type d -print0 | cpio -0pdm $DESTDIR/
		# FIND ALL FILES AND PASS THEM TO MULTIPLE RSYNC PROCESSES

		cd $SRCDIR

		if [ -z "${FILEPATRN}" ]; then
			find . ! -type d -print0 | xargs -0 -n1 -P$THREADS -I% rsync -r % "${DESTDIR}"/%
		else
			echo "rsync file names with pattern, "${FILEPATRN}""
			find . ! -type d -name "${FILEPATRN}" -print0 | xargs -0 -n1 -P$THREADS -I% rsync -r % "${DESTDIR}"/%
		fi
	fi

else

	if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$#" -lt 3 ] || [[ ! -d "${SRCDIR}" ]] || [[ ! -f ${HOME}/.ssh/id_rsa ]]; then

cat <<-ENDOFMESSAGE

	********************* parallel rsync on same system ********************

	Usage: "$(basename $0)" <source_dir_absolute_path> <target_dir_absolute_path_must_exist> <threads_to_use> <file_pattern>

	File pattern argument is optional.

	Both source and target directory must exist or it will fail; provide absolute instead of relative paths or paths with ~

	Example: $(basename $0) /scratch/mydata /home/foo/mydata 4 \"*.bam\"

	********************* parallel rsync over ssh ********************

	same as above but make ${HOME}/.myremote before running multirsync. This file will be removed after multirsync exits. 

	Also, make sure to have ssh private key at ~/.ssh/id_rsa with file permission, chmod 600 ~/.ssh/id_rsa. You need to copy contents of matching public key file, id_rsa.pub to remote server's remote:~/.ssh/authorized_keys file.

	Example: touch ${HOME}/.myremote && $(basename $0) /scratch/mydata \"foo@remote:/home/foo/mydata\" 4 \"*.bam\"

	File pattern argument is optional. ssh

ENDOFMESSAGE
		rm -f ${HOME}/.myremote
		exit 0
		
	else

		# RSYNC DIRECTORY STRUCTURE
		rsync -zr --stats -f"+ */" -f"- *" -e "ssh -T -c arcfour -o Compression=no -i ${HOME}/.ssh/id_rsa" "${SRCDIR}"/ "${DESTDIR}"/
		# FOLLOWING MAYBE FASTER BUT NOT AS FLEXIBLE
		# cd $SRCDIR; find . -type d -print0 | cpio -0pdm $DESTDIR/
		# FIND ALL FILES AND PASS THEM TO MULTIPLE RSYNC PROCESSES

		cd $SRCDIR

		if [ -z "${FILEPATRN}" ]; then
			find . ! -type d -print0 | xargs -0 -n1 -P$THREADS -I% rsync -rtx --partial --numeric-ids -e "ssh -T -c arcfour -o Compression=no -i ${HOME}/.ssh/id_rsa" % "${DESTDIR}"/%

			rm -f ${HOME}/.myremote
		else
			echo "rsync file names with pattern, "${FILEPATRN}""
			find . ! -type d -name "${FILEPATRN}" -print0 | xargs -0 -n1 -P$THREADS -I% rsync -rtx --partial --numeric-ids -e "ssh -T -c arcfour -o Compression=no -i ${HOME}/.ssh/id_rsa" % "${DESTDIR}"/%

			rm -f ${HOME}/.myremote
		fi
	fi

fi

## END ###
