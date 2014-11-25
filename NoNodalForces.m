function [ NodalForces ] =  NoNodalForces( ElementType,NumNodes,NumNodesPerElement,NodeNumbers )
%NoNodalForces: Generates nodal force section of PreSAMS ANCF
%   This function generates an array for printing to the PreSAMS file
%   making the assumption that there are no nodal forces.

    if ElementType == 2 ...
    || ElementType == 6 ...
    || ElementType == 7
        NodalForceZeros = zeros(NumNodes, 3*NumNodesPerElement);
        NodalForces = horzcat(NodeNumbers, NodalForceZeros);
    elseif ElementType == 5
        NodalForceZeros = zeros(NumNodes, 6*NumNodesPerElement);
        NodalForces = horzcat(NodeNumbers, NodalForceZeros);
    elseif ElementType == 8
        NodalForceZeros = zeros(NumNodes, 9);
        NodalForces = horzcat(NodeNumbers, NodalForceZeros);
    else
        display(' ')
        display('ERROR: Element Type not currently suported! error generated in NoNodalForces.m.')
        display(' ')
    end

end

