function [Minutiae,Minutiae2] = alignment(Minutiae,Minutiae2)
    A =[];
    
    % 1. A 구하기.
    for i = 1:size(Minutiae,1)
        for j=1:size(Minutiae2,1)
            if(Minutiae(i,3)~=Minutiae2(j,3)) %type이 같을 경우에만 비교하기
                continue
            end
           
            delta_angle = Minutiae(i,4) - Minutiae2(j,4);
            delta_x = Minutiae(i,1) - Minutiae2(j,1)*cos(delta_angle) - Minutiae2(j,2)*sin(delta_angle);
            delta_y = Minutiae(i,2) + Minutiae2(j,1)*sin(delta_angle) - Minutiae2(j,2)*cos(delta_angle);
            
            %아직 A행렬에 아무것도 없을 경우는 바로 추가해준다.
            if(size(A,1)==0)
                
                A = [A; delta_angle, delta_x, delta_y,1,delta_angle,delta_x,delta_y];
                % 뒤에 원소 3개는 sum_angle / sum_x / sum_y 항목
            
            %A행렬에 값이 있는 경우 이미 저장된 조합들과 새로 계산된 조합이 같은지 다른지 확인한다.    
            else
                
                for ind = 1:size(A,1)
                    %평균과 새로 계산한 것을 비교
                    avg_angle = A(ind,5)/A(ind,4);
                    avg_x = A(ind,6)/A(ind,4);
                    avg_y = A(ind,7)/A(ind,4);
                    if(compare(avg_angle,avg_x,avg_y,delta_angle,delta_x,delta_y))
                        % 이미 있는 set일 경우
                        A(ind,4) = A(ind,4)+1;
                        A(ind,5) = A(ind,5)+delta_angle;
                        A(ind,6) = A(ind,6)+delta_x;
                        A(ind,7) = A(ind,7)+delta_y;
                        break;
                    end
                    if (ind == size(A,1))
                        % 기존 A에 없는 set일 경우 새로 추가 (4번째 항목은 count)
                        
                        A = [A; delta_angle, delta_x, delta_y,1,delta_angle,delta_x,delta_y];
                    end
                    
                    
                end
                
                
            end
            
            
            
            
            
            
            
            
            
            
        end
    end
    
    %2. A에서 제일 count 높은 것 구하기
    max = 0;
    ind = 1;
    for i = 1: size(A,1)
        if A(i,4) > max
            max = A(i,4)
            ind = i
        end
    end
    
    result = [A(ind,5)/A(ind,4), A(ind,6)/A(ind,4), A(ind,7)/A(ind,4)];
    %총합/count => 평균
    delta_angle = result(1);
    delta_x = result(2);
    delta_y = result(3);
    
    %3. Minutiae2 변환하기
    
    for i=1: size(Minutiae2,1)
        Minutiae2(i,4) = Minutiae2(i,4)+delta_angle;
        Minutiae2(i,1) = Minutiae2(i,1)*cos(delta_angle) + Minutiae2(i,2)*sin(delta_angle) +delta_x;
        Minutiae2(i,2) = - Minutiae2(i,1)*sin(delta_angle) + Minutiae2(i,2)*cos(delta_angle) +delta_y;
    end
    
    
end