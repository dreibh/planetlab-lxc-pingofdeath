Summary: PlanetLab ICMP Ping of Death
Name: ipod
Version: 2.0
Release: 2
Copyright: GPL
Group: System Environment/Kernel
Source: ipod-2.0.tar.gz

%description
Startup service to enable Ping Of Death

%prep

%setup

%build
make

%install
make install

%clean

%files
%defattr(-, root, root)
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

