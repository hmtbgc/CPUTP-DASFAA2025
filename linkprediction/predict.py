import numpy as np
import argparse
from tqdm import tqdm
import random
import numpy as np

def cosine(x, y):
    x_norm = np.linalg.norm(x)
    y_norm = np.linalg.norm(y)
    x = x / x_norm
    y = y / y_norm
    return np.dot(x, y)

def check(path, emb):
    data = []
    with open(path, "r") as f:
        for line in tqdm(f):
            t = line.split()
            u, v = int(t[0]), int(t[1])
            u_emb, v_emb = emb[u], emb[v]
            x = cosine(u_emb, v_emb)
            data.append(x)
    return np.array(data)

def get_embedding(path):
    with open(path, "r") as f:
        node_num = int(f.readline().strip())
        emb = [[] for _ in range(node_num)]
        for line in tqdm(f):
            t = line.split()
            id = int(t[0])
            for n in t[1:]:
                emb[id].append(float(n))
    return np.array(emb)

def get_len(path):
    with open(path, "r") as f:
        len = 0
        for line in tqdm(f):
            len += 1
    return len

def get_result(path, emb, max_number):
    out = []
    num = 0
    with open(path, "r") as f:
        for line in tqdm(f):
            t = line.split()
            u, v = int(t[0]), int(t[1])
            u_emb, v_emb = emb[u], emb[v]
            x = cosine(u_emb, v_emb)
            out.append(x)
            num += 1
            if (num >= max_number):
                break
    return np.array(out)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--seed", "-s", default=1234, type=int)
    parser.add_argument("--graphname", "-g", type=str)
    parser.add_argument("--embedding_name", "-e", type=str)
    parser.add_argument("--output", "-o", type=str)
    parser.add_argument("--select_num", "-t", type=int, default=10000)
    args = parser.parse_args()


    
    graph_name = args.graphname
    seed = args.seed
    embedding_name = args.embedding_name
    output_root = args.output
    select_num = args.select_num
    test_num = 5
    positive_path = "../linkpred_input/" + graph_name + "/positive.edgelist"
    negative_path = "../linkpred_input/" + graph_name + "/negative.edgelist"

    emb = get_embedding(embedding_name)

    print("get embedding is ok!")

    len1 = get_len(positive_path)
    select_num = min(select_num * test_num, len1)

    positive = get_result(positive_path, emb, select_num)
    negative = get_result(negative_path, emb, select_num)
    correct = 0

    for i in tqdm(range(0, select_num, 100)):
        l = min(100, select_num - i)
        a = np.expand_dims(positive, 1)
        a = np.repeat(a, l, 1)
        b = np.expand_dims(negative[i:i+l], 0)
        b = np.repeat(b, select_num, 0)
        correct += np.sum(a > b)
    auc = correct / (select_num * select_num)
 
    print("auc is ok!")
    # Test
    f = open(output_root, "w")
    print(f"auc:{auc*100:.2f}", file=f)
    f.close()




