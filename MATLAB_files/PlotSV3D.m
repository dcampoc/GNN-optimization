clc 
clear all
% close all

curDir = pwd;
% dataDir = ['C:\Users\hafsa\OneDrive\Desktop\DAMIAN CODES'];                                                % Directory where raw data stored
list = {'PM','UTurn',' ObstacleAvoidance','Emergency Stop'}; %,'WaWb'
[index,tf] = listdlg('PromptString','Select a file from below:',...
    'SelectionMode','single',...
    'ListString',list);

%% Load data
% cd(dataDir)

if index ==1  % Perimeter Monitering
    load('PMDatafile.mat')
    X = structSyncData.Filtered.xPos;
    Y = structSyncData.Filtered.yPos;
    
    S = structSyncData.Filtered.S;
    V = structSyncData.Filtered.V;
elseif index ==2  % U-Turn
    
    load('UturnDatafile.mat')
    X = structSyncData.Filtered.xPos;
    Y = structSyncData.Filtered.yPos;
    
    S = structSyncData.Filtered.S;
    V = structSyncData.Filtered.V;
elseif index ==3  % Obstacle Avoidance
    
    load('OADatafile.mat')
    X = structSyncData.Filtered.xPos;
    Y = structSyncData.Filtered.yPos;
    
    S = structSyncData.Filtered.S;
    V = structSyncData.Filtered.V;   
elseif index ==4  % Obstacle Avoidance
    
    load('ESDatafile.mat')
    X = structSyncData.Filtered.xPos;
    Y = structSyncData.Filtered.yPos;
    
    S = structSyncData.Filtered.S;
    V = structSyncData.Filtered.V;
end

%% STEERING  ANGLE DATA
figS = figure;
%scatter3(X(1:740),Y(1:740),S(1:740),'o','MarkerFaceColor', 'b')
quiver3(X(1:5:735),Y(1:5:735),S(1:5:735),diff(X(1:5:736)),diff(Y(1:5:736)),diff(S(1:5:736)),'LineWidth',1.5,'Color','b','AutoScale', 'off')

leg = legend('Steering angle trajectory');
leg.FontSize = 18;
leg.Position = [0.5728    0.8152    0.3521    0.0406];

hold on
ax = gca;
ax.FontSize = 18;
xLab = xlabel('$x$','FontSize', 35,'Interpreter','latex');
yLab = ylabel('$y$','FontSize', 35,'Interpreter','latex');
zLab = zlabel('$s$','FontSize', 35,'Interpreter','latex');

yLab.Position = [-25  28  -34.9063];
xLab.Position = [6    0.5  -35];

figS.Position = [427 80 886 862];
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
set(figS,'Units','Inches');
pos = get(figS,'Position');
set(figS,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% cd('D:\PHD\SMC19\SMC19 codes')
% print(figS,'PM','-dpdf','-r0')
hold on

%% VELOCITY DATA
figV = figure;
% scatter3(X(1:740),Y(1:740),V(1:740),'o','MarkerFaceColor', 'b')
quiver3(X(1:10:730),Y(1:10:730),V(1:10:730),diff(X(1:10:740)),diff(Y(1:10:740)),diff(V(1:10:740)),'LineWidth',1.5,'Color','b','AutoScale', 'off')


leg = legend('Rotor velocity trajectory');
leg.FontSize = 18;
leg.Position = [0.2003 0.7398 0.3521 0.0406];
hold on
ax = gca;
ax.FontSize = 18;
xLab = xlabel('$x$','FontSize', 35,'Interpreter','latex');
yLab = ylabel('$y$','FontSize', 35,'Interpreter','latex');
zLab = zlabel('$v$','FontSize', 35,'Interpreter','latex');

yLab.Position = [-26.9883   27    5.4371];
xLab.Position = [7   -1.1781    5.4451];


figV.Position = [427 80 886 862];
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
set(figV,'Units','Inches');
pos = get(figV,'Position');
set(figV,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% cd('D:\PHD\SMC19\SMC19 codes')
% print(figV,'PM','-dpdf','-r0')
zlim([5.5 5.9])
hold on