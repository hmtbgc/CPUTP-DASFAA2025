algorithm="HTP"
embedding_root="../"${algorithm}"/nodeclass_output/"
graphname="wiki"
filename="20241126_183946_wiki_HTP_threads16_d128_r10_l80_k10_lr0.025_seed1234_lastnum8"
embedding=${embedding_root}${filename}".emb"
label="./label/"${graphname}".label"
output="./result/"${filename}".out"



for ratio in 0.7; do
    output="./result/"${filename}"_train"${ratio}".out"
    python predict.py -e ${embedding} -l ${label} -o ${output} -r ${ratio} 
done
