function [endpoint,bifurpoint] = minutiae_ext(thin);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

endpoint = [];
bifurpoint = [];
% endpoint = [endpoint ; new ]; 추가하는 방법
for i=2:373
    for j=2:387
        
        
        if thin(i,j)==0   % 3*3의 중간부분이 검은색 이었을 때
            if addition(thin,i,j)==7    % end point 인지 확인 
                endpoint = [endpoint ; [i,j] ];  %end point가 맞다면 추가
            elseif  (addition(thin,i,j)==5 )   && (bifur_filter(thin,i,j)==1) %bifurcation point 인지 확인
                %합이 5이고 bifur_filter 함수를 돌린 결과가 true(1)로 나오는지 확인
                bifurpoint = [bifurpoint; [i,j]];  %bifurcation point가 맞다면 추가
                
            end
        end
    
    
    
    
    end
end

end