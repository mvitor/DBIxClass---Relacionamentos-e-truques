package MyDB::Schema::Result::JobHistory;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core PK::Auto/);
__PACKAGE__->table('job_history');
__PACKAGE__->add_columns(qw/employee_id start_date end_date job_id department_id/);
__PACKAGE__->set_primary_key(qw/employee_id/);
__PACKAGE__->has_many( employee => 'MyDB::Schema::Result::Employee', 'employee_id');
#__PACKAGE__->belongs_to( employee => 'MyDB::Schema::Result::Employee', 'employee_id');


1;


=cut