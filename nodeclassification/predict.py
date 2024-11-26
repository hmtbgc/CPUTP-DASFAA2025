from ast import arg
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import f1_score
from sklearn.preprocessing import StandardScaler
import numpy as np
import argparse 
from tqdm import tqdm


def readdata(filename):
    f = open(filename, "r")
    lines = f.readlines()
    nodenum = int(lines[0].split()[0])
    output = [[] for i in range(nodenum)]
    for line in lines[1:]:
        t = line.split()
        id = int(t[0])
        emb = [float(x) for x in t[1:]]
        output[id] = emb
    return np.array(output), nodenum

def readlabel(labelfile):
    f = open(labelfile, "r")
    lines = f.readlines()
    output = []
    for line in lines:
        t = line.split()
        label = int(t[0])
        output.append(label)
    return np.array(output)

def readmultilabel(labelfile, nodenum, labelnum):
    f = open(labelfile, "r")
    lines = f.readlines()
    output = np.zeros((nodenum, labelnum))
    for line in lines:
        t = line.split()
        id, label = int(t[0]), int(t[1])
        output[id][label] = 1.0
    return output


def train_test_split(n, train_ratio):
    train_number = int(n * train_ratio)
    indices = list(range(n))
    np.random.shuffle(indices)
    train_id = indices[:train_number]
    test_id = indices[train_number:]
    return train_id, test_id



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--seed", "-s", default=1234, type=int)
    parser.add_argument("--embedding", "-e", type=str)
    parser.add_argument("--label", "-l", type=str)
    parser.add_argument("--train_ratio", "-r", default=0.7, type=float)
    parser.add_argument("--LR_C", "-C", default=0.1, type=float)
    parser.add_argument("--output", "-o", type=str)

    args = parser.parse_args()

    X, nodenum = readdata(args.embedding)
    train_ratio = args.train_ratio
    y = readlabel(args.label)
    seed = args.seed

    score = 0.0

    f = open(args.output, "w")

    num = 5
    
    macro_score, micro_score = [], []
    
    for i in tqdm(range(num)):

        train_id, test_id = train_test_split(nodenum, train_ratio)
        X_train, y_train = X[train_id], y[train_id]
        X_test, y_test = X[test_id], y[test_id]
        scaler = StandardScaler()
        X_train = scaler.fit_transform(X_train)
        X_test = scaler.transform(X_test)    
        clf = LogisticRegression(random_state=seed, max_iter=500, C=args.LR_C, tol=1e-5).fit(X_train, y_train)
        y_pred = clf.predict(X_test)
        macro_f1 = f1_score(y_test, y_pred, average="macro")
        micro_f1 = f1_score(y_test, y_pred, average="micro")
        print(f"macro: {i+1}th test result: {macro_f1*100:.2f}", file=f)
        print(f"micro: {i+1}th test result: {micro_f1*100:.2f}", file=f)
        macro_score.append(macro_f1*100)
        micro_score.append(micro_f1*100)

    print(f"macro result: {np.mean(macro_score):.2f}±{np.std(macro_score):.2f}", file=f)
    print(f"micro result: {np.mean(micro_score):.2f}±{np.std(micro_score):.2f}", file=f)
    
    f.close()

    

