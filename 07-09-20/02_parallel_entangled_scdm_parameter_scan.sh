#!/bin/bash
# dependencies :
#  1. scdm.py
#  2. parameter_set_to_scan.dat (read in as [dim, mu, sigma] order per line)

nproc=32
for line in `cat ./entangled_parameter_set_to_scan_one.dat`
do
  while [[ `jobs | wc -l ` -ge $nproc ]];
  do
    sleep 1
  done
  # split the input line --
  nwan=`echo $line | awk -F"," '{print $1}'`
  mu=`echo $line | awk -F"," '{print $2}'`  
  sigma=`echo $line | awk -F"," '{print $3}'`
  #  
  cp *.eig SCDM_EIG.input # file input needed by scdm.py
  python scdm_entangled.py $nwan $mu $sigma &
  #python3 obtl_spread.py "scdm_phi_dim_${dim}_mu_${mu}_sigma_${sigma}" &
done

wait # wait for unfinished jobs in the background
