#!/bin/bash
for f in $( ls "/Groups/assembly/reads" ); do
	if [ "${f: -6}" == ".fasta" ]; then
		echo $f
		/Groups/assembly/bin/velvet_1.2.10/velveth "/Groups/assembly/VelvetOutput/$f" 31 -shortPaired -fasta "/Groups/assembly/reads/$f"
	fi
done