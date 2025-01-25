# Accelerating DeepWalk via Context-Level Parameter Update and Huffman Tree Pruning
accepted by DASFAA 2025 (short)

# How to run

## Compile 
```
cd CLPU && make
```
or
```
cd HTP && make
```

## Node classification
For CLPU
```
bash run_nodeclass.sh ${graphname}
```
For HTP
```
bash run_nodeclass.sh ${graphname} ${C}
```

## Link prediction
For CLPU
```
bash run_linkpred.sh ${graphname}
```
For HTP
```
bash run_linkpred.sh ${graphname} ${C}
```

# How to evaluate

## Node classification
1. Copy output file name from directory ``nodeclass_output`` and paste it into ``nodeclassification/test_CLPU.sh`` or ``nodeclassification/test_HTP.sh``.
2. Modify ``graphname`` in ``test_CLPU.sh`` or ``test_HTP.sh``.
3. Run ``test_CLPU.sh`` or ``test_HTP.sh``. Output is saved at directory ``result``.

## Link prediction
1. Copy output file name from directory ``linkpred_output`` and paste it into ``linkprediction/test_CLPU.sh`` or ``linkprediction/test_HTP.sh``.
2. Modify ``graphname`` in ``test_CLPU.sh`` or ``test_HTP.sh``.
3. 3. Run ``test_CLPU.sh`` or ``test_HTP.sh``. Output is saved at directory ``${Algorithm}/linkpred_result``.
