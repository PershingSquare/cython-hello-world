LIB_DIR = lib

default: cythonwrapper

cythonwrapper: setup.py add.pyx $(LIB_DIR)/libadd.a
	python3 setup.py build_ext --inplace

$(LIB_DIR)/libadd.a:
	make -C $(LIB_DIR) libadd.a


clean:
	rm -rf *.o *.a *.so *.html add.c build
