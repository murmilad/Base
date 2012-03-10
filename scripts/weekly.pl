#!/usr/bin/perl

use strict;
use Time::Local;
use Data::Dumper;

#
use Net::FTP;

my $web_path     = 'akosarev.info';
my $web_login    = 'akosarev';
my $web_password = 'Godaddy215473';

my $ftp = Net::FTP->new($web_path, Debug => 0)
	or die "Cannot connect to some.host.name: $@";

$ftp->login($web_login, $web_password)
	or die "Cannot login ", $ftp->message;

my $mdtm = $ftp->mdtm('gallery.xml');
$ftp->quit();
my $crtm = time;
print Dumper(localtime($mdtm));
print "\n";
print Dumper(localtime(time));
#


#89.191.241.236	| 826	|RU - Moscow
sub get_stats {
	my $file_name = shift;

	my $ips = {};
	if (open STATS, "<$file_name"){
		while (my $str = <STATS>){
			print "$str\n";
			if ($str =~ /^\s*(.+)\t\|\s*(.+)\t\|\s*(.+) - (.+)\s\t$/){
				$ips->{$1}->{req}     = $2;
				$ips->{$1}->{city}    = $3;
				$ips->{$1}->{country} = $4;
			} elsif ($str =~ /----/){
				close STATS;
				return $ips;
			}
		}
	};

	close STATS;
	return $ips;
}
#YYYY-MM-DD
sub date_to_time{
	my $date  = shift;
	my $delim = shift;

	my $gm = timegm(0,0,0, $3, $2-1, $1-1900)
		if ($date =~ /(\d{4})$delim(\d{2})$delim(\d{2})/);

	print "\n";
	print Dumper(localtime($gm));
	
	return $gm;
}

#2008_03_25__17_00_25
#my $ips = get_logs('2008-03-22', '2008-03-24');
sub get_logs{
	my $time_begin = shift;
	my $time_end   = shift;

	my $all_ips = {};

	my @files = `ls -l`;
	print Dumper(\@files);
	foreach my $file (@files) {
		if ($file =~ /(\d{4}_\d{2}_\d{2}__\d{2}_\d{2}_\d{2})/){
	print Dumper($1);
			my $time_file = date_to_time($1, '_');
	print Dumper($time_file);
			if ($time_file > $time_begin && $time_file <= $time_end){
				my $file_ips = get_stats("$1.log");
	print Dumper($file_ips);
				if (ref($file_ips) eq 'HASH') {
					foreach my $ip (keys %{$file_ips}) {
						$all_ips->{$ip}->{req}    += $file_ips->{$ip}->{req};
						$all_ips->{$ip}->{city}    = $file_ips->{$ip}->{city};
						$all_ips->{$ip}->{country} = $file_ips->{$ip}->{country};
					}
				}
			}
		}
	}

	return $all_ips;
}

my $ips = get_logs($mdtm, $crtm);
print Dumper($ips);