# Makefile for building and installing the application
#   level tools for the Planetlab "ping of death" feature.
#
# Targets are:
# all: builds all of the components
# install: installes the tools into the planetlab bin directory
# test: runs the tests on the current machine
#

ALLBUILD=pl-poddoit pod 

all: $(ALLBUILD)

pod: pod.src disable_pod.sh  enable_pod.sh  status_pod.sh
	./shell_include --source pod.src --destination pod 

pl-poddoit: pl-poddoit.c
	gcc pl-poddoit.c -o pl-poddoit

clean:
	rm -f pod pl-poddoit

