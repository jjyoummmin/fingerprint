A = ["1_1.tif" ; "1_2.tif"; "1_6.tif"; "1_7.tif" ; 
    "3_1.tif"; "3_2.tif"; "3_6.tif"; "3_7.tif";
    "5_1.tif"; "5_3.tif"; "5_5.tif"; "5_6.tif";
    "6_2.tif"; "6_3.tif"; "6_6.tif"; "6_7.tif";
    "10_1.tif"; "10_2.tif"; "10_5.tif"; "10_6.tif";
    "11_2.tif"; "11_4.tif"; "11_6.tif"; "11_7.tif";
    "19_1.tif"; "19_2.tif"; "19_3.tif"; "19_4.tif";
    "26_2.tif"; "26_3.tif"; "26_6.tif"; "26_7.tif";
    "33_1.tif"; "33_2.tif"; "33_3.tif"; "33_6.tif";
    "95_1.tif"; "95_2.tif"; "95_5.tif"; "95_6.tif";];
B = [];
for i = 38
    for j=1:size(A,1)
        
        a = A(i,1);
        b = A(j,1);
        input = imread(a); %query image
        input_size = size(input);
        
        input2 = imread(b); %template image
        input_size2 = size(input2);
        
       
        merge = gaborfilter(input);
        
        merge2 = gaborfilter(input2);
        
       
        level = graythresh(merge);
        bin = im2bw(merge,level);
        
        level2 = graythresh(merge2);
        bin2 = im2bw(merge2,level2);
        
     
        thin = ~bwmorph(~bin,'thin',Inf);
        
        thin2 = ~bwmorph(~bin2,'thin',Inf);
        
    
        [endpoint,bifurpoint] = minutiae_ext(thin);
        
        [endpoint2,bifurpoint2] = minutiae_ext(thin2);
      
        roi_image=MyROI(input);
        [out_endpoint,out_bifurpoint] = ROIAPPLY(endpoint,bifurpoint,roi_image);
        
        roi_image2=MyROI(input2);
        [out_endpoint2,out_bifurpoint2] = ROIAPPLY(endpoint2,bifurpoint2,roi_image2);
       
        [last_endpoint,last_bifurpoint] = my_direction_t(out_endpoint,out_bifurpoint,thin);
        Minutiae = [last_endpoint;last_bifurpoint];
        
        [last_endpoint2,last_bifurpoint2] = my_direction_t(out_endpoint2,out_bifurpoint2,thin2);
        Minutiae2 = [last_endpoint2;last_bifurpoint2];
        
       
       
        [Minutiae,Minutiae2] = alignment(Minutiae,Minutiae2);
        
       
        score = match(Minutiae,Minutiae2);

        if score>=80
            result = true;
        else
            result = false;
        end
        B = [B;a,b,score, result];
    end
end