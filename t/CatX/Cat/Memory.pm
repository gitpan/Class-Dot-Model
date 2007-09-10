# $Id$
# $Source$
# $Author$
# $HeadURL$
# $Revision$
# $Date$
package CatX::Cat::Memory;

use strict;
use warnings;

use Class::Dot::Model::Table qw(:belongs_to);

Table           'memory';
Columns         qw(id cat content);
Primary_Key     'id';
Belongs_To      'cat'
    => 'CatX::Cat';

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
# End:
# vim: expandtab tabstop=4 shiftwidth=4 shiftround
