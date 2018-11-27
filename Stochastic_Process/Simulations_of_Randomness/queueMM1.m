function [rou Ls Lq Ws Wq]=queue_M_M_1(n,lambda,mu)
if nargin==0
    n = 500 ;
    lambda = 0.8 ;
    mu = 1 ;
end
arrive_time(1) = 0 ;
service_time = 0 ;
system_size = 0 ;
queue_size = 0 ;
for i = 1 : n
    time_arrive = -log(rand)/lambda ;
    time_service = -log(rand)/mu ;
    service_time = service_time+time_service ;
    if i==1
        depart_time(i) = arrive_time(i)+time_service ;
    else
        arrive_time(i) = arrive_time(i-1)+time_arrive ;
        if arrive_time(i)>depart_time(i-1)
            depart_time(i) = arrive_time(i)+time_service ;
        else
            depart_time(i) = depart_time(i-1)+time_service ;
        end
    end
end
rou = service_time/depart_time(n)
Ws = sum(depart_time-arrive_time)/n 
Wq = (sum(depart_time-arrive_time)-service_time)/n   
for i = 1 : n-1
    for k = i+1 : n-2
        if depart_time(i)>arrive_time(k)
            if depart_time(i)<arrive_time(k+1)
                system_size = system_size+k-i ; 
                queue_size = queue_size+k-i-1 ;
            end
        end
    end
    if depart_time(i)>arrive_time(n)
        system_size = system_size+n-i ; 
        queue_size = queue_size+n-i-1 ;
    end
end