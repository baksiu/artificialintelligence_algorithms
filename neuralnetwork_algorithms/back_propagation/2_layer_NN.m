clc
clear all
close all

[x1,x2] = meshgrid(0:0.1:pi);
y = cos(x1.*x2).*cos(2.*x1); 
surf(x1,x2,y);


I = 1000;
x3 = rand(I,1).*pi;
x4 = rand(I,1).*pi;
y2 = cos(x3.*x4).*cos(2.*x3);

figure;
scatter3(x3,x4,y2,3);

K = 30;
Tmin = 0;
Tmax = 100000;
eta = 0.01;

W = rand(K,3).*(10^-6);
V = rand(K + 1,1).*(10^-6);

while(Tmin < Tmax)
    
        sk = x3 * W(:,2)' + x4 * W(:,3)';
        sk = bsxfun(@plus,sk,W(:,1)');
        osk = (1./(1 + exp(-sk)));
        y3 = sum(osk * V(2:size(V))) + V(1);
       
        blad = y3 - y2(:);
        
        if blad ~= 0
            
            osk_prim = osk .* (1-osk);
            newW = osk .* osk_prim;
            newW = (newW' * blad * eta) .* V(2:size(V));
            W(:,1) = W(:,1) - newW;
            W(:,2) = W(:,2) - x3 * newW;
            W(:,3) = W(:,3) - x4 * newW;
            V = V - eta * blad * [1;osk];
        end
        
   Tmin = Tmin + 1;
   if(mod(Tmin,100) == 0)
       Tmin
   end
end

V
W

figure;
[x5,x6]=meshgrid(0:0.1:pi);
x5s1 = size(x5,1);
x5s2 = size(x5,2);
y4 = zeros(x5s1,x5s1);
for i=1:x5s1
    for j=1:x5s2
        sk=W(:,1)+W(:,2)*x5(i,j)+W(:,3)*x6(i,j);
        o_sk=(1./(1+exp(-sk)));
        y4(i,j)=V(1)+ sum(V(2:size(V)).* o_sk);
    end
end
surf(x5,x6,y4);

