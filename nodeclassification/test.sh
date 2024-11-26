# current_time=$(date +"%Y%m%d_%H%M%S")
# algorithm="deepwalk_raw"
# embedding_root="../"${algorithm}"/output/"
# graphname="blogcatalog"
# filename="20241030_214027_blogcatalog_deepwalk_raw_threads16_d128_r10_l80_k10_lr0.025_seed1234"
# embedding=${embedding_root}${filename}".emb"
# label="./label/"${graphname}".label"
# output="./result/"${filename}".out"

# algorithm="deepwalk_improved"
# embedding_root="../"${algorithm}"/output/"
# graphname="blogcatalog"
# filename="20241101_160933_blogcatalog_deepwalk_improved_threads16_d128_r10_l80_k10_lr0.025_seed1234_lastnum6"
# embedding=${embedding_root}${filename}".emb"
# label="./label/"${graphname}".label"
# output="./result/"${filename}".out"


algorithm="deepwalk_improved"
embedding_root="../"${algorithm}"/output/"
graphname="flickr"
filename="20241110_000447_flickr_deepwalk_improved_threads16_d128_r10_l80_k10_lr0.025_seed1234_lastnum10"
embedding=${embedding_root}${filename}".emb"
label="./label/"${graphname}".label"
output="./ab_result/"${filename}".out"



for ratio in 0.7; do
    output="./ab_result/"${filename}"_train"${ratio}".out"
    python predict.py -e ${embedding} -l ${label} -o ${output} -r ${ratio} 
done
