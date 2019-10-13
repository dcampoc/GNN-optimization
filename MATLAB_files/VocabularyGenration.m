% % (OPTIMIZATION) AT DIFFERENT VALUES OF K.  FINDING
% % THE MINIMUM POINT WHICH SHOULD BE THE OPTIMAL POINT
clc
clear
close all
numData = 1;
curDir = pwd;

plotMap = true;
%% List of data && directories

dataDir = ['C:\Users\hafsa\OneDrive\Desktop\avss19\ICIP19\rawData'];                                                % Directory where raw data stored


%% Load data
cd(dataDir)
load('Data.mat')                                                     % loaded the file which contains all data and normalised data
Data = cell2mat(struct2cell(fullDataRotMat)');

load('dataAvoid1.mat')

cd(curDir)

list = {'XYRobot4D','XY2D','PM','SV-PM'}; %,'WaWb'
[index,tf] = listdlg('PromptString','Select a file from below:',...
    'SelectionMode','single',...
    'ListString',list);
%%

X = Data(:,9);
Y =Data(:,10);
XY = [X Y];

divX = Data(:,19);
divY = Data(:,20);
divXY = [divX divY];

inputvectorXY = [XY divXY ];

% OBSTACLE AVOIDANCE IN CASE OF ROBOT

XO = dataAvoid.Apose;
YO = dataAvoid.Bpose;
XYO = [XO YO];

divXO = dataAvoid.divApose;
divYO = dataAvoid.divBpose;
divXYO = [divXO divYO];

if index == 1  %  XY4D Robot data
    InputData = inputvectorXY;    
    title = 'X and Y';
    strSave = 'XY';
    
elseif index ==2    % XY 2D robot data
    InputData = XY ;
    CompData = divXY;
    title = 'X and Y';
    strSave = 'XY';
    
elseif index ==3   % perimeter monitering from spain data
    load('PMDatafile.mat')
    InputData =[structSyncData.Filtered.xPos, structSyncData.Filtered.yPos,...
       structSyncData.Filtered.divxPos, structSyncData.Filtered.divyPos];
    title = 'PM Pose';
    strSave = 'PM Pose';
        
elseif index ==4    % steering and velocity data for Perimeter monitering from spain data
  load('PMDatafile.mat')
      InputData =[structSyncData.Filtered.S, structSyncData.Filtered.V,...
       structSyncData.Filtered.divS, structSyncData.Filtered.divV];
    title = 'SVPM';
    strSave = 'SVPM';
  
end


%% GNG parameters
params.N = 100;                                                             %    Number of nodes
params.MaxIt = 10;                                                          %    Iteration (repetition of input data)
params.L_growing = 1000;                                                    %    Growing rate
params.epsilon_b = 0.05;                                                    %    Movement of winner node
params.epsilon_n = 0.0006;                                                  %    Movement of all other nodes except winner
params.alpha = 0.5;                                                         %    Decaying global error and utility
params.delta = 0.9995;                                                      %    Decaying local error and utility
params.T = 100;                                                             %    It could be a function of params.L_growing, e.g., params.LDecay = 2*params.L_growing
params.L_decay = 1000;                                                      %    Decay rate sould be faster than the growing then it will remove extra nodes
params.alpha_utility = 0.0005;                                              %    It could be a function of params.delta, e.g., params.alpha_utility = 0.9*params.delta
params.seedvector = 1;                                                      %    Pseudo random shuffling of input data
params.k = 0.15;         % k_opt = 0.15 for control data                    %    Utility threshold
% % % %                    k_opt = 0.18,0.5 for odometry data

%% GNG processing

 net = GrowingNeuralGasNetwork(InputData, params, true);

 
 
%%  Transition matrix
transitionMatChanges = zeros(net.N,net.N);
transitionMat = zeros(net.N,net.N);
timesSpent = [];
currLength = size(InputData,1) ;
nodesInTime = net.dataColorNode;
ind = find(diff(nodesInTime) ~= 0);

%% transition Matrix
for k = 1:currLength-1
    transitionMat(nodesInTime(k,1),nodesInTime(k+1,1)) =...
        transitionMat(nodesInTime(k,1),nodesInTime(k+1,1)) + 1;
end
%% time Stamp Matrix

codeInd = [0; ind];
tspentTran = diff(codeInd);

for k = 1:size(tspentTran,1)
    if size(unique([timesSpent;tspentTran(k,1)]),1) ~= size(unique(timesSpent),1)
        timeMats{1,tspentTran(k)} = zeros(net.N,net.N);
        timesSpent = [timesSpent; tspentTran(k)];
    end
    timeMats{1,tspentTran(k)}(nodesInTime(ind(k),1),nodesInTime(ind(k)+1,1)) =...
        timeMats{1,tspentTran(k)}(nodesInTime(ind(k),1),nodesInTime(ind(k)+1,1)) + 1;
end

%%

ind2 = find(diff(nodesInTime) == 0);
tspentSame = 1;
for k = 1:size(ind2,1)
    if k > 1
        if ind2(k) == ind2(k-1) + 1
            tspentSame = tspentSame + 1;
        else
            tspentSame = 1;
        end
    end
    
    if size(unique([timesSpent;tspentSame]),1) ~= size(unique(timesSpent),1)
        timeMats{1,tspentSame} = zeros(net.N,net.N);
        timesSpent = [timesSpent; tspentSame];
    end
    
    timeMats{1,tspentSame}(nodesInTime(ind2(k),1),nodesInTime(ind2(k)+1,1)) =...
        timeMats{1,tspentSame}(nodesInTime(ind2(k),1),nodesInTime(ind2(k)+1,1)) + 1;
end

%% Change in transition Matrix

for k = 1:size(ind,1)
    transitionMatChanges(nodesInTime(ind(k),1),nodesInTime(ind(k)+1,1)) =...
        transitionMatChanges(nodesInTime(ind(k),1),nodesInTime(ind(k)+1,1)) + 1;
end

transitionMatChanges = transitionMatChanges./repmat(sum(transitionMatChanges,2) + (sum(transitionMatChanges,2)==0),1,net.N);
transitionMat = transitionMat./repmat(sum(transitionMat,2) + (sum(transitionMat,2)==0),1,net.N);

transitionInfo.transitionMat = transitionMat;
transitionInfo.TimeMats = timeMats;
transitionInfo.transitionMatChanges = transitionMatChanges;                 %   We do not use this in MPJF

trainingTracks.tracksDiscrete = nodesInTime;

save('VocabulariesFinalH.mat','net','transitionInfo','trainingTracks')
