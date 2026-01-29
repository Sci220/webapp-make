PREFIX ?= $(HOME)/.local

install:
	install -Dm755 webapp-make $(DESTDIR)$(PREFIX)/bin/webapp-make
	install -Dm755 webapp-make-gui $(DESTDIR)$(PREFIX)/bin/webapp-make-gui

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/webapp-make
	rm -f $(DESTDIR)$(PREFIX)/bin/webapp-make-gui

.PHONY: install uninstall
