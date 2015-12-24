I want to download some files from a ftp site, and I only want to download some files with names matching a pattern.
How can I do it?  
Use `wget` !  It is a very versatile command and I just got to know several tricks.

**When there are many levels of folder, you want to search down to all the folders:**   
 >-r
       --recursive
           Turn on recursive retrieving.

       -l depth
       --level=depth
           Specify recursion maximum depth level depth.  The default maximum depth is 5.

**You can specify what files you want to download or reject using wild cards:**   
 > Recursive Accept/Reject Options  
       -A acclist --accept acclist    
       -R rejlist --reject rejlist    
           Specify comma-separated lists of file name suffixes or patterns to accept or
           reject. Note that if any of the wildcard characters, *, ?, [ or ], appear in
           an element of acclist or rejlist, it will be treated as a pattern, rather
           than a suffix.
           
**If you want to save the file to a different name:**  
> -O file
       --output-document=file  
           The documents will not be written to the appropriate files, but all will be
           concatenated together and written to file.  If - is used as file, documents
           will be printed to standard output, disabling link conversion.  (Use ./- to
           print to a file literally named -.)

           Use of -O is not intended to mean simply "use the name file instead of the
           one in the URL;" rather, it is analogous to shell redirection: wget -O file
           http://foo is intended to work like wget -O - http://foo > file; file will be
           truncated immediately, and all downloaded content will be written there.

           For this reason, -N (for timestamp-checking) is not supported in combination
           with -O: since file is always newly created, it will always have a very new
           timestamp. A warning will be issued if this combination is used.

           Similarly, using -r or -p with -O may not work as you expect: Wget won’t just
           download the first file to file and then download the rest to their normal
           names: all downloaded content will be placed in file. This was disabled in
           version 1.11, but has been reinstated (with a warning) in 1.11.2, as there
           are some cases where this behavior can actually have some use.

           Note that a combination with -k is only permitted when downloading a single
           document, as in that case it will just convert all relative URIs to external
           ones; -k makes no sense for multiple URIs when they’re all being downloaded
           to a single file.

**If you do not need the folder structure:**

> -nd
       --no-directories  
           Do not create a hierarchy of directories when retrieving
           recursively.  With this option turned on, all files will get saved
           to the current directory, without clobbering (if a name shows up
           more than once, the filenames will get extensions .n).
           


**one alternative way is to specify `-nH` and `--cut-dirs=10` together**   
>-nH
       --no-host-directories  
           Disable generation of host-prefixed directories.  By default,
           invoking Wget with -r http://fly.srk.fer.hr/ will create a
           structure of directories beginning with fly.srk.fer.hr/.  This
           option disables such behavior.
           
           
>--cut-dirs=number  
           Ignore number directory components.  This is useful for getting a
           fine-grained control over the directory where recursive retrieval
           will be saved.  

           Take, for example, the directory at
           ftp://ftp.xemacs.org/pub/xemacs/.  If you retrieve it with -r, it
           will be saved locally under ftp.xemacs.org/pub/xemacs/.  While the
           -nH option can remove the ftp.xemacs.org/ part, you are still stuck
           with pub/xemacs.  This is where --cut-dirs comes in handy; it makes
           Wget not "see" number remote directory components.  Here are
           several examples of how --cut-dirs option works.

                   No options        -> ftp.xemacs.org/pub/xemacs/
                   -nH               -> pub/xemacs/
                   -nH --cut-dirs=1  -> xemacs/
                   -nH --cut-dirs=2  -> .

                   --cut-dirs=1      -> ftp.xemacs.org/xemacs/
                   ...

           If you just want to get rid of the directory structure, this option
           is similar to a combination of -nd and -P.  However, unlike -nd,
           --cut-dirs does not lose with subdirectories---for instance, with
           -nH --cut-dirs=1, a beta/ subdirectory will be placed to
           xemacs/beta, as one would expect.

**If you want to save files to a different folder name:**            
> -P prefix
       --directory-prefix=prefix  
           Set directory prefix to prefix.  The directory prefix is the
           directory where all other files and subdirectories will be saved
           to, i.e. the top of the retrieval tree.  The default is . (the
           current directory).

**Continue to download a file**:           
> -c
       --continue  
           Continue getting a partially-downloaded file.  This is useful when
           you want to finish up a download started by a previous instance of
           Wget, or by another program


There are so many different options, just `man wget` to see all of them! I am impressed on how versatile this command is!
