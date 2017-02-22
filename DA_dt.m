function [ dydt ] = DA_dt( t,y,da_trigger )
%DA_DT Summary of this function goes here
%   Detailed explanation goes here
dydt = zeros(1,2);
dydt(1) = 35*da_trigger - 2.15*y(1);
dydt(2) = 130*y(1) - 50*y(2);


end

