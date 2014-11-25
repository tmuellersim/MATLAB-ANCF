function [dxArcLength]=intarclength(f,h)

row = 1;
[m,n] = size(h);
A = [];

fprime = diff(f);
arclength = sqrt(1+fprime^2);


for j = 16:-2:1         % For 8 leafs with 17 nodes for first leaf, reduced by 2 nodes for successive leaf
    
    for i=1:j
        s = integral(matlabFunction(arclength),h(row),h(row+1));
        A = [A;s];      % Cocatenate results
        row = row+1;
    end
    row = row+1;
end
    
dxArcLength = A;

%disp(A)

    