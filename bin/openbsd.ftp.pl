use v5.32;
use warnings;
use constant {
HOST => 'ftp.usa.openbsd.org',
DIRECTORY => '/pub/OpenBSD/snapshots/amd64',
FILE => 'bsd',
};
use Net::FTP;
use POSIX (); # method: mdtm

my $ftp = Net::FTP -> new(HOST);

$ftp -> login();
$ftp -> cwd(DIRECTORY);
# say $_ for $ftp -> dir();
say POSIX::strftime('%b %d, %Y (at %H:%M)', gmtime($ftp -> mdtm(FILE)));
