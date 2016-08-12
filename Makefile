py:
	amber.python setup.py build_ext -i
	amber.python -m pip install -e .

test:
	amber.python tests/test.py

clean:
	rm -rf ./build
	rm ./mdgdx/cutil.so
	rm ./mdgdx/cutil.c 

i:
	amber.ipython

push:
	git push upstream master
