#!/usr/local/bin/perl
# $Id$
# $Source$
# $Author$
# $HeadURL$
# $Revision$
# $Date$
use strict;
use warnings;

use Test::More;
BEGIN {
   plan (skip_all => 'TODO test');
}
use DBI;

BEGIN {
    use FindBin     qw($Bin);
    use File::Temp  qw(:POSIX);
    use Config::PlConfig;
    use lib $Bin;

    my $schema = qq{

CREATE TABLE cats (
    id INTEGER PRIMARY_KEY NOT_NULL,
    gender VARCHAR(64) DEFAULT 'female' NOT NULL,
    dna    VARCHAR(128) NOT NULL,
    action VARCHAR(128) NOT NULL,
    colour CHAR(4)      NOT NULL
);

CREATE TABLE memory (
    id      INTEGER PRIMARY_KEY NOT_NULL,
    cat     INTEGER NOT_NULL,
    content VARCHAR(16)
);

};

    my $db_file   = tmpnam();
    my %db_config = (
        driver   => 'SQLite',
        database => $db_file,
    );
    my $plc = Config::PlConfig->new({
        domain => 'org.0x61736b.class.dot.model.test.CatX',
    });
    my $config = $plc->load;
    $config->{database} = \%db_config;
    $plc->save;
    my $dbh = DBI->connect("DBI:SQLite2:dbname=$db_file;");
    $dbh->do($schema);
    #$dbh->disconnect();
    
    
}

BEGIN {
    plan tests => 10;
    use_ok('CatX');
}

my $cat = CatX->new();
isa_ok($cat, 'CatX');

my $rs = $cat->resultset('Cat');

my $new_cat_data = {
    gender => 'male',
    dna    => 'GCGCHCHGHCCGCCHCHCG',
    action => 'eating',
    colour => 0xc3ceca,
};
my $memory_data = [ qw(
        bird
        cockroach
        mouse
        water
        house
        tree
    ) ],
        
my $new_cat = $rs->new($new_cat_data);
$new_cat->insert;
ok( _POSINT($new_cat->id), 'insert new cat');

__DATA__


