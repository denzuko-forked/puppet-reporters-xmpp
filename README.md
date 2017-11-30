# Puppet Reporters XMPP

## Description

A Puppet report handler for sending notifications of failed runs to Jabber/XMPP gateway for slack.

## Requirements

* ``` CentOS, RHEL, or Ubuntu server ```
* `xmpp4r gem`
* `puppet`
* `puppetlabs/hiera`

## Installation & Usage

1. Install the `xmpp4r` gem on your Puppet master
   `$ ssh puppetmaster sudo gem install xmpp4r`

2.  Install puppet-xmpp as a module on your Puppet master
   `$ ssh puppetmaster sudo puppet module install denzuko-reporters-xmpp`

3.  Update the `user`, `secret`, `server`, and `target` variables in `hieradata/reporters/xmpp.yaml`.

4.  Optionally change `environment` in `hieradata/reporters/xmpp.yaml`.  You can set this value to a
    string or an array of strings.  These strings are the names of acceptable environments
    to send alerts for.  If you don't change this option from the default of ALL the
    processor will send an alert for errors in all environments.

5.  Enable pluginsync and reports on your master and clients in `puppet.conf`
```
        [master]
        report = true
        reports = xmpp
        pluginsync = true
        [agent]
        report = true
        pluginsync = true
```

6.  Run the Puppet client and sync the report as a plugin

## Author
Dwight Spencer <dwightaspencer@gmail.com>

## License

    Author:: Dwight Spencer <dwightaspencer@gmail.com>
    Copyright:: Copyright (c) 2017 Dwight Spencer
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
### External Links
* [Jabber slack intergration](https://www.jetbrains.com/help/youtrack/standalone/Slack-Integration.html)
