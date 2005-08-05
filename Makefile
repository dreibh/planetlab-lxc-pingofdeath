# Makefile for building and installing the application
#   level tools for the Planetlab "ping of death" feature.
#
# Targets are:
# all: builds all of the components
# install: installes the tools into the planetlab bin directory
# test: runs the tests on the current machine
#

ALLBUILD=pl-poddoit

all: $(ALLBUILD)

pl-poddoit: pl-poddoit.c
	gcc pl-poddoit.c -o pl-poddoit

clean:
	rm -f pl-poddoit
