%define name ipod
%define version 2.2
%define release 1%{?pldistro:.%{pldistro}}%{?date:.%{date}}

Vendor: PlanetLab
Packager: PlanetLab Central <support@planet-lab.org>
Distribution: PlanetLab 3.0
URL: http://cvs.planet-lab.org/cvs/ipod

Summary: PlanetLab ICMP/UDP Ping of Death
Name: %{name}
Version: %{version}
Release: %{release}
License: GPL
Group: System Environment/Kernel
Source: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}root

%description
Startup service to enable Ping Of Death

%package client
Summary: PlanetLab ICMP/UDP Ping of Death Client Tools
Group: System Environment/Kernel
Requires: python

%description client
Client utilities to use Ping of Death

%prep

%setup

%build
make


%install
# ipod
mkdir -p $RPM_BUILD_ROOT/usr/local/planetlab/bin
mkdir -p $RPM_BUILD_ROOT/etc/init.d

cp pl-poddoit $RPM_BUILD_ROOT/usr/local/planetlab/bin/
cp pod $RPM_BUILD_ROOT/etc/init.d/

# ipod-client
mkdir -p $RPM_BUILD_ROOT/usr/bin/
cp pod.py $RPM_BUILD_ROOT/usr/bin

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT


%files
%defattr(0755, root, root)
/etc/init.d/pod
/usr/local/planetlab/bin/pl-poddoit

%files client
%defattr(0755, root, root)
/usr/bin/pod.py


%pre

%post 
if [ "$1" = 1 ]; then
	chkconfig --add pod
	chkconfig pod on

	if [[ "$PL_BOOTCD" != "1" ]] ; then
		/etc/init.d/pod start
	fi
fi

%preun
if [ "$1" = 0 ]; then
	chkconfig pod off
	chkconfig --del pod
fi

%postun


%changelog
* Wed Jan 11 2006 Aaron Klingaman <alk@absarokasoft.com>
- add support for building client tool rpm

* Fri Aug  5 2005 Aaron Klingaman <alk@absarokasoft.com>
- updated to use new source of POD Hash (/etc/planetlab/session)
- minor build changes to simply build process
- remove unnecessary call to runlevel in post section

* Mon Apr 12 2004 Aaron Klingaman <alk@cs.princeton.edu>
- moved to new build process
- added change log
