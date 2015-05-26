# Define:
# Class: knock
#
# Install, enable and configure the knock daemon.
#
# Parameters:
#
#  $sequence:
#    the sequence of ports and protocol knock expects
#  $interface:
#    the interface which knockd will bind on
#  $logfile:
#    the logfile which knockd write too ( if syslog is false )
#  $syslog:
#    True or False to switch between logging to file or syslog
#  $seq_timeout:
#    The maximum time expected between knocks on ports
#  $tcpflags:
#     The TCP flag to listen for
#  $start_command:
#     The command to open iptables
#  $stop_command:
#     The command to close iptables
#  $command_timeout:
#     The amount of time until the stop_command executes
#
# Simple Usage :
#  include knock
#
# Advanced Usage :
#  class { 'knock':
#    sequence      = '1231:udp,1232:tcp,1233:udp',
#    interface     = 'eth1',
#    syslog        = true,
#    start_command = '/sbin/iptables -I INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
#    stop_command  = '/sbin/iptables -D INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
#  }
#
class knock (
    $sequence      = '123:udp,456:udp,789:udp',
    $interface     = 'eth0',
    $logfile       = '/var/log/knockd.log',
    $syslog        = false,
    $seq_timeout   = 5,
    $tcpflags      = 'syn',
    $start_command = '/sbin/iptables -I INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
    $cmd_timeout   = '30',
    $stop_command  = '/sbin/iptables -D INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
) {

    # Main packages and service it provides
    if $::osfamily == 'RedHat' {
    
    package {
        'knock':
            ensure => installed;
    }
    service {
        'knockd':
            ensure      => running,
            enable      => true,
            hasrestart  => true,
            require     => File['/etc/init.d/knockd'];
    }

    file { '/etc/init.d/knockd':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template("${module_name}/knockd.redhat.erb"),
        require => Package['knock'];
    }
  
    # Main configuration file
    file {
        '/etc/knockd.conf':
            owner   => 'root',
            group   => 'root',
            mode    => '0700',
            content => template("${module_name}/knockd.conf.erb"),
            notify  => Service['knockd'];
    }
    # Logrotate for our custom log file
    file { '/etc/logrotate.d/knockd':
        content => template("${module_name}/knockd-logrotate.erb"),
    }

}
