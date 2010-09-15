use strict;
use warnings;

use MyDB::Schema;

my $schema = MyDB::Schema->connect("dbi:Oracle:host=useaiht103;sid=ORCL",'hr','wante15') or die $!;

#my @all_artists = $schema->resultset('Employee')->all;

#=cut  $author->delete_related('books', { name => 'Titanic' });

my $dep = $schema->resultset('Department')->( department_name => { like => '%Account%' });

$dep->delete_related('employees',{ department_name => { like => '%Account%' }});

#( { department_name => { like => '%Account%' } })->delete_related('employees');

#foreach (@dep_employees)	{
#	print $_->first_name.$/;
#}
=cut

#=cut
# Saber endereço de departamentos existentes nos Estados Unidos
my $rs = $schema->resultset('Department')->search(
		{
		  'locations.country_id' => 'US'
		},
		{
		  join => 'locations', # join the locations table
		  order_by => [qw/ department_name locations.city /]
		}
	);
my $i=0;;	
while (my $dep = $rs->next) {
	$i++;
	print "Department #$i " . $dep->department_name." City: " . $dep->locations->city.$/;
}
=cut
# Saber endereço de departamentos existentes nos Estados Unidos, porem pegando de uma só vez

#There is a problem however. We have searched both the cd and artist tables in our main query, but we have only returned data from the cd table. To get the artist name for any of the CD objects returned, DBIx::Class will go back to the database:

#  SELECT artist.* FROM artist WHERE artist.id = ?
#A statement like the one above will run for each and every CD returned by our main query. Five CDs, five extra queries. A hundred CDs, one hundred extra queries!

#Thankfully, DBIx::Class has a prefetch attribute to solve this problem. This allows you to fetch results from related tables in advance:

=cut
my $rs = $schema->resultset('Department')->search(
		{
		  'locations.country_id' => 'US'
		},
		{
		  join => 'locations', # join the locations table
		  order_by => [qw/ department_name locations.city /],
		  prefetch => 'locations'
		}
	);
my $i=0;;	
while (my $dep = $rs->next) {
	$i++;
	print "Department #$i " . $dep->department_name." City: " . $dep->locations->city.$/;
}
=cut
=cut
#TRICK 3 - PEGA TODOS SALARIOS MAIOR QUE 2500 DO DEPARTAMENTO CONTROLLAND CREDITT
#Multiple joins
my $rs = $schema->resultset('Employee')->search(
		{
		  'salary' => {'>=', '100'},
		  'department.department_name' => 'Shipping'
		},
		{
		  join => [qw/department/],  # join the locations table
		  prefetch => 'department',
		  order_by => [qw/department.department_name salary/],
		},
		);
my $i=0;;	
while (my $dep = $rs->next) {
	$i++;
	print "Name " . $dep->first_name." Salary ".$dep->salary." Dep ".$dep->department->department_name.$/;
}	


# Pesquisa empregeados que tem salarios maiores ou iguais a 100, que são do departamento 'Finance' e tem job_title como 'Accountant'
#Multiple joins
my $rs = $schema->resultset('Employee')->search(
		{
#		  'department.locations.country_id' => 'US',
#		  'salary>' => '100',
		  'salary' => {'>=', '100'},
		  'department.department_name' => 'Finance',
		  'job.job_title' => 'Accountant',
		},
		{
		  join => [qw/ department job /],  # join the locations table
#		  join => [qw/department department.locations /],  # join the locations table		  
		  prefetch => 'department',
		  
		  #prefetch => [qw/ department job /],

		  order_by => [qw/department.department_name salary/],
		},
		);
while (my $dep = $rs->next) {
	print "Departamento: ".$dep->department->department_name." Nome " . $dep->first_name." Salary ".$dep->salary.$/;
}	
# Pesquisa empregeados que tem salarios maiores ou iguais a 100, quem estão localizaos no US  e tem start_date maior que 01-JAN-80
#Multi-step and multiple joins
my $rs = $schema->resultset('Employee')->search(
			{
			  'locations.country_id' => 'US',
			  'salary' => {'>=', '100'},
			  'jobhistorys.start_date' => {'>=', '01-JAN-80'},
			  
			},
			{
			  join => [
				{
				  'department' => 'locations',
				},
				'jobhistorys',
			  ],
			prefetch => [qw/ department jobhistorys/],
			order_by => [qw/department.department_name jobhistorys.start_date salary/],
			},
		);
while (my $dep = $rs->next) {
	print "Departamento: ".$dep->department->department_name." Nome " . $dep->first_name." Salary ".$dep->salary." Start date ".$dep->jobhistorys->start_date.$/;	 
}
#=cut	

#my $department = $schema->resultset('Departament')->find(1);

my $employye = $schema->resultset('Employee')->create(
			{
			  first_name => 'Marcio Vitor',
			  last_name =>  'De Matos',
			  salary => '2000',
			  department_id => '90',
			  job_id => 'AC_MGR',
			  email => 'mvitor@flynight.com',
			  phone_number => '25115959',
			  hire_date => '20=JAN-09', 
			  commission_pct => '10',
			  manager_id  => '100',		  
			},
		);
#$employye->insert;
my $author = $employye->create_related('jobhistorys', { start_date => '20=JAN-09',
														job_id => 'AC_MGR',});

		
		
#while (my $dep = $rs->next) {
#	print "Departamento: ".$dep->department->department_name." Nome " . $dep->first_name." Salary ".$dep->salary." Start date ".$dep->jobhistorys->start_date.$/;	 
#}	

Search in a related table

Only searches for books named 'Titanic' by the author in $author.

  my $books_rs = $author->search_related('books', { name => 'Titanic' });
Delete data in a related table

Deletes only the book named Titanic by the author in $author.

  $author->delete_related('books', { name => 'Titanic' });
Ordering a relationship result set

If you always want a relation to be ordered, you can specify this when you create the relationship.

To order $book->pages by descending page_number, create the relation as follows:

  __PACKAGE__->has_many('pages' => 'Page', 'book', { order_by => { -desc => 'page_number'} } );
Filtering a relationship result set

If you want to get a filtered result set, you can just add add to $attr as follows:

 __PACKAGE__->has_many('pages' => 'Page', 'book', { where => { scrap => 0 } } );

=cut