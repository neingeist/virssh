PREFIX=/usr/local

default:

install:
	install -o root -g root -m 0755 virssh $(DESTDIR)$(PREFIX)/bin/virssh
