class mydell() {
   case $manufacturer  {
       /Dell.*/: 
       {
           file { '/opt/dell/srvadmin/lib64/openmanage/IGNORE_GENERATION':
                 ensure => file,
            }
         

             case $operatingsystemmajrelease {
                7: {
                   notice { "sorry, $module_name does not support $operatingsystem $operatingsystemmajrelease ":}
                }
                 default: {
   
                    file { '/etc/init.d/srvadmin-services.sh':
                          ensure => 'link',
                          target => '/opt/dell/srvadmin/sbin/srvadmin-services.sh',
                    }
                
             
                   service{'srvadmin-services.sh':
   	               ensure     => true,
         #	       enable     => true,
         	       hasstatus  => true,
	               hasrestart => true,
                       require => [File["/opt/dell/srvadmin/lib64/openmanage/IGNORE_GENERATION"], File['/etc/init.d/srvadmin-services.sh'], Package['srvadmin-omacore', 'srvadmin-omcommon',  'srvadmin-storageservices'] ]
   	           }
               }
 
           } 
         include mydell::omsa_repo
         ensure_packages( ['srvadmin-omacore', 'srvadmin-omcommon',  'srvadmin-storageservices'] )
       }
       
       default:
       {
           notify {"Could not determine manufaturer, assume not dell!!!": }
       }
   }
}
