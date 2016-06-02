class mydell::omsa_repo ( )
#inherits dell::params 
{
  tag("repo")

   file { "/etc/yum.repos.d/dell-omsa-repository.repo": 
          source => "puppet:///modules/${module_name}/dell-omsa-repository.repo",
          ensure => present,
          mode => 0444,
          owner => root,
          group => root,
   }
}

