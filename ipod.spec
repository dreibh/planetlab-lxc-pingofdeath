%define name ipod
%define version 2.0
%define release 4.planetlab%{?date:.%{date}}

Summary: PlanetLab ICMP Ping of Death
Name: %{name}
Version: %{version}
Release: %{release}
Copyright: GPL
Group: System Environment/Kernel
Source: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}root

%description
Startup service to enable Ping Of Death

%prep

%setup

%build
make


%install
mkdir -p $RPM_BUILD_ROOT/usr/local/planetlab/bin
mkdir -p $RPM_BUILD_ROOT/etc/init.d

cp pl-poddoit $RPM_BUILD_ROOT/usr/local/planetlab/bin/
cp pod $RPM_BUILD_ROOT/etc/init.d/


%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT


%files
%defattr(0755, root, root)
/etc/init.d/pod
/usr/local/planetlab/bin/pl-poddoit

%pre

%post 
RUNLEVEL=`/sbin/runlevel`

if [ "$1" = 1 ]; then
	chkconfig --add pod
	chkconfig pod on

	if [[ "$RUNLEVEL" != "unknown" ]]; then
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
* Mon Apr 12 2004 Aaron Klingaman <alk@cs.princeton.edu>
- moved to new build process
- added change log
