% DEMO SIGNAL GENERATION 
% Author: C. Poussot-Vassal [MOR Digital Systems / Onera]
% Date  : March 2022 (creation)
% 
% Description
% Demonstration script for identification signals construction. This small 
% script illustrates how one can generate different excitation signals in 
% view of model identification. This script is a rather simple one and 
% modifications may be applied by users. Still, it provides a first 
% shot for it, but does not prevent for additional reading and thinking.
% Among others, one can consider, the analysis of the frequency spectra,
% the length, the applicability... of each input/output couples
% 
% Note
% The script uses the "+insa" matlab package.
% 
% INSA demonstrators available in 2025
%  * billes sur rail
%  * moteurs continus
%  * balle de ping-pong
%  * soufflerie 
%  * niveau d'eau 
%  * ailettes 
% 

clear all, close all, clc;
% >> Graphic settings
insa.initGraphics

% >> PRBS CASE (constructs u1,y1,y1n)
N       = 6;
Tc      = 2;
Plot    = true;
[u1,t1,u2,t2] = insa.prbs(N,Tc,Plot);
size(u1)

