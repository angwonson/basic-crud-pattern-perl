package Bugnilla::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

# enable DEBUG to debug TT templates
# DEBUG options are: 'undef', 'all', 'service', 'context', 'parser' and 'provider'
__PACKAGE__->config(
    # TEMPLATE_EXTENSION => '.tt2',
    # DEBUG              => 'undef',

    # Set the location for TT files - this is already set in Bugnilla.pm, so this could be an override if needed. Leaving it commented out for now.
    # INCLUDE_PATH => [
    #        Bugnilla->path_to( 'root', 'templates' ),
    #    ],

    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/templates'
    WRAPPER => 'wrapper.tt2',
);

=head1 NAME

Bugnilla::View::HTML - TT View for Bugnilla

=head1 DESCRIPTION

TT View for Bugnilla.

=head1 SEE ALSO

L<Bugnilla>

=head1 AUTHOR

Han Do Jin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
