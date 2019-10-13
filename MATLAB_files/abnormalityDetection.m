%% Fourth  Algorithm: (Abnormality detection)
close all
clear
clc
curDir = pwd;
set(0,'defaultfigurecolor',[1 1 1])
load('VocabulariesFinal.mat')                                              %   Load train model

datatTrainigBool = false;                                                  % True for training data and false for testing
xyTrain = true;                                                            % True for odometry and false for control(steering and velocity) use just for training purposes
Testing = 2;                                                               % cases 1 = uturn , cases 2 = obstacle avoidance  and case 3 = steering angle and velocity
%% Data for testing
if datatTrainigBool == true
    load('PMDatafile.mat')
else
    
    if Testing == 1
        load('UturnDatafile.mat') %% U Turn position 
       
    elseif Testing == 2
        load('OADatafile.mat')%% Obstacle Avoidance position 
       
    elseif Testing == 3
        load('ESDatafile.mat')%% Emergency Stop position 
        
    elseif Testing == 4
        load('ESDatafile.mat') %% Emerggency Stop Control Data
       
    elseif Testing == 5
        load('UturnDatafile.mat')%% U Turn Control Data
        
    elseif Testing == 6
        load('OADatafile.mat')%% Obstacle Avoidance Control Data
         
    end
end

inputData = structSyncData;
%% Mean and Covariance (training data)

averageState = net.nodesMean(:,[1,2]);                                        %   Mean neurons of position data
averageDiv = net.nodesMean(:,[3,4]);

%   Covariance of position data
for i =1:net.N
    temp1 = net.nodesCov{i};
    split_temp12 = temp1(:,[1,2]);
    split_temp34 = temp1(:,[3,4]);
    covarianceState{i} = split_temp12;                                         %   Covariance of position data
    covarianceDiv{i} = split_temp34;                                           %   Covariance of velocity data
end

radiusState = net.nodesRadAccept;                                               %   Acceptance neuron radius of position data

transMatsTime = transitionInfo.TimeMats;                                        %   Transition time of Som of couples (labels)
transitionMat = transitionInfo.transitionMat;                                   %   Transition time of Som of couples (labels)

cd(curDir)
%% plotting


if xyTrain == true
    figure(99);
    scatter(net.data(1:850,1),net.data(1:850,2),'.','k') % training data
    hold on
    scatter(structSyncData.Filtered.xPos(1:850,:),structSyncData.Filtered.yPos(1:850,:),'.','r')
    axis([-30 25 -5 40])
else
    disp('Control Data')
end
%% MJPF application
estimationAbn = MJPF(averageDiv, covarianceDiv,...
    averageState, covarianceState, radiusState,...
    transitionMat,transMatsTime,curDir, inputData,xyTrain);                   % true for xydata and false for SV data


figure;
plot(estimationAbn.AbnSignal)

if datatTrainigBool == true
    
    if xyTrain == true
        namefile = 'TrainAbnSig.mat';
        save(namefile,'estimationAbn');
        
    else
        namefile = 'SVTrainAbnSig.mat';
        save(namefile,'estimationAbn');
    end
else
    if Testing == 1
        namefile = 'PosAbnSig.mat';
        save(namefile,'estimationAbn');
        
    elseif Testing == 2
        namefile = 'OAAbnSig.mat';
        save(namefile,'estimationAbn');
    elseif Testing == 3
        namefile = 'ESPMAbnSig.mat';
        save(namefile,'estimationAbn');
    elseif Testing == 4
        namefile = 'ESSVAbnSig.mat';
        save(namefile,'estimationAbn');
        
    elseif Testing == 5
        namefile = 'SVAbnSig.mat';
        save(namefile,'estimationAbn');
    elseif Testing == 6
        namefile = 'SVOAAbnSig.mat';
        save(namefile,'estimationAbn');
    end
end




