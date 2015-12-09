all:
	mcs DTSSManager.cs -r:Mono.Posix.dll -out:DTSSManager.exe
run:
	mono DTSSManager.exe
clean:
	rm -rf DTSSManager.exe
usage:
	echo "Usage: make {all|run|clean|usage}"
