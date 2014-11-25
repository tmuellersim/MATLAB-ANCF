function [Connectivity] = ElementConnectivity();

row = 1;
E = [];
F = [];

for j = 16:-2:1         % For 8 leafs with 17 nodes for first leaf, reduced by 2 nodes for successive leaf
    
    for i=1:j
        E = [(row) (row+1)];
        F = [F;E];
        row = row+1;
    end
    
    row = row+1;
end

F
Connectivity = F;