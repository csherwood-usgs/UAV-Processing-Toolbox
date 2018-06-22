% Transform UTM to a local "sandwich" coordinate system
%
% Input:
%   E, N = UTM coordinates
%
% Output:
%   X, Y = local coordinates
%
% Usage: [X,Y]=coordSys_sandkey(E,N)
%
% Written By:
%   Jenna Brown, 2018, USGS
%--------------------------------------------------------------------------
function [X,Y]=coordSys_sandkey(E,N)

%***shoreline determined from GCPs measured 4/19/18
%***    c1 - shoreline goes along GCPs 15 & 22 (GPS 17 & 25)
%theta_c1 = atan((3.091777539200000e+06 - 3.091669784100000e+06)./(3.189787035000000e+05 - 3.189405940000000e+05)).*180./pi; 
%***    c2 - shoreline goes along GCPs 4 & 12 (GPS 6 & 14)
%theta_c2 = atan((3.092054440000000e+06 - 3.091856380600000e+06)./(3.190867030000000e+05 - 3.190097376000000e+05)).*180./pi; 
theta = -(69.643476017853260 + 90);% = mean([theta_c1,theta_c2]);

%***origin determined as mean (RTK) camera position measured 4/19/18
E0 = 3.190323876500000e+05; %origin, E
N0 = 3.091813964450000e+06; %origin, N

[X,Y] = xyRotate(E,N,theta,E0,N0);