# Services configuration - ad hoc services to be managed based on general SOE requirements.
#   Note that services defined in this class may conflict
#   with other definitions in the OS SOE/Application stack. If we surround the services
#   definitions with 'unless Service[$svc] {' then depending on the operating system
#   and how Puppet builds the catalog, we can skip acting on disable.
#
# @summary manage ad-hoc services.
#
# @param disabled_services
#   Hash of services and tags to be disabled. Defaults are generally to disable insecure
#   services as defined by CIS and policy.
# @param enabled_services
#   Array of services to be installed. Overrides disabled services.
# @param disabled_adhoc_services
#   Hash of adhoc services and tags to be disabled. Merges with disabled_services hash.
# @param enabled_adhoc_services
#   Array of adhoc services to be installed. Merges with enabled_services array.
#
# @example Override all SOE defaults on disabled services
#    class {'profile::soe_l::services':
#      disabled_services => {},
#    }
#
# @example Allow most disabled services defaults but ensure that telnet daemon is kept for testing
#    class {'profile::soe_l::services':
#      enabled_services => ['telnetd'],
#    }
#
# @example Allow most disabled service defaults but add more to disable.
#    class {'profile::soe_l::services':
#      disabled_adhoc_services => {"svc1":{"tag":"project_x_requirement"},"svc2":{"tag":"project_y_requirement"}},
#    }
#
class profile::soe_w::services (
  Hash $disabled_services = {},
  Array $enabled_services = [],
  Hash $disabled_adhoc_services = {},
  Array $enabled_adhoc_services = [],
  Array $running_services = [],
  Array $running_adhoc_services = [],
) {
  # Merge hashes and arrays
  $disabled = $disabled_adhoc_services + $disabled_services
  $enabled_tmp = [$enabled_services, $enabled_adhoc_services]
  $enabled = unique(flatten($enabled_tmp))
  $running_tmp = [$running_services, $running_adhoc_services]
  $running = unique(flatten($running_tmp))

  # Tag for collector
  tag auto_services

  # Firstly we work on services to be removed from the system.
  if ($disabled != undef) {
    $disabled.each | String $svc, Hash $settings| {
      if ! (
        $settings["name"] in $enabled and
        $settings["name"] in $running
      ) {
        @service { $svc :
          ensure => stopped,
          *      => $settings,
        }
      }
    }
  }

  # Once we have disabled what is not to be running, add in what is.
  # Note that these are adhoc services or exclusions from CIS standards, with no
  # associated packages. For fully managed services based on a package,
  # submit a new class.
  if ($enabled != undef) {
    $enabled.each | String $svc| {
        @service { $svc :
          name   => $svc,
          enable => true,
        }
    }
  }

  if ($running != undef) {
    $running.each | String $svc| {
        @service { $svc :
          ensure => running,
          name   => $svc,
          enable => true,
        }
    }
  }

  # Collector
  Service <| tag == auto_services |>

}
