default: linux

linux: clean
	./bash-starter.sh --test Linux

mac: clean
	./bash-starter.sh --test Darwin

clean:
	rm -rf ./USER_TEST
