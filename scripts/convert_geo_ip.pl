#!/usr/bin/perl

my $geo_source_path   = $ARGV[0];
my $geo_city_blocks   = 'GeoLiteCity-Blocks.csv';
my $geo_city_location = 'GeoLiteCity-Location.csv';

if (-f "$geo_source_path/$geo_city_location") {
	open SOURCE, "<$geo_source_path/$geo_city_location"
		or die "Cannot open source locations file for reading: $!";

	open FILE, ">$geo_source_path/$geo_city_location.sql"
		or die "Cannot open locations file for writing: $!";
	my $comma;
	while (<SOURCE>) {
		if ($_ =~ /Copyright \(c\) 2007 MaxMind LLC\.  All Rights Reserved\./){
			print FILE 'DELETE FROM ipcity_locations; INSERT INTO ipcity_locations ';
		} elsif ($_ =~ /(locId,country,region,city,postalCode,latitude,longitude,metroCode,areaCode)/){
			print FILE " ($1) VALUES ";
		} elsif ($_ =~ /^(\d+,"\w*","\w*","[\w \x80-\xff-\`\'\.\*\/\(\)]*","[\w -]*",-?\d+\.\d+,-?\d+\.\d+),(\d*),(\d*)$/){
			print FILE " $comma($1," . ($2 ? $2 : 'NULL') . ',' . ($3 ? $3 : 'NULL') . ')' . "\n";
			$comma = ',';
		} elsif ($_ =~ /^\n$/) {
			print FILE ';';
		}
	}
	close FILE;
	close SOURCE;
} else {
	print "Locations file not found: $geo_source_path/$geo_city_location\n";
}


if (-f "$geo_source_path/$geo_city_blocks") {

	open SOURCE, "<$geo_source_path/$geo_city_blocks"
		or die "Cannot open source blocks file for reading: $!";
	my $count = 0;
	while (<SOURCE>) {
		$count++;
	}


	open SOURCE, "<$geo_source_path/$geo_city_blocks"
		or die "Cannot open source blocks file for reading: $!";
	my $file_count = 1;
	open FILE, ">$geo_source_path/${geo_city_blocks}_$file_count.sql"
		or die "Cannot open blocks file for writing: $!";
	my $comma;
	my $index = 0;
	while (<SOURCE>) {
		$index++;
		if ($_ =~ /Copyright \(c\) 2007 MaxMind LLC\.  All Rights Reserved\./){
			print FILE 'DELETE FROM ipcity_blocks; INSERT INTO ipcity_blocks ';
		} elsif ($_ =~ /(startIpNum,endIpNum,locId)/){
			print FILE " ($1) VALUES ";
		} elsif ($index > $count/10) {
			$file_count++;
			print FILE ';';
			close FILE; 
			open FILE, ">$geo_source_path/${geo_city_blocks}_$file_count.sql"
				or die "Cannot open blocks file for writing: $!";
			print FILE 'INSERT INTO ipcity_blocks ';
			print FILE ' (startIpNum,endIpNum,locId) VALUES ';
			if ($_ =~ /^"(\d*)","(\d*)","(\d*)"$/){
				print FILE " ($1, $2, $3)\n";
			}
			$index = 0;
		} elsif ($_ =~ /^"(\d*)","(\d*)","(\d*)"$/){
			print FILE " $comma($1, $2, $3)\n";
			$comma = ',';
		} elsif ($_ =~ /^\n$/) {
			print FILE ';';
		}
	}
	close FILE; 
	close SOURCE;
} else {
	print "Blocks file not found: $geo_source_path/$geo_city_blocks\n";
}

