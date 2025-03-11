
cd test	
for i in 1 2
do
  echo "Test $i:"
  bash -c "$(tail -n 1 compileExecTest$i.txt)"
  if [ ! -z $(cmp supercell_corr2.dat Test$i.txt) ]
    then
      echo "ERROR: Test $i failed"
    else
      echo "Test $i passed."
  fi
done

#echo "Cleaning test folder."
rm  *_seed*.f* Compile_Exec.txt *.dat

cd ..