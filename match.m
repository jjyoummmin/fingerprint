function score = match(Minutiae,Minutiae2)
    
    %일단 B = [] 에다가 거리 / 각도 차이 모아서 비교해보자
    B=[];
    for i=1:size(Minutiae,1)
        for j=1:size(Minutiae2,1)
            if(Minutiae(i,3)~=Minutiae2(j,3))
                continue; %type이 같을경우에만 비교
            end
            
            rotation = abs(Minutiae(i,4)-Minutiae2(j,4));
            d_x = Minutiae(i,1) - Minutiae2(j,1);
            d_y = Minutiae(i,2) - Minutiae2(j,2);
            distance = sqrt(d_x^2 + d_y^2);
            B = [B;rotation,distance];
            
            
        end
    end
    count = 0;
    
    for i=1:size(B,1)
        if(B(i,1)<=0.3 && B(i,2)<=30)
            count = count+1;
        end
    end
    
    score = count^2/(size(Minutiae,1)*size(Minutiae2,1))*100;

end