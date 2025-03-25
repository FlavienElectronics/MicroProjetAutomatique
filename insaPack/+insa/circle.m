% <strong>INSA DYNAMICAL SYSTEMS SUITE</strong>
% Circle plot
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : April 2021 (creation)
%
% Description
% Plot a circle
%
% Syntax
%  insa.circle(center,radius,NOP)
%  insa.circle(center,radius,NOP,style)
% 
% Input arguments
%  - center : [x,y] coordinate of the center
%  - radius : radius (>0)
%  - NOP    : Number of points (chose > 100)
% 
% Optional arguments
%  - style  : color
% 

function H = circle(center,radius,NOP,style)

    if (nargin <3)
        error('Please see help for INPUT DATA.');
    elseif (nargin==3)
        style = 'b-';
    end
    THETA = linspace(0,2*pi,NOP);
    RHO   = ones(1,NOP)*radius;
    [X,Y] = pol2cart(THETA,RHO);
    X = real(X + center(1));
    Y = real(Y + center(2));
    H = plot(X,Y,style);

end