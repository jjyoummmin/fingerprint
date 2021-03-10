function roi_image=MyROI(input)

input_roi = im2double(input);
level = graythresh(input_roi);
input_roi = im2bw(input_roi,level);
roi_image = im2double(ones(size(input_roi)));
roi_image2 = roi_image;
roi_image3 = roi_image;
roi_meter = 10;

for i=1:roi_meter:size(input_roi,1)-roi_meter
    for j=1:roi_meter:size(input_roi,2)-roi_meter
        
        temp=input_roi(i:i+roi_meter-1,j:j+roi_meter-1); % roi_meter x roi_meter image
        
        if sum(temp(:))==roi_meter*roi_meter % if temp is all white 
            roi_image(i:i+roi_meter-1,j:j+roi_meter-1)=1; % white
        else % if temp has a black 
            roi_image(i:i+roi_meter-1,j:j+roi_meter-1)=0; % black
        end
    end
end

% row scan
for i=1:roi_meter:size(roi_image,1)-roi_meter
    flag = 0;
    for j=1:roi_meter:size(roi_image,2)-roi_meter
        temp=roi_image(i:i+roi_meter-1,j:j+roi_meter-1);
        if sum(temp(:))==0 && flag==0 %black first left
            roi_image2(i:i+roi_meter-1,j:j+roi_meter-1) = 0.5;
            flag=1;
            continue;
        end
        
        if sum(temp(:))==roi_meter*roi_meter && flag==1 %black last right
            roi_image2(i:i+roi_meter-1,j-roi_meter:j-1) = 0.5;
            flag=0;
        end
    end
end

% column scan
for j=1:roi_meter:size(roi_image,2)-roi_meter
    flag = 0;
    for i=1:roi_meter:size(roi_image,1)-roi_meter
        temp=roi_image(i:i+roi_meter-1,j:j+roi_meter-1);
        if sum(temp(:))==0 && flag==0
            roi_image3(i:i+roi_meter-1,j:j+roi_meter-1) = 0.5;
            flag=1;
            continue;
        end
        
        if sum(temp(:))==roi_meter*roi_meter && flag==1
            roi_image3(i-roi_meter:i-1,j:j+roi_meter-1) = 0.5;
            flag=0;
        end
    end
end

for i=1:size(roi_image,1)
    for j=1:size(roi_image,2)
        if roi_image2(i,j) == 0.5 || roi_image3(i,j) == 0.5
            roi_image(i,j) = 0.5;
        end
    end
end
end