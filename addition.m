function res = addition(thin,a,b)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
res = 0
for i=a-1:a+1
    for j=b-1:b+1
       res = res+thin(i,j); 
    end
end


end