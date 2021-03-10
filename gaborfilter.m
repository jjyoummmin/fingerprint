function merge = gaborfilter(input)

    lambda = 8;    
    theta = 0;    
    psi = 0;  
    gamma = 0.5;    
    sigma = 4.4974;    
    N = 8;    

    img_in = im2double(input);     
    img_out = zeros(size(img_in,1), size(img_in,2), N);        
    for n=1:N       
        gb = Mygabo(sigma,theta,lambda,psi,gamma);              
        img_out(:,:,n) = conv2(img_in, gb,'same');          
        theta = theta + pi/8;          
    end
                 
    merge = sum(img_out, 3); %img_out(:,:,1)+img_out(:,:,2)+...+img_out(:,:,N)




    