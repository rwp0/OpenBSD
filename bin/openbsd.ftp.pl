use v5.32;
use warnings;
use constant {
HOST => 'ftp.usa.openbsd.org',
DIRECTORY => '/pub/OpenBSD/snapshots/amd64',
FILE => 'bsd',
SYSCTL => 'kern.version',
};
use Net::FTP;
use POSIX (); # method: mdtm

my $ftp = Net::FTP -> new(HOST);

$ftp -> login();
$ftp -> cwd(DIRECTORY);
# say $_ for $ftp -> dir();

my $modification = POSIX::strftime('%b %d, %Y (at %H:%M)', gmtime($ftp -> mdtm(FILE)));
say "m: $modification";

my %kern;
($kern{date}, $kern{time}, $kern{year}) = `sysctl -n @{[SYSCTL]}` =~ /(\w{3} \d{2}) (\d{2}:\d{2}):\d{2} \w{3} (\d{4})/;
say "c: $kern{date}, $kern{year} (at $kern{time})";
# say $sysctl;
