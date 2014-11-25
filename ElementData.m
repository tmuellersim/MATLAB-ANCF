function [ NumNodesPerElement , GradsPerElement ] = ElementData( ElementType )
%ElementData: Returns the number of nodes and gradients for a given
%ANCF element.
    %
    %Element Types
    % 1 = 2-D Beam(Euler)		NodesPerElement=2, GradsPerElement=4
    % 2 = 2-D Beam(Shear)		NodesPerElement=2, GradsPerElement=8
    % 3 = 2-D Rectangular		NodesPerElement=4, GradsPerElement=16
    % 4 = 2-D Triangular		NodesPerElement=3, GradsPerElement=12
    % 5 = 3-D Beam          	NodesPerElement=2, GradsPerElement=18
    % 6 = Plate 1       		NodesPerElement=4, GradsPerElement=36
    % 7 = Plate 2       		NodesPerElement=4, GradsPerElement=36
    % 8 = Thin Plate        	NodesPerElement=4, GradsPerElement=24
    % 9 = Cable Element     	NodesPerElement=2, GradsPerElement=6
    % 10 = Solid Element		NodesPerElement=8, GradsPerElement=72
    % 11 = ANCF BSpline Plate	NodesPerElement=4, GradsPerElement=24
    % 12 = Higher Order Beam	NodesPerElement=2, GradsPerElement=18

%% Nodes per element-------------------------------------------------------
    if ElementType == 1 ...
    || ElementType == 2 ...
    || ElementType == 5 ...
    || ElementType == 9 ...
    || ElementType == 12
        NumNodesPerElement = 2;

    elseif ElementType == 3 ...
        || ElementType == 6 ...
        || ElementType == 7 ...
        || ElementType == 8 ...
        || ElementType == 11
        NumNodesPerElement = 4;

    elseif ElementType == 4
        NumNodesPerElement = 3;

    elseif ElementType == 10
        NumNodesPerElement = 8;

    else
        fprintf(fid, 'ElementType selected not within range. \r\n error generated in ElementData.m');
    end

    
%% Gradients per element---------------------------------------------------  
    if ElementType == 1
        GradsPerElement = 4;

    elseif ElementType == 2
        GradsPerElement = 8;

    elseif ElementType == 3
        GradsPerElement = 16;

    elseif ElementType == 4 ...
        || ElementType == 12
        GradsPerElement = 12;
        
    elseif ElementType == 5
        GradsPerElement = 18;
        
    elseif ElementType == 6 ...
        || ElementType == 7
        GradsPerElement = 36;
        
    elseif ElementType == 8 ...
        || ElementType == 11
        GradsPerElement = 24;
        
    elseif ElementType == 9
        GradsPerElement = 6;
        
    elseif ElementType == 10
        GradsPerElement = 72;

    end

end

