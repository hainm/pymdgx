py:
	amber.python setup.py build_ext -i
	amber.python -m pip install -e .

test:
	amber.python tests/test_energy_and_force.py

clean:
	rm -rf ./build
	rm ./mdgdx/mdgx.so
	rm ./mdgdx/mggx.c 
	rm ./*/*.pyc

i:
	amber.ipython

push:
	git push upstream master
