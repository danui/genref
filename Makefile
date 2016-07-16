default:
	@echo make install - Install to ~/bin/genref and chmod u+x

install:
	mkdir -p ~/bin
	cp -r src/genref.sh ~/bin/genref
	chmod u+x ~/bin/genref

clean:
	find . -name "*~" -exec rm -vf \{\} \+

.PHONY: default install clean
