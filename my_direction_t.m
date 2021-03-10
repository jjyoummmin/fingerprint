function [last_endpoint,last_bifurpoint] = my_direction_t(out_endpoint,out_bifurpoint,thin)
    Table = [3*pi/4 2*pi/3 7*pi/12 pi/2 5*pi/12 pi/3 pi/4  %7*7
        5*pi/6 0 0 0 0 0 pi/6
        11*pi/12 0 0 0 0 0 pi/12
        pi 0 0 0 0 0 0
        -11*pi/12 0 0 0 0 0 -pi/12
        -5*pi/6 0 0 0 0 0 -pi/6
        -3*pi/4 -2*pi/3 -7*pi/12 -pi/2 -5*pi/12 -pi/3 -pi/4];
    
    
    Table2 = [3*pi/4 pi/2 pi/4; pi 0 0; -3*pi/4 -pi/2 -pi/4]; %3*3 혹시 필요할까봐 만들었는데 사용하지 않았다
    
    Table3 = [3*pi/4 2*pi/3 pi/2 pi/3 pi/4;   %5*5 혹시 필요할까봐 만들었는데 사용하지 않았다
        5*pi/6 0 0 0 pi/6;
        pi 0 0 0 0;
        -5*pi/6 0 0 0 -pi/6;
        -3*pi/4 -2*pi/3 -pi/2 -pi/3 -pi/4];
    
    last_endpoint = [];
    last_bifurpoint = [];
    CentroidTermX = out_endpoint(:,1);  %endpoint(:,1) => endpoint 중간점 x 좌표 모음
    CentroidTermY = out_endpoint(:, 2); %endpoint(:,2) => endpoint 중간점 y좌표 모음
    CentroidBifX = out_bifurpoint(:,1);
    CentroidBifY = out_bifurpoint(:,2);
    
    OrientationTerm = zeros(length(CentroidTermX), 1); 
    OrientationBif = zeros(length(CentroidBifX), 1);
    
   
    
    for ind=1:length(CentroidTermX)
        Klocal = thin(CentroidTermX(ind)-3:CentroidTermX(ind)+3, CentroidTermY(ind)-3:CentroidTermY(ind)+3); %7*7 matrix
        Klocal(2:6 , 2:6 )= 1; %가운데 빼고 안쪽 흰색으로 바꾸기 // end는 알아서 정의?? end-1 => 6?
        [i,j] = find(Klocal==0);  %find 에 해당하는 것 다 [(i1,j1) ; (i2, j2) ; ......] 이런식으로 저장?
                                  %배열에서 다음 조건을 만족하는 항을 다 찾음. => 결과는 그 항의인덱스
                             
                             
        if length(i) ~= 1    %7*7에서 중간 흰색으로 바꾼후 테두리 부분에 검은색 한개가 아닌경우 반복문 처음으로
                             % end point 에 해당되는 경우에만 밑으로 내려간다.
            continue
        end
        OrientationTerm(ind,1)=Table(i,j) ; %방향 지정해주기
        last_endpoint = [last_endpoint; [CentroidTermX(ind), CentroidTermY(ind), 1, Table(i,j)]];
        
        
    end
    
    
    
   
    
    for ind=1:length(CentroidBifX)
        Klocal = thin(CentroidBifX(ind)-3:CentroidBifX(ind)+3, CentroidBifY(ind)-3:CentroidBifY(ind)+3); %7*7 matrix => 5*5
        Klocal(2:6 , 2:6 )= 1; %가운데 빼고 안쪽 흰색으로 바꾸기 // end는 알아서 정의?? end-1 => 6?
        [i,j] = find(Klocal==0);  %여기서 얻어지는 i,j는 7*7행렬 인덱스
        
        
        
        if length(i)~= 3    %테두리에 검은색 3개 아니면 반복문 처음으로 돌아가기
            CentroidBifY(ind)=NaN;
            CentroidBifY(ind)=NaN;
            continue;
        end
        
        
        
        a = Table(i(1), j(1));  %각도
        b = Table(i(2), j(2));
        c = Table(i(3), j(3));
        
        C = abs(a-b); %각도 차
        if C>=pi  %각도 차가 pi 보다 클 경우 처리해주기
            C = 2*pi - C;
        end
        B = abs(a-c);
        if B>= pi
            B = 2*pi - B; 
        end
        A = abs(b-c);
        if A>= pi
            A = 2*pi - A;
        end
        
        angle = 0;
        
        if A<=B<=C || A<=C<=B    %가장 작은 각도차를 해당 bifurcation의 angle 값으로 정한다.
            angle = a;
        elseif B<=C<=A || B<=A<=C
            angle = b;
        else C<=A<=B || C<=B<=A
            angle = c;
        end
        
         
        last_bifurpoint = [last_bifurpoint; [CentroidBifX(ind), CentroidBifY(ind), 2, angle]];
        OrientationBif(ind,1) = angle;
    end
    
    
    
    %dxTerm=cos(OrientationTerm)*5;  %결과 배열?
    %dyTerm=sin(OrientationTerm)*5;
    
    
    %dxBif=cos(OrientationBif)*5;  %결과 배열?
    %dyBif=sin(OrientationBif)*5;
    
    %figure;imshow(thin);
    %hold on
    
    %plot(CentroidTermY, CentroidTermX, 'ro', 'linewidth', 2);
    %plot([CentroidTermY CentroidTermY+dxTerm]', ...
    %    [CentroidTermX CentroidTermX-dyTerm]', 'r', 'linewidth', 2);

    
    
    %plot(CentroidBifY, CentroidBifX, 'go', 'linewidth', 2);
    %plot([CentroidBifY CentroidBifY+dxBif]', ...
     %   [CentroidBifX CentroidBifX-dyBif]', 'g', 'linewidth', 2);
 
    

    
    
end