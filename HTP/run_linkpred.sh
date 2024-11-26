current_time=$(date +"%Y%m%d_%H%M%S")
graphname=$1
algorithm="HTP"
THREADS="16"
NWALKS="10"
DIM="128"
WINDOW_SIZE="10"
WALK_LENGTH="80"
lr="0.025"
seed="1234"
lastnum=$2
INPUT="../linkpred_input/"${graphname}"/positive_train.bscr"
OUTPUT="./linkpred_output/"${current_time}"_"${graphname}"_"${algorithm}"_threads"${THREADS}"_d"${DIM}"_r"${NWALKS}"_l"${WALK_LENGTH}"_k"${WINDOW_SIZE}"_lr"${lr}"_seed"${seed}"_lastnum"${lastnum}".emb"
LOG="./linkpred_log/"${current_time}"_"${graphname}"_"${algorithm}"_threads"${THREADS}"_d"${DIM}"_r"${NWALKS}"_l"${WALK_LENGTH}"_k"${WINDOW_SIZE}"_lr"${lr}"_seed"${seed}"_lastnum"${lastnum}".log"
./${algorithm} -input ${INPUT} -output ${OUTPUT} -log ${LOG} -threads ${THREADS} -nwalks ${NWALKS} -dim ${DIM} -walklen ${WALK_LENGTH} -window ${WINDOW_SIZE} -lr ${lr} -seed ${seed} -verbose 2 -lastnum ${lastnum}