update tb_chemical_space 
set molfile=substring(molfile,0,position('M  END' in molfile)+6 )||E'\n'||'$$$$'||E'\n'
where  position('M  END' in molfile)<>0;




