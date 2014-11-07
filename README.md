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
**NOTE:** If the `aiccu` package isn't already installed on your system, it will be installed as a dependency of `vyatta-aiccu`. The `aicuu` package will then asks for your SIXXS username and password. **Simply hit ENTER when it does that!**. The actual configuration of aiccu will happen from the EdgeOS CLI. If you do enter a username or password during installation, the `aiccu` package will attempt to configure the aiccu daemon to be launched by the init system, which will fail because of a dependency issue! The EdegeOS integration provided by `vyatta-aiccu` takes care of launching aiccu once per configured aiccu interface, and at the right time during the boot proccess. Having the init system launch aiccu is neither necessary nor desirable!

You then need to configure a aiccu interface using the EdgeOS CLI. Assuming that you want to establish a tunnel provided by sixxs.net, you only need to set your account's username, password, and the ID of the tunnel you want to establish. To avoid store your sixxs.net password unencrypted in the EdgeOS configuration, consider setting a tunnel-specific password in the sixxs.net webinterface! Then set &lt;username&gt; to &lt;sixxs handle&gt;/&lt;tunnel id&gt; and &lt;password&gt; to the tunnel-specific you specified in the webinterface. Note that you still need to set &lt;tunnel> to the &lt;tunnel id&gt; as well.
    
Here is an example.
```
configure
set interfaces aiccu aiccu0 tic tunnel <TIC Tunnel ID>
set interfaces aiccu aiccu0 tic username <TIC username>
set interfaces aiccu aiccu0 tic password <TIC password>
commit
```
This should bring up the `aiccu0` interface. You can check that by doing `run show interfaces` (or just `show interfaces` if you have already exited configuration mode). To access the IPv6 internet via your tunnel, you'll need to an IPv6 default route, which you can do with

```
set protocols static interface-route6 ::/0 next-hop-interface aiccu0
commit
```

You should now be able to ping arbitrary IPv6 hosts. Try doing `run ping6 www.google.com` to verify that things work as expected.

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
