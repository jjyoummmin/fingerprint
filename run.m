%지문 이미지 input으로 받기

input = imread('95_5.tif'); %query image
input_size = size(input);

input2 = imread('33_3.tif'); %template image
input_size2 = size(input2);

%gabor-filter & merge
merge = gaborfilter(input);

merge2 = gaborfilter(input2);

%binarization
level = graythresh(merge);
bin = im2bw(merge,level); 

level2 = graythresh(merge2);
bin2 = im2bw(merge2,level2);

%thining
thin = ~bwmorph(~bin,'thin',Inf);

thin2 = ~bwmorph(~bin2,'thin',Inf);

%minutiae 추출
[endpoint,bifurpoint] = minutiae_ext(thin);

[endpoint2,bifurpoint2] = minutiae_ext(thin2);
%ROI(바깥 부분 minutiae제거하기)
roi_image=MyROI(input);
[out_endpoint,out_bifurpoint] = ROIAPPLY(endpoint,bifurpoint,roi_image);

roi_image2=MyROI(input2);
[out_endpoint2,out_bifurpoint2] = ROIAPPLY(endpoint2,bifurpoint2,roi_image2);

%direction 계산해서 minutiae정보에 추가해주기
[last_endpoint,last_bifurpoint] = my_direction_t(out_endpoint,out_bifurpoint,thin);
Minutiae = [last_endpoint;last_bifurpoint];  

[last_endpoint2,last_bifurpoint2] = my_direction_t(out_endpoint2,out_bifurpoint2,thin2);
Minutiae2 = [last_endpoint2;last_bifurpoint2];

%이 위까지 해서 Minutiae 얻어냄! 이제 match 함수 만들 것.
%matching
%score = match(Minutiae,Minutiae2);

% alignment
[Minutiae,Minutiae2] = alignment(Minutiae,Minutiae2)

%score 계산
score = match(Minutiae,Minutiae2)

if(score>=80)
    disp("같은 사람입니다.");
else
    disp("다른 사람입니다.");
end


