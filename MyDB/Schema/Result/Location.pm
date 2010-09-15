package MyDB::Schema::Result::Location;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core PK::Auto/);
__PACKAGE__->table('locations');
__PACKAGE__->add_columns(qw/location_id street_address postal_code city state_province country_id/);
__PACKAGE__->set_primary_key('location_id');
#__PACKAGE__->has_many( departments => 'MyDB::Schema::Result::Department','department_id');

1;