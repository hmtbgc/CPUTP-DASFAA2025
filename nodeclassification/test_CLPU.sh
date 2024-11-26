algorithm="CLPU"
embedding_root="../"${algorithm}"/nodeclass_output/"
graphname="wiki"
filename="20241126_183209_wiki_CLPU_threads16_d128_r10_l80_k10_lr0.025_lastnum6_seed1234"
embedding=${embedding_root}${filename}".emb"
label="./label/"${graphname}".label"
output="./result/"${filename}".out"



for ratio in 0.7; do
    output="./result/"${filename}"_train"${ratio}".out"
    python predict.py -e ${embedding} -l ${label} -o ${output} -r ${ratio} 
done
