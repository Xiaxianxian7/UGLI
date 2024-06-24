clear;
clc;

%Please modify the dataset name that you want to test.
load(['WebKB_Texas.mat'],'fea','gt');
X = fea;
Y = gt;
numclass = length(unique(Y));
lamda = 1;
alpha = 100;
m = numclass;

tic;
preY = UGLI(X,numclass,m,lamda,alpha); 
toc;
 tempScores = computeFourClusteringMetrics(preY,Y);
 threeScores = [tempScores(1), tempScores(3), tempScores(4)] %  the scores of NMI, ACC, and PUR.
            



