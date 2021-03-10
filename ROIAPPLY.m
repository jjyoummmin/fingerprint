function [out_endpoint,out_bifurpoint]=ROIAPPLY(endpoint, bifurpoint, roi_image)

    out_endpoint=[];
    out_bifurpoint=[];
    
    for i=1:size(endpoint,1)
       if roi_image(endpoint(i,1),endpoint(i,2)) == 0
           out_endpoint=[out_endpoint;[endpoint(i,1),endpoint(i,2),1,0]] ; 
       end
    end
    
    for i=1:size(bifurpoint,1)
       if roi_image(bifurpoint(i,1),bifurpoint(i,2)) == 0
           out_bifurpoint =[out_bifurpoint;[bifurpoint(i,1),bifurpoint(i,2),2,0]] ; 
       end
    end
end


