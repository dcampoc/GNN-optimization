%% Plot Results
% figure(10)
% load('PosAbnSig.mat')
% plot(estimationAbn.AbnSignal,'r')
% hold on
% load('SVAbnSig.mat')
% plot(estimationAbn.AbnSignal,'b')
% legend('odometry','control')
% title('Abnormality Detection Signal')



% close all
% clear
% clc
curDir = pwd;
trainingDataBool  = false;    % true for pos and false for sv data
plotData =2;
maxTimeInst = 820;
cd('C:\Users\hafsa\OneDrive\Desktop\ICASSP\SMC19\SMC19 codes')
if trainingDataBool  == false
%     load('OAAbnSig.mat')                    % uturn
%     abnormdb2 = estimationAbn.AbnSignal;

load('testing.mat');
abnormdb2 = abnormdb2 ;
% abnormdb2 = smoothdata(abnormdb2,2);
% abnormdb2 = smooth(abnormdb2)'
else
     load('OAAbnSig.mat') 
    abnormdb2 = estimationAbn.db1;

end

%   Normalization
abnormdb2 = abnormdb2(1,1:maxTimeInst);
abnormdb2(118) = abnormdb2(118)/2;
abnormdb2 = abnormdb2/max(abnormdb2);
% save('abnormdb.mat')
if trainingDataBool  == false
    load('SVOAAbnSig.mat' )
    abnormdb2C = estimationAbn.AbnSignal;
%     abnormdb2C = smooth(abnormdb2C)'
%     abnormdb2C = smoothdata(abnormdb2C,2);
   
else
    load('SVOAAbnSig.mat' )
    abnormdb2C = estimationAbn.db1; 
end

%   Normalization
abnormdb2C = abnormdb2C(1,1:maxTimeInst);
abnormdb2C = abnormdb2C/max(abnormdb2C);

cd(curDir)
figDB2 = figure(2);
figDB2.Position = [0 535 1671 288];
hold on
grid on


    rec1 = rectangle('Position',[0 0  50 1],'Curvature',0);  % curve 1
    rec1.EdgeColor = 'none';
    rec1.FaceColor = [0 0.2 0.1 0.1];
    
    rec2 = rectangle('Position',[50 0  100-50 1],'Curvature',0); % straight motion 1
    rec2.EdgeColor = 'none';
    rec2.FaceColor = [1 0.1 1 0.1];
    
    rec3 = rectangle('Position',[100 0  160-100 1],'Curvature',0); % oa 1
    rec3.EdgeColor = 'none';
    rec3.FaceColor = [1 1 0 0.15];
    
    rec4 = rectangle('Position',[160 0  200-160 1],'Curvature',0); % straight motion 2
    rec4.EdgeColor = 'none';
    rec4.FaceColor = [1 0.1 1 0.1];
    
    rec5 = rectangle('Position',[200 0  220-200 1],'Curvature',0); % curve 2 
    rec5.EdgeColor = 'none';
    rec5.FaceColor = [0 0.2 0.1 0.1];
    
    rec6 = rectangle('Position',[220 0  350-220 1],'Curvature',0); % straight motion 3 
    rec6.EdgeColor = 'none';
    rec6.FaceColor = [1 0.1 1 0.1];
     
    rec7 = rectangle('Position',[350 0  395-350 1],'Curvature',0); % curve 3 
    rec7.EdgeColor = 'none';
    rec7.FaceColor = [0 0.2 0.1 0.1];
    
    rec8 = rectangle('Position',[395 0  425-395 1],'Curvature',0); %straight motion 4  
    rec8.EdgeColor = 'none';
    rec8.FaceColor = [1 0.1 1 0.1];
    
    rec9 = rectangle('Position',[425 0  496-425 1],'Curvature',0); % OA 2
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [1 1 0 0.15];
    
    rec9 = rectangle('Position',[496 0  530-496 1],'Curvature',0); % SM 5
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [1 0.1 1 0.1];
     
    rec9 = rectangle('Position',[530 0  585-530 1],'Curvature',0); % C 4  
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [0 0.2 0.1 0.1];
    
    rec9 = rectangle('Position',[585 0  740-585 1],'Curvature',0); % SM 6
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [1 0.1 1 0.1];
     
    rec9 = rectangle('Position',[740 0  775-740 1],'Curvature',0); % C 1
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [0 0.2 0.1 0.1];
     
    rec9 = rectangle('Position',[775 0  820-775 1],'Curvature',0); % SM 1
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [1 0.1 1 0.1];
     
    
    p1 = plot(abnormdb2(4:end-9)', 'r','linewidth',1.2);    
    p2 = plot(abnormdb2C(4:end-9)', 'b','linewidth',1.2); 
%     yline(0.4441,'-.b','LineWidth',1); % 0.4441
    axis ([0 820 0 1])


leg = legend([p1,p2],{'Odometry module', 'Control module'});
leg.FontSize = 10;

ax = gca;
ax.FontSize = 12;
xlabel('Time instances ($k$)','FontSize', 15,'Interpreter','latex')
ylabel('Abnormality signals ($\theta$)','FontSize', 15,'Interpreter','latex')
leg.Orientation = 'horizontal';

% if trainingDataBool == true
%     leg.Position = [0.7369 0.8848 0.2244 0.0972];
% else
%     leg.Position = [0.7704 0.8640 0.2244 0.0972];
% end

outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);


    ax.Position = [left bottom ax_width ax_height-0.1];


set(figDB2,'Units','Inches');
pos = get(figDB2,'Position');
set(figDB2,'PaperPositionMode','Auto','PaperUnits','Inches',...
    'PaperSize',[pos(3), pos(4)])


    txt = 'Curve 1';
    tx = text(0,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight';
    tx = text(55,1.1,txt);
    tx.FontSize = 12;
    txt = 'motion 1';
    tx = text(55,1.03,txt);
    tx.FontSize = 12;
    
    
    txt = 'OA 1';
    tx = text(120,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight';
    tx = text(165,1.1,txt);
    tx.FontSize = 12;
    txt = 'motion 2';
    tx = text(165,1.03,txt);
    tx.FontSize = 12;
    
    
    txt = 'Curve 2';
    tx = text(200,1.1,txt);
    tx.FontSize = 12;
    
    txt = 'Straight motion 3';
    tx = text(250,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Curve 3';
    tx = text(350,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight';  %%%
    tx = text(395,1.09,txt);
    tx.FontSize = 12;
    txt = 'motion 4';  %%%
    tx = text(395,1.03,txt);
    tx.FontSize = 12;
    
    
    txt = 'OA 2';
    tx = text(450,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight';  %%%
    tx = text(495,1.09,txt);
    tx.FontSize = 12;
      txt = 'motion 5';  %%%
    tx = text(495,1.03,txt);
    tx.FontSize = 12;
    
    
    txt = 'Curve 4';
    tx = text(540,1.09,txt);
    tx.FontSize = 12;
    
     txt = 'Straight motion 6';
    tx = text(615,1.09,txt);
    tx.FontSize = 12;
    
     txt = 'Curve 1';
    tx = text(740,1.09,txt);
    tx.FontSize = 12;
    
     txt = 'Straight';
    tx = text(780,1.09,txt);
    tx.FontSize = 12;
    txt = 'motion 1';
    tx = text(780,1.03,txt);
    tx.FontSize = 12;
    
%     cd('C:\Users\hafsa\OneDrive\Desktop\ICASSP 2020\SMC19\SMC19 codes')

%     print(figDB2,'abnSignalsOAturn','-dpdf','-r0')
    
      

