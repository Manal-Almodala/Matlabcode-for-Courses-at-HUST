function [mydistance mypath]=mydijkstra(a,sb,db)
% input:a！adjacent matrix 
% sb！initial point, db！terminal point
% out put��mydistance！minmun distance, mypath！minmum path
n=size(a,1); visited(1:n)=0;
distance(1:n)=inf; % store the distance
distance(sb)=0; parent(1:n)=0;
for i=1:n-1
temp=distance;
id1=find(visited==1); %find the marked point
temp(id1)=inf; %put the distance to the marked point to infinity
[t, u] = min(temp); %find the point with minmum marked number
visited(u) = 1; %remember the marked point
id2=find(visited==0); %find the unmarked point
for v = id2
if a(u, v) + distance(u) < distance(v)
distance(v) = distance(u) + a(u, v); %change the number of the point
parent(v) = u;
end
end
end
mypath=[];
if parent(db)~= 0 %if there exists the path
t = db; mypath = [db];
while t~= sb
p=parent(t);
mypath=[p mypath];
t=p;
end
end
mydistance=distance(db);
return
end


