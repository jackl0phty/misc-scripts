 #!/bin/bash

#####################################

#This shell script is used to print address labels.#
####################################

#Must export default printer environment variable
#in order for lpr to function correctly.  The rest
#will be executed from a Perl script.

#declare variables
FILEPATH="/home/user1/"
DATE=`date +%m%d%y`
MYPERL=`which perl`
SCRIPT=${FILEPATH}'print_addresses.pl'

#get name of file user wants to process
echo "What printer do you want to print to?"
read PRINTER
#echo "Going to process: $DEFAULTPRINTER"

#set default printer to DEFAULTPRINTER
export PRINTER=$PRINTER

#call perl script which builds a postscript
#file sends it to user's printer.
perl $SCRIPT

#send postscript file to the printer
`cat ${FILEPATH}$DATE | lpr -P $PRINTER`

exit 0
