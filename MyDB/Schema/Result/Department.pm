package MyDB::Schema::Result::Department;
use base qw/DBIx::Class/;
__PACKAGE__->load_components(qw/Core PK::Auto/);
__PACKAGE__->table('departments');
__PACKAGE__->add_columns(qw/department_id department_name manager_id location_id/);
__PACKAGE__->set_primary_key('department_id');
__PACKAGE__->has_many( employees => 'MyDB::Schema::Result::Employee','department_id');

#__PACKAGE__->belongs_to( locations => 'MyDB::Schema::Result::Location','location_id');

1;