#!/bin/sh
# A simple shell script/template to log progress and
# email errors before exiting

# FUTURE TODO: verify hostname is valid because why not?
# FUTURE TODO: verify mailx (or sendmail?) is installed
# FUTURE TODO: potentially switch from echo -e to printf 
# since echo -e does funky things with formatting which 
# could cause issues if piping is desired in the future

log_file="/var/log/example.log"
exec 1>$log_file 2>&1

# Log info level
log_inf() {
    echo "[INF] [$(date '+%m/%d/%Y %H:%M:%S')] $*"
}

# Log and email error level
# exit upon completion
log_err() {
    echo "[ERR] [$(date '+%m/%d/%Y %H:%M:%S')] $*"
    echo -e "The script $0 reports an error:\n\n[$(date '+%m/%d/%Y %H:%M:%S')] $*\n\n See \"$log_file\" on the machine for more details" | mail -s "ERROR: $0@$(hostname -s)" example-name@example.com
    exit 1
}

# Example use
log_inf "Executing false if statement..."
if false; then
    log_inf "If statement isn't true, so this will not be logged"
else
    log_err "This statement will be logged and emailed"
fi
