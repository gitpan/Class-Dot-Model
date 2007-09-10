# $Id$
# $Source$
# $Author$
# $HeadURL$
# $Revision$
# $Date$
package CatX::Cat;

use strict;
use warnings;

use Class::Dot::Model::Table qw(:has_many);

Table       'cats';
Columns     qw( id gender dna action colour );
Primary_Key 'id';
Has_Many    'memories'
    => 'CatX::Cat::Memory';

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
# End:
# vim: expandtab tabstop=4 shiftwidth=4 shiftround
