function [ homoVec,htmVec ] = uniVec(hetroVec,timeVec)
%UNIVEC Unified Vector
%   

%%
nel = length(hetroVec);
minInd = 1;
minVec = timeVec{1};
for i=1:nel,
    if length(timeVec{i})<=length(minVec),
        minInd = i;
        minVec = timeVec{i};
    end
end
%
tel = length(minVec);
%
newInd=cell(nel,1);
htmVec=cell(nel,1);
%
for i=1:nel,
    for j=1:tel,
        tm = find(timeVec{i}==minVec(j));
        if ~isempty(tm),
        		newInd{i}(end+1) = tm;
        		
        end
    end     
    htmVec{i}=timeVec{i}(newInd{i});   
end

%
homoVec=cell(nel,1);
for i=1:nel,
	 lel = length(newInd{i});
	 if ~isempty(lel),
		 for j=1:lel,
		     if ~isempty(newInd{i}(j)),
		         homoVec{i}(end+1)=hetroVec{i}(newInd{i}(j));
		     end
		 end
	 end
end

end
