clear all;
clc;

syms s1 s2 1a 1b a0 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 real;
a = [a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11]';
b = [b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11]';

sa1 = 1-3*s1^2+2*s1^3;
sa2 = la*(s1-2*s1^2+s1^3);
sa3 = 3*s1^2-2*s1^3;
sa4 = la*(-s1^2+s1^3);

sb1 = 1-3*s2^2+2*s2^3;
sb2 = lb*(s2-2*s2^2+s2^3);
sb3 = 3*s2^2-2*s2^3;
sb4 = lb*(-s2^2+s2^3);

Sa = [sa1*eye(3) sa2*eye(3) sa3*eye(3) sa4*eye(3)];
Sb = [sb1*eye(3) sb2*eye(3) sb3*eye(3) sb4*eye(3)];

ra = Sa*a;
rb = Sb*b;

d2 = (ra-rb)'*(ra-rb);

gradient_d2 = [diff(d2,s1) diff(d2,s2)]';
hessian_d2 = [diff(diff(d2,s1),s1) diff(diff(d2,s1),s2); diff(diff(d2,s2),s1) diff(diff(d2,s2),s2)];