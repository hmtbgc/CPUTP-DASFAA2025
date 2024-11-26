# #!/bin/bash
# algorithm=$1
# embedding_root="../"${algorithm}"/output/"
# graphname=$2


# prefix=${graphname}"_"${algorithm}
# length=${#prefix}
# # echo ${length}
# # echo ${prefix}
# label="./label/"${graphname}".label"
# for file in `ls ${embedding_root}`
# do  
#     if [[ ${file} == ${prefix}* ]] 
#     then
#         filename=${file%????}
#         embedding=${embedding_root}${file}
#         output="./result/"${filename}".out"
#         python predict.py -e ${embedding} -l ${label} -o ${output} 
#         # echo ${file}
#     fi
# done

algorithm=$1
embedding_root="../"${algorithm}"/linkpred_output/"
result_root="../"${algorithm}"/linkpred_result/"
graphname=$2
filename=$3
python predict.py -g ${graphname} -e ${embedding_root}${filename}".emb" -o ${result_root}${filename}".out"  
