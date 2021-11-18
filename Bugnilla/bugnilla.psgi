use strict;
use warnings;

use Bugnilla;

my $app = Bugnilla->apply_default_middlewares(Bugnilla->psgi_app);
$app;

