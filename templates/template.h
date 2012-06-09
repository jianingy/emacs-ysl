#name : #ifndef XXXX; #define XXXX; #endif
# --
/*
 * filename   : `(buffer-name)`
 * created at : `(format-time-string "%c")`
 * author     : `user-full-name` <`user-mail-address`>
 */

#ifndef ${1:_`(upcase (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))`_H_}
#define $1

$0

#endif /* $1 */
