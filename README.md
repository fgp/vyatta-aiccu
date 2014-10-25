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

And configure it
```
configure
FIXME
commit
```
