%   f = function of z  >Example -  0.0073*x^2
%   data = coordinates of each node  > [x z]


%%Input -------------------------------------------------------------------

function [PositionVectorGradient] = leafgrads(f,data);

% tic             %   Start clock

[m,n] = size(data);     %   Pull size of data matrix
fprime = diff(f);       %   Differentiate function
row = 1;                %   Start row at 1, which will work through

A = [];                         %   Initialize empty matrix A, which will hold our results

for i=1:m
    
    theta = atan(feval(inline(fprime),data(row,1)));            %   Find theta using the arctan of the derivative of f, evaulated at x_i
    atrans = [cos(theta) -sin(theta); sin(theta) cos(theta)];   %   Calculate tranformation matrix
    
    rx = atrans*[1;0];                              %   Generate R_j,x
    rz = [0 -1;1 0]*rx;                             %   Generate R_j,z, assuming orthonormal to R_j,x
    
    B = [rx(1) 0 rx(2) 0 1 0 rz(1) 0 rz(2)];    %   Build nodal coordinates at node
    A = [A;B];                                      %   Cocatenate nodal coordinates to previous
    
    row = row+1;       %   Advance to next node
    
end

row = 1;
D = [];

for i=16:-2:1
    
    for j=1:i
        
        C = [A(row,:) A((row+1),:)];
        D = [D;C];
        row = row+1;
        
    end
    
    row = row+1;
    
end
    
PositionVectorGradient = D;
    
    

% toc         %Display clock

%  disp(' Node R_j,xx R_j,xy R_j,xz R_j,yx R_j,yy R_j,yz R_j,zx R_j,zy R_j,zz ')
%  disp(' ')
%  disp(A)

    


