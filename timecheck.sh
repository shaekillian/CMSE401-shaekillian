#!/bin/bash --login

best_fitness=999999
best_seed=0
echo "Benchmarking reverse GOL serial version..."
echo "" > results.txt
for seed in {1..10}
do 
	echo "Running seed $seed..."
	{ time ./revGOL cmse2.txt $seed ; } 2>&1 | tee output_$seed.txt
	fitness=$(grep "Fitness=" output_$seed.txt | awk -F'=' '{print $2}' | awk '{print $1}')
	if [ "$fitness" -lt "$best_fitness" ]; then
        best_fitness=$fitness
        best_seed=$seed
        cp output_$seed.txt serial_best.txt
    fi
done
echo "Best fitness: $best_fitness (Seed $best_seed)" >> results.txt
