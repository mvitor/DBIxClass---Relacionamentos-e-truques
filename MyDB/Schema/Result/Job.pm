package MyDB::Schema::Result::Job;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core PK::Auto/);
__PACKAGE__->table('jobs');
__PACKAGE__->add_columns(qw/job_id job_title min_salary max_salary/);
__PACKAGE__->set_primary_key('job_id');
__PACKAGE__->has_many( employees => 'MyDB::Schema::Result::Employee', 'employee_id');


1;


=cut