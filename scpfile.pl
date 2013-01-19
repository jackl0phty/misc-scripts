 #!/usr/bin/perl
##################################################
#This script is responsible for making a secure  #
#connection via ssh to server1 and executing the #
#commaned ls .                                   #
#This script is also responsible for making a    #
#a secure connection via ssh to server1 and then #
#scp the file test.txt.                          #
##################################################

#import required modules
use strict;
use warnings;
use Net::SCP qw(scp iscp);
use Net::SSH qw(ssh);
use Log::Dispatch::Syslog;

#declare local variables
my $scp;
my $host = "server1.domain.com";
my $user = "user1";
my $remotedir = "/home/user1/";
my $file = "test.txt";
my $cmd = "/bin/ls";

####################Log::Dispatch::Syslog#######################################
# Define our pid for use in the log message
my $pid = getppid();
# Define our logfile object
my $logfile = Log::Dispatch::Syslog->new( name => 'logfile',
                                          min_level => 'info',
                                          ident => "running_list_cmd[$pid]" );
####################Log::Dispatch::Syslog#######################################

######first connect to $host via Net::SSH and run /bin/ls###########
$logfile->log( level => 'info', message => "Connecting to $host as $user and running /bin/ls ..." );
ssh("$user\@$host", $cmd);
$logfile->log( level => 'info', message => "ls completed successfully!" );
######first connect to $host via Net::SSH and copy file $file###########

#initialize Net::SCP object and send credentials
$scp = Net::SCP->new($host);

#notify user we're logging into $host
print "Logging into $host ...\n";

#write "connected to $host" to $file
$logfile->log( level => 'info', message => "Connected to $host successfully." );

#log into $host as $user
$scp->login($user) or die $scp->{errstr};

#write "connected to $host" to $file
$logfile->log( level => 'info', message => "Logged into $host successfully." );

#notify user of changing working directory to $remotedir
print "Chaging working directory to $remotedir\n";

#change working directory to $remotedir
$scp->cwd($remotedir) or die $scp->{errstr};

#Write Changed working directory (CWD) to $remotedir
$logfile->log( level => 'info', message => "CWD to $remotedir successfully." );

#display file size of $file
$scp->size($file) or die $scp->{errstr};

#notify user scp of $file has started
print "SCPing $remotedir$file from $host ...\n";

#scp $file from $host
$scp->get($file) or die $scp->{errstr};

#notify user scp of $file from $host was successful
print "$remotedir$file copied from $host successfully!\n";


