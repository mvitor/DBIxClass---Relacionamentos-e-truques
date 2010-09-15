package MyDB::Schema::Result::Employee;
use base qw/DBIx::Class::Core/;

__PACKAGE__->load_components(qw/Core PK::Auto/);
__PACKAGE__->table('employees');
__PACKAGE__->add_columns(qw/employee_id first_name last_name email phone_number hire_date salary commission_pct manager_id department_id job_id/);
__PACKAGE__->set_primary_key('employee_id');
#__PACKAGE__->has_one( jobhistory => 'MyDB::Schema::Result::JobHistory', 'employee_id');
__PACKAGE__->belongs_to( department => 'MyDB::Schema::Result::Department', 'department_id');
__PACKAGE__->belongs_to( job => 'MyDB::Schema::Result::Job', 'job_id');
__PACKAGE__->belongs_to( jobhistorys => 'MyDB::Schema::Result::JobHistory', 'employee_id');
#__PACKAGE__->has_many( jobhistorys => 'MyDB::Schema::Result::JobHistory', 'employee_id');


1;


 
 