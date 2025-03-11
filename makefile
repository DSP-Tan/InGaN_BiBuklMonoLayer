clean_test:
	find test -name "*.o"   -print -delete
	find test -name "*.f*"  -print -delete
	find test -name "*.dat" -print -delete


test_supercell:
	test/test_supercell.sh
