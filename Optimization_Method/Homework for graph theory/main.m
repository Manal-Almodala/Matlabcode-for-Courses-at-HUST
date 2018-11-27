clc,clear

%% set the target graph of successive approximation method
%(mainly the adjacent matrix)
M=[1 6 3 0 0 0 0 0 0;
   0 1 2 0 3 2 0 0 0;
   0 0 1 1 0 3 0 0 0;
   0 0 0 1 5 7 3 0 0;
   0 0 0 0 1 4 3 0 2;
   0 0 0 0 0 1 0 6 0 ;
   0 0 0 0 0 0 1 5 0;
   0 0 0 0 0 0 0 1 2;
   0 0 0 0 0 0 0 0 1];

%% plot the graph 
figure(1)
Grph= graph(M,'upper','OmitSelfLoops');
plot(Grph,'EdgeLabel',Grph.Edges.Weight)
title('the target graph of dijkstra algoritm')

%% the dijkstra algorithm
D=M+M';
D(find(D==0))=inf;
D=D-diag(diag(D));
for i=2:9
[mydistance mypath]=mydijkstra(D,1,i);
end

%% set the target graph of successive approximation method
%(mainly the adjacent matrix)
M=[1 -1 -3 3 0 0 0 0;
   7 1 0 0 5 0 0 0;
   0 -3 1 -5 0 2 0 0;
   0 0 0 1 0 0 8 0;
   0 -2 0 0 1 0 0 0;
   0 0 0 0 1 1 1 7;
   0 0 0 -3 0 0 1 0;
   0 0 0 0 -3 0 -5 1];

%% plot the graph 
figure(2)
Grph= digraph(M,'OmitSelfLoops');
plot(Grph,'EdgeLabel',Grph.Edges.Weight)
title('the target graph of the approximation algorithm')

%% the successive approxiamtion algoritm
S=M;
S(find(S==0))=inf;
S=S-diag(diag(S));
stepmat=mystepsapprox(S,1,8)