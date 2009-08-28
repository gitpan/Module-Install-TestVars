#line 1
package Module::Install::TestVars;

use strict;
use warnings;

our $VERSION = '0.01_01';

use base qw(Module::Install::Base);

sub test_vars {
    my ($self, %vars) = @_;
    %MY::TEST_VARS = ( %vars );
}

package MY;
our %TEST_VARS = ();
sub test {
    my ( $self, %attrs ) = @_;
    my $vars = 'TEST_VARS=' . join(' ' => map { sprintf('%s=%s', $_, $TEST_VARS{$_}) } keys %TEST_VARS);
    my $section = $self->SUPER::test(%attrs);
    $section = $vars . "\n" . $section;
    $section =~ s|(PERL_DL_NONLAZY=1)|$1 \$\(TEST_VARS\)|g if (length $vars);
    $section;
}

1;
__END__

#line 77
