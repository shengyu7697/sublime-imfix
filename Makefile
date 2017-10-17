
all: libsublime-imfix.so

libsublime-imfix.so:
	gcc -shared -o libsublime-imfix.so sublime-imfix.c `pkg-config --libs --cflags gtk+-2.0` -fPIC

clean:
	rm -rf libsublime-imfix.so

install: all
	cp libsublime-imfix.so /opt/sublime_text/
