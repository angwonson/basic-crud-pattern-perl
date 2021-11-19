package Bugnilla::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
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
