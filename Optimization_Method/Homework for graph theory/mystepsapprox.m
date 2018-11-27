function stepmat = mystepsapprox( ad, spoint, tpoint )
% input:ad¡ªadjacent matrix
% spoint¡ªinitial point, tpoint¡ªterminal point
% output£ºstepmat- the matrix in the procedure to find the minimal distance
gdegree=length(ad(1,:));
stepmat=ad(spoint,:)';
step=1;
while 1
    tempvector=inf*ones(gdegree,1);
    canreach=find(stepmat(:,step)<inf);
    %templength=length(canreach);
    for i=1:gdegree
        canback=find(ad(:,i)<inf);
        findex=intersect(canreach,canback);
        if ~isempty(findex)
            flagvector=stepmat(findex,step)+ad(findex,i);
            tempvector(i)=min(flagvector);
        else
            tempvector(i)=inf;
        end
    end
    stepmat=[stepmat tempvector];
    if norm(stepmat(:,step)-tempvector)==0
        break
    end
    step=step+1;
end

