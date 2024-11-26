#!/bin/bash
current_time=$(date +"%Y%m%d_%H%M%S")
graphname=$1
algorithm="CLPU"
THREADS="16"
NWALKS="10"
DIM="128"
WINDOW_SIZE="10"
WALK_LENGTH="80"
lr="0.025"
seed="1234"
lastnum="6"
INPUT="../nodeclass_input/"${graphname}".bscr"
OUTPUT="./nodeclass_output/"${current_time}"_"${graphname}"_"${algorithm}"_threads"${THREADS}"_d"${DIM}"_r"${NWALKS}"_l"${WALK_LENGTH}"_k"${WINDOW_SIZE}"_lr"${lr}"_lastnum"${lastnum}"_seed"${seed}".emb"
LOG="./nodeclass_log/"${current_time}"_"${graphname}"_"${algorithm}"_threads"${THREADS}"_d"${DIM}"_r"${NWALKS}"_l"${WALK_LENGTH}"_k"${WINDOW_SIZE}"_lr"${lr}"_lastnum"${lastnum}"_seed"${seed}".log"
./${algorithm} -input ${INPUT} -output ${OUTPUT} -log ${LOG} -threads ${THREADS} -nwalks ${NWALKS} -dim ${DIM} -walklen ${WALK_LENGTH} -window ${WINDOW_SIZE} -lr ${lr} -lastnum ${lastnum} -seed ${seed} -verbose 2 