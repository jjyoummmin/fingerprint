function out = bifur_filter(thin,a,b)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%thin 에서 1 -> 흰색 0 -> 검은색

out = false;
A = [-1 1 1 ; -1 0 1 ; -1 0 1 ; -1 0 1 ;-1 -1 1; -1 1 1; -1 0 1 ;
    -1 0 1; -1 0 0 ; -1 -1 1; -1 0 1; -1 1 1; 0 0 1; -1 1 1; -1 1 1; -1 -1 1];
B = [0 -1 1; 1 -1 0 ; -1 1 -1; 0 -1 1; -1 1 0; 0 1 -1 ; 1 -1 1; -1 1 0 ;  0 -1 1;
    -1 1 1; 0 1 0; 1 -1 1; -1 1 0; -1 -1 1; 0 -1 0 ; -1 1 -1];

for i = 1:16
    
    for j=1:3
        if thin(a+A(i,j), b+B(i,j)) == 1
            break;            
        end
        if j==3
            out = true;
        end
    end
    

end

end