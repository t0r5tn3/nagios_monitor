# NagiosMonitor

TODO: improve this frequently!

The nagios_monitor should add the ability to monitor your applications health
and tell your nagios server about it (NSCA) (TODO: or let nagios just ask for it  (NRPE)).

At this point only elasticsearch observation is implemented in parts, other might be added in future.
The elasticsearch configuration is autodetected for tire and searchkick, other gems are not yet supported.

There is plenty of space for improvements ...

## Installation

Add this line to your application's Gemfile:

    gem 'nagios_monitor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nagios_monitor

Add the nagios configuration to your #{Rails.root}/config/nagios.yml (see config/nagios.yml.example)
and update 'host' and 'port' according to your local nagios setup. 'hostname' and 'service_name'
in additions have to be configured in the configuration of the nagios server (services.cfg), for
details view the nagios/nsca documentation. 'hostname' should represent the machine your service is
running on, and 'service_name' should identify the the observed application.

## Usage

To check the status of the service just run the rake task from the command line

    $ rake nagios_monitor:send_health_status

or as cronjob including the propper rails environment

    RAILS_ENV=production bundle exec rake nagios_monitor:send_health_status


## Contributing

1. Fork it ( http://github.com/<my-github-username>/nagios_monitor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
