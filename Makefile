py:
	amber.python setup.py build_ext -i
test:
	amber.python test.py
clean:
	rm -rf ./build
	rm cutil.so cutil.c 

i:
	amber.ipython

push:
	git push upstream master
