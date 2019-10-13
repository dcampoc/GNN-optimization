clc
clear all
% close all

load ('GroundTruthAvoid2.mat');
Ground_truthU = GroundTruthAvoid2;
load ('GroundTruthAvoidOA.mat');
Ground_truthOA = GroundTruthAvoid2OA;
load ('GroundTruthAvoid2SV_OA.mat');
Ground_truthSV_OA = GroundTruthAvoid2SV_OA;
load ('GroundTruthAvoidES.mat');
Ground_truthES = GroundTruthAvoid2ES;
load ('GroundTruthAvoid2SV_ES.mat');
Ground_truthSV_ES = GroundTruthAvoid2SV_ES ;
load ('GroundTruthAvoidSVU.mat');
Ground_truthSVU = GroundTruthAvoid2SVU;

load ('GroundTruthAvoidOAC.mat');
Ground_truthOAC = GroundTruthAvoidOAC;
load ('GroundTruthAvoidESC.mat');
Ground_truthESC = GroundTruthAvoidESC;
load ('GroundTruthAvoidUC.mat');
Ground_truthUC = GroundTruthAvoidUC;


load('PosAbnSig.mat');
abnormdbPose = estimationAbn.AbnSignal ;
% abnormdbPose = smoothdata(abnormdbPose,2);
% plot(abnormdbPose)
load('OAAbnSig.mat');
abnormdbOA = estimationAbn.AbnSignal ;
% % 
% load('testing.mat');
% abnormdbOA = abnormdb2 ;
% abnormdbOA  = smoothdata(abnormdbOA,2);
load('ESPMAbnSig.mat');
abnormdbES = estimationAbn.AbnSignal;
load('SVOAAbnSig.mat');
abnormdbSVOA = estimationAbn.AbnSignal;
load('ESSVAbnSig.mat');
abnormdbSVES = estimationAbn.AbnSignal;
load('SVAbnSig.mat');
abnormdbSVU = estimationAbn.AbnSignal; 



load('EstimationAbnAvoid.mat')
abnormdbOAC = EstimationAbnAvoid.db2(:,71:920);
load('EstimationAbnstop.mat')
abnormdbESC = db2(:,81:930);
load('EstimationAbnU.mat')
abnormdbUC = db2(:,51:900);

% load('PoseOneNormSig.mat');
% OneNormPose = EstimationAbn.AbnSignal;
% load('OdomOneNormSig.mat');
% OneNormOdom = EstimationAbn.AbnSignal;
% load('SonarOneNormSig.mat');
% OneNormSonar = EstimationAbn.AbnSignal;

[Roc_abnormdbPose ,AUC_abnormdbPose,ACC_abnormdbPose] = Roc_calculation(abnormdbPose,Ground_truthUC);
[Roc_abnormdbOA ,AUC_abnormdbOA,ACC_abnormdbOA] = Roc_calculation(abnormdbOA ,Ground_truthOA);
[Roc_abnormdbES ,AUC_abnormdbES,ACC_abnormdbES] = Roc_calculation(abnormdbES,Ground_truthES);
[Roc_abnormdbSVOA ,AUC_abnormdbSVOA,ACC_abnormdbSVOA] = Roc_calculation(abnormdbSVOA ,Ground_truthSV_OA);
[Roc_abnormdbSVES ,AUC_OneNormbSVES,ACC_OneNormSVES] = Roc_calculation(abnormdbSVES,Ground_truthSV_ES);
[Roc_abnormdbSVU ,AUC_OneNormbSVU,ACC_OneNormSVU] = Roc_calculation(abnormdbSVU,Ground_truthSVU);
 

[Roc_abnormdbOAC ,AUC_OneNormbOAC,ACC_OneNormOAC] = Roc_calculation(abnormdbOAC,Ground_truthOA);
[Roc_abnormdbESC ,AUC_OneNormbESC,ACC_OneNormESC] = Roc_calculation(abnormdbOAC,Ground_truthESC);
[Roc_abnormdbUC ,AUC_OneNormbUC,ACC_OneNormUC] = Roc_calculation(abnormdbUC,Ground_truthUC);


% [Roc_OneNormOdom ,AUC_OneNormOdom,ACC_OneNormOdom] = Roc_calculation(OneNormOdom ,zeros(size(OneNormOdom )));
% [Roc_OneNormSonar ,AUC_OneNormSonar,ACC_OneNormSonar] = Roc_calculation(OneNormSonar,zeros(size(OneNormSonar)));

Roc_abnormdbPose(1,1)=1;
Roc_abnormdbOA(1,1)=1;
Roc_abnormdbES(1,1)=1;
Roc_abnormdbSVOA(1,1)=1;
Roc_abnormdbSVES(1,1)=1;
Roc_abnormdbSVU(1,1)=1;


Roc_abnormdbOAC(1,1)=1;
Roc_abnormdbESC(1,1)=1;
Roc_abnormdbUC(1,1)=1;

% Roc_OneNormPose(1,1)=1;
% Roc_OneNormOdom(1,1)=1;
% Roc_OneNormSonar(1,1)=1;
%% plotting
figure(3);
plot(Roc_abnormdbPose(1,:),Roc_abnormdbPose(2,:),'b','LineWidth',1.3)
hold on
plot(Roc_abnormdbOA(1,:),Roc_abnormdbOA(2,:),'k','LineWidth',1.3)
hold on
plot(Roc_abnormdbES(1,:),Roc_abnormdbES(2,:),'r','LineWidth',1.3)
hold on
plot(Roc_abnormdbSVOA(1,:),Roc_abnormdbSVOA(2,:),'g','LineWidth',1.3)
hold on
plot(Roc_abnormdbSVES(1,:),Roc_abnormdbSVES(2,:),'m','LineWidth',1.3)
hold on
plot(Roc_abnormdbSVU(1,:),Roc_abnormdbSVU(2,:),'c','LineWidth',1.3)
hold on
plot(Roc_abnormdbOAC(1,:),Roc_abnormdbOAC(2,:),'-.k','LineWidth',1.3)
hold on
plot(Roc_abnormdbESC(1,:),Roc_abnormdbESC(2,:),'-.r','LineWidth',1.3)
hold on
plot(Roc_abnormdbUC(1,:),Roc_abnormdbUC(2,:),'-.b','LineWidth',1.3)
hold on

plot(Roc_OneNormPose(1,:),Roc_OneNormPose(2,:),'m','LineWidth',1.3)

hold on
plot(Roc_OneNormOdom(1,:),Roc_OneNormOdom(2,:),'k','LineWidth',1.3)
hold on
plot(Roc_OneNormSonar(1,:),Roc_OneNormSonar(2,:),'c','LineWidth',1.3)

legend('U-turn odometry','OA odometry','ES odometry','OA control', 'ES control','U-turn control');
legend('OA odometry','OAC');
legend('Roc_abnormdbPose','Roc_abnormdbOdom','Roc_abnormdbSonar','Roc_OneNormPose','Roc_OneNormOdom','Roc_OneNormSonar')

xlabel('$False\ Positive$','FontSize', 14,'Interpreter','latex');
ylabel('$True\ Positive$','FontSize', 14,'Interpreter','latex');
title('$ROC\ Features$','FontSize', 14,'Interpreter','latex')
grid on

