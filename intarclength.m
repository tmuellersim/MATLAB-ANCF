function s=intarclength(f,h)

row = 1;
[m,n] = size(h);
A = [];

fprime = diff(f);
arclength = sqrt(1+fprime^2)

for i=1:m-1
    s = integral(matlabFunction(arclength),h(row),h(row+1));
    A = [A;s];
    row = row+1;
end

disp(A)

    