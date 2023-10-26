resource_group_name = "my-app"
location_id = "southindia"

virtual_network_name = "myapp-vnet"
virtual_network_cidr = "10.0.0.0/16"

websubnet_name = "web-subnet"
websubnet_cidr = "10.0.1.0/24"
web_vm_size = "Standard_B1s"
web_hostname = "webserver"
web_username = "webuser"
web_password = "p@ssw0rd"

dbsubnet_name = "db-subnet"
dbsubnet_cidr = "10.0.2.0/24"
db_server_name = "sql-database"
db_name = "sql-database"
db_version = "8.0"
db_username = "sqladmin"
db_password = "p@ssw0rd"

appsubnet_name = "app-subnet"
appsubnet_cidr = "10.0.3.0/24"
app_vm_size = "Standard_B1s"
app_hostname = "appserver"
app_username = "appuser"
app_password = "p@ssw0rd"

securitygroup_name = "sg-group"