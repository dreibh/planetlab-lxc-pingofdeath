# Makefile for building and installing the application
#   level tools for the Planetlab "ping of death" feature.
#
# Targets are:
# all: builds all of the components
# install: installes the tools into the planetlab bin directory
# test: runs the tests on the current machine
#

ALLBUILD=pl-poddoit pod ipod-2.0.tar.gz
PLBIN=/usr/local/planetlab/bin/
INIT=/etc/init.d/

all: $(ALLBUILD)

pod: pod.src disable_pod.sh  enable_pod.sh  status_pod.sh
	./shell_include --source pod.src --destination pod 

ipod-2.0.tar.gz: pod ipod.spec
	mkdir ipod-2.0
	cp ipod.spec disable_pod.sh enable_pod.sh INTEL_LICENSE.txt ipod.patch \
	Makefile pl-podcntl pl-poddoit.c pl-podset pl-podzap pod.src \
	README shell_include status_pod.sh test-pod ipod-2.0
	tar cvfz ipod-2.0.tar.gz ipod-2.0
	rm -rf ipod-2.0

pl-poddoit: pl-poddoit.c
	gcc pl-poddoit.c -o pl-poddoit

install: all
	cp pl-poddoit $(PLBIN)
	chmod 555 $(PLBIN)/pl-poddoit
	cp pod $(INIT)
	chmod 555 $(INIT)/pod

clean:
	rm -f pod pl-poddoit ipod-2.0.tar.gz
