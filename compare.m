function same = compare(avg_angle,avg_x, avg_y, delta_angle, delta_x, delta_y)
    same = false;
    a = abs(avg_angle - delta_angle);
    b = abs(avg_x - delta_x);
    c = abs(avg_y - delta_y);
    
    if(a<=0.1 && b<=45 && c<=45)
        same = true;
    end
end