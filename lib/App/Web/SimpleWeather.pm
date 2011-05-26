package App::Web::SimpleWeather;
#ABSTRACT: Dancer application to pull weather data from google

use Dancer ':syntax'; #don't change AppDir to this dir.
use Weather::Google;

set logger => 'console';

my $gw = Weather::Google->new();

get '/' => sub {
    return 'welcome to simple weather'
};

get '/:name_or_zip' => sub {
    $gw->zip( params->{name_or_zip} );
    my $forecast = $gw->current();
    $forecast->{ location } = params->{name_or_zip};

    #template 'weather' => { f => $forecast };
    return to_dumper $forecast;
};

#Dancer::dance unless caller; #<-- doesn't work because AppDir gets confused
1;
