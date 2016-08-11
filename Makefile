py:
	amber.python setup.py build_ext -i
test:
	amber.python try.py
clean:
	rm -rf ./build
	rm cutil.so cutil.c 
