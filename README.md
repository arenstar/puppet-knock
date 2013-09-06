puppet-knock
============

puppet port knocking


[![Build Status](https://secure.travis-ci.org/arenstar/puppet-knock.png)](http://travis-ci.org/arenstar/puppet-knock)

Overview
--------

Install and manageme knockd.

Usage
-----

Example:

Basic enabling of smartmontools :

    include knock

Advanced example :

    class { 'knock':
        sequence      = '1231:udp,1232:tcp,1233:udp',
        interface     = 'eth1',
        syslog        = true,
        start_command = '/sbin/iptables -I INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
        stop_command  = '/sbin/iptables -D INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT',
    }

Advanced example, using only hieradata :



    classes:
      - knock

    knock::sequence:       '1231:udp,1232:tcp,1233:udp'
    knock::interface:      'eth1'
    knock::syslog:         true
    knock::start_command:  '/sbin/iptables -I INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT'
    knock::stop_command:   '/sbin/iptables -D INPUT -s %IP% -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT'
