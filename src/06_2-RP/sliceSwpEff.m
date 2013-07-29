function SSE = sliceSwpEff(G,Prop,minP,maxP,ijk,frq)
%SLICESWPEFF Slice Sweep Efficiency
%   SliceSwpEff(G,Prop,minP,maxP,ijk,frq) calculates the volumetric
%   percentagege of property Prop between values minP and maxP on slices
%   prependicular to ijk axis of grid G. The returned values can be used in
%   historgram plots, or selecting the layers for visualization on grid.
%   frq is frequency of slices in ijk dimension to be used in calculations
%   e.g. frq = 1 means every slice and frq = 2 means every two slices in
%   ijk direction.
%   
%   See also mkRV, swpEffPlt.

%%
%
SSE = [];
switch ijk

    case 'i' 
        for i = 1:frq:G.cartDims(1,1)
            slice = boxIndFltr(G,i,i,1,G.cartDims(1,2),...
                1,G.cartDims(1,3));
            plume = valFltr(Prop,minP,maxP)';
            cells = fltrAnd(slice,plume);
            SSE(end+1) = sum(G.cells.volumes(cells))/...
                sum(G.cells.volumes(slice));
        end
        
    case 'j' 
        for j = 1:frq:G.cartDims(1,2)
            slice = boxIndFltr(G,1,G.cartDims(1,1),j,j,...
                1,G.cartDims(1,3));
            plume = valFltr(Prop,minP,maxP)';
            cells = fltrAnd(slice,plume);
            SSE(end+1) = sum(G.cells.volumes(cells))/...
                sum(G.cells.volumes(slice));
        end
        
    case 'k'
        for k = 1:frq:G.cartDims(1,3)
            slice = boxIndFltr(G,1,G.cartDims(1,2),...
                1,G.cartDims(1,2),k,k);
            plume = valFltr(Prop,minP,maxP)';
            cells = fltrAnd(slice,plume);
            SSE(end+1) = sum(G.cells.volumes(cells))/...
                sum(G.cells.volumes(slice));
        end
        
end   
end
