function [ dydt ] = EL_dt( t,y,el_trigger )
%EL_DT Summary of this function goes here
%   Detailed explanation goes here
dydt = zeros(1,4);
dydt(1) = 1000*el_trigger - 4.5*y(1);
dydt(2) = 6*y(1) - 4.5*y(2);
dydt(3) = 5.5*y(2) - 3.8*y(3);
dydt(4) = 7*y(3) - 3.8*y(4);


end

