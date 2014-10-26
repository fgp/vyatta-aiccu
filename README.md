Introduction
------------

vyatta-aiccu provides support for establishing AYIYA tunnels with AICCU.

Installation
------------

First, add the debian APT repositories and the repository of this project

```
configure
set system package repository squeeze components 'main contrib non-free'
set system package repository squeeze distribution squeeze
set system package repository squeeze url http://http.us.debian.org/debian

set system package repository squeeze-security components main
set system package repository squeeze-security distribution squeeze/updates
set system package repository squeeze-security url http://security.debian.org

set system package repository vyatta-aiccu components contrib
set system package repository vyatta-aiccu distribution squeeze
set system package repository vyatta-aiccu url https://github.com/fgp/vyatta-aiccu/raw/gh-pages/debian/
commit
```

Then install the package with
```
sudo apt-get update
sudo apt-get install vyatta-aiccu
```

And configure it. Assuming that you want to establish a tunnel provided by sixxs.net, you only need to set your account's username, password, and the ID of the tunnel you want to establish. To avoid store your sixxs.net password unencrypted in the EdgeOS configuration, consider setting a tunnel-specific password in the sixxs.net webinterface! Then set <username> to <sixxs handle>/<tunnel id> and <password> to the tunnel-specific you specified in the webinterface. Note that you still need to set <tunnel> to the <tunnel id> as well.
    
Here is an example.
```
configure
set interfaces aiccu aiccu0 tic tunnel <TIC Tunnel ID>
set interfaces aiccu aiccu0 tic username <TIC username>
set interfaces aiccu aiccu0 tic password <TIC password>
commit
```

Firewalling for incoming, outgoing and local packets is enables as for any other IPv6 interface on EdgeOS, i.e. by doing
```
set interfaces aiccu aiccu0 firewall in ipv6-name <ruleset>
set interfaces aiccu aiccu0 firewall local ipv6-name <ruleset>
set interfaces aiccu aiccu0 firewall out ipv6-name <ruleset>
```

If your tunnel provider isn't sixxs.net, you will need to specify the hostname of the tic server to use with
```
set interfaces aiccu aiccu0 tic server <TIC server>
```
and set
```
set interfaces aiccu aiccu0 tic requiretls false
```
if your TIC server does not support TLS.
