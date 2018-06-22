% Demo input file for UAV processing.
% The user is responsible for correcting content for each new analysis

% 1.  Paths, names and time stamp info:
<<<<<<< HEAD
inputs.stationStr = 'Sandwich Town Neck Beach';  
inputs.dateVect = [2016 30 3 19+4 29 0];       % date/time of first frame
inputs.dt = 0.5/(24*3600);           % delta t (s) converted to datenums
inputs.frameFn = 'March_30';            % root of frame names
inputs.gcpFn = ('D:\Scodato_SSF_2018\Projects\SandwichBeachCam\extrinsic_calibration\gcp_surveys\2016-03-30_webcam_extrinsic_calibration\gcpSandwich2016_local.mat');   % File that contains the names and locations of all the possible GCPs 
inputs.instsFn = [pwd, filesep,'demoInstsFile'];            % instrument m-file location
inputs.pncx= ('D:\Scodato_SSF_2018\Projects\SandwichBeachCam\images\2016\cx') % Modify based on the year.
=======
inputs.stationStr = 'Sandwich';  
inputs.dateVect = [2015 10 1 19+4 29 0];       % date/time of first frame
inputs.dt = 0.5/(24*3600);           % delta t (s) converted to datenums
inputs.frameFn = 'sandwichClip_03/30/2016';            % root of frame names. The date represents the starting date of the images. 
inputs.gcpFn = [pwd, filesep, 'gcpSandwich03/30/16'];   % File that contains the names and locations of all the possible GCPs 
inputs.instsFn = [pwd, filesep,'demoInstsFile'];            % instrument m-file location. What should this file be? 
inputs.pncx= '/LocalDisk(D:)/Scordato_SSF_2018/Projects/SandwichBeachCam/meta'
>>>>>>> e4cc1c2139f9148cf24375ebcf10e3c0a8d84269

% 2.  Geometry solution Inputs:
% The six extrinsic variables, the camera location and viewing angles
% in the order [ xCam yCam zCam Azimuth Tilt Roll].
% Some may be known and some unknown.  Enter 1 in knownFlags for known
% variable.  For example, knownFlags = [1 1 0 0 0 1] means that camX and
% camY and roll are known so should not be solved for.  
% Enter values for all parameters below.  If the variable is known, the
% routine will use this data.  If not, this will be the seed for the
% nonlinear search.
inputs.knownFlags = [1 1 1 0 0 1];
<<<<<<< HEAD
inputs.xyCam = [0 0]; 
inputs.zCam = 9;             % based on last data run                
inputs.azTilt = [0 50] / 180*pi;          % first guess
=======
inputs.xyCam = [376523.828 4625139.430];
inputs.zCam = 9;             % based on last data run                
inputs.azTilt = [80 50] / 180*pi;          % first guess
>>>>>>> e4cc1c2139f9148cf24375ebcf10e3c0a8d84269
inputs.roll = 0 / 180*pi; 

% 3.  GCP info
% the length of gcpList and value of nRefs must be >= length(beta0)/2
inputs.gcpList = [1 2 3 4];      % use these gcps for init beta soln
<<<<<<< HEAD
inputs.nRefs = 3;                    % number of ref points for stabilization
inputs.zRefs = 1.5;                    % assumed z level of ref points
=======
inputs.nRefs = 4;                    % number of ref points for stabilization
inputs.zRefs = 0;                    % assumed z level of ref points
>>>>>>> e4cc1c2139f9148cf24375ebcf10e3c0a8d84269

% 4.  Processing parameters
inputs.doImageProducts = 1;                    % usually 1.
inputs.showFoundRefPoints = 0;                 % to display ref points as check
inputs.showInputImages = 1;                    % display each input image as it is processed
<<<<<<< HEAD
inputs.rectxy = [-600 1 600 0 1 800];     % rectification specs
inputs.rectz = 0;                              % rectification z-level

% residual calculations - NO USER INPUT HERE
inputs.pnIn = '\Scodato_SSF_2018\Projects\SandwichBeachCam\images';             % make the path to find init-file
=======
inputs.rectxy = [376473.828 0.5 376923.828 4624939.43 0.5 4625339.43];     % rectification specs
inputs.rectz = 0;                              % rectification z-level

% residual calculations - NO USER INPUT HERE
inputs = makeUAVPn(inputs);             % make the path to find init-file
>>>>>>> e4cc1c2139f9148cf24375ebcf10e3c0a8d84269
inputs.dn0 = datenum(inputs.dateVect);
bs = [inputs.xyCam inputs.zCam inputs.azTilt inputs.roll];  % fullvector
inputs.beta0 = bs(find(~inputs.knownFlags));
inputs.knowns = bs(find(inputs.knownFlags));



%
%   Copyright (C) 2017  Coastal Imaging Research Network
%                       and Oregon State University

%    This program is free software: you can redistribute it and/or  
%    modify it under the terms of the GNU General Public License as 
%    published by the Free Software Foundation, version 3 of the 
%    License.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see
%                                <http://www.gnu.org/licenses/>.

% CIRN: https://coastal-imaging-research-network.github.io/
% CIL:  http://cil-www.coas.oregonstate.edu
%
%key UAVProcessingToolbox
%

