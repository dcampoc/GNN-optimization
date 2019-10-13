%% Plot Results
% figure(10)
% load('PosAbnSig.mat')
% plot(estimationAbn.AbnSignal,'r')
% hold on
% load('SVAbnSig.mat')
% plot(estimationAbn.AbnSignal,'b')
% legend('odometry','control')
% title('Abnormality Detection Signal')



close all
clear
clc
curDir = pwd;
trainingDataBool  = false;    % true for pos and false for sv data

cd('C:\Users\hafsa\OneDrive\Desktop\ICASSP\SMC19\SMC19 codes')
if trainingDataBool == false
    load('PosAbnSig.mat')                    % uturn
    abnormdb2 = estimationAbn.AbnSignal;
%     abnormdb2 = smoothdata(abnormdb2,2);
% abnormdb2 = smooth(abnormdb2)
else
     load('PosAbnSig.mat')
    abnormdb2 = estimationAbn.db1;

end


if trainingDataBool == false
    load('SVAbnSig.mat')
    abnormdb2C = estimationAbn.AbnSignal;
%     abnormdb2C = smoothdata( abnormdb2C,2);
  
else
    load('SVAbnSig.mat')
    abnormdb2C =estimationAbn.db1; 
end


cd(curDir)
figDB2 = figure(2);
figDB2.Position = [0 535 1671 288];
hold on
grid on

% if trainingDataBool == false
    rec1 = rectangle('Position',[0 0  131 1],'Curvature',0);  % straight motion
    rec1.EdgeColor = 'none';
    rec1.FaceColor = [1 0.1 1 0.1];
    
    rec2 = rectangle('Position',[131 0  184-131 1],'Curvature',0); % entering u turn
    rec2.EdgeColor = 'none';
    rec2.FaceColor = [0.1 0.6 0.9 0.15];
    
    rec3 = rectangle('Position',[184 0  241-184 1],'Curvature',0); %  u turn 
    rec3.EdgeColor = 'none';
    rec3.FaceColor = [1 1 0 0.15];
    
    rec4 = rectangle('Position',[241 0  292-241 1],'Curvature',0); % straight motion 
    rec4.EdgeColor = 'none';
    rec4.FaceColor = [1 0.1 1 0.1];
    
    rec5 = rectangle('Position',[292 0  359-292 1],'Curvature',0); % curve
    rec5.EdgeColor = 'none';
    rec5.FaceColor = [0 0.2 0.1 0.1];
    
    rec6 = rectangle('Position',[359 0  482-359 1],'Curvature',0); % straight motion 
    rec6.EdgeColor = 'none';
    rec6.FaceColor = [1 0.1 1 0.1];
    
     rec5 = rectangle('Position',[482 0  584-482 1],'Curvature',0); % curve
    rec5.EdgeColor = 'none';
    rec5.FaceColor = [0 0.2 0.1 0.1];
     rec6 = rectangle('Position',[584 0  660-584 1],'Curvature',0); % straight motion 
    rec6.EdgeColor = 'none';
    rec6.FaceColor = [1 0.1 1 0.1];
    
    
    rec7 = rectangle('Position',[660 0  704-660 1],'Curvature',0); % uturn 
    rec7.EdgeColor = 'none';
    rec7.FaceColor = [1 1 0 0.15];
    
    rec8 = rectangle('Position',[704 0  747-704 1],'Curvature',0); % leaving uturn
    rec8.EdgeColor = 'none';
    rec8.FaceColor = [0.1 0.6 0.9 0.15 ];
    
    rec9 = rectangle('Position',[747 0  805-747 1],'Curvature',0); % straight motion
    rec9.EdgeColor = 'none';
    rec9.FaceColor = [1 0.1 1 0.1];
    
    p1 = plot(abnormdb2(4:end-9)', 'r','linewidth',1.2);    
    p2 = plot(abnormdb2C(4:end-9)', 'b','linewidth',1.2);   
    axis ([0 806 0 1])
% else
%     p1 = plot(abnormdb2Norm(4:end)', 'r','linewidth',1.2);
%     hold on
%     p2 = plot(abnormdb2CNorm(4:end)', 'b','linewidth',1.2);
%     axis ([0 806 0 1])
% end

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

% if trainingDataBool == false
    ax.Position = [left bottom ax_width ax_height-0.1];
% else
%     ax.Position = [left bottom ax_width ax_height];
% end
set(figDB2,'Units','Inches');
pos = get(figDB2,'Position');
set(figDB2,'PaperPositionMode','Auto','PaperUnits','Inches',...
    'PaperSize',[pos(3), pos(4)])

% if trainingDataBool == false
    txt = 'Straight motion 1';
    tx = text(30,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Entering U-turn';
    tx = text(130,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'U turn 1 ';
    tx = text(200,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight motion 2';
    tx = text(245.25,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Curve 1';
    tx = text(314,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight motion 3';
    tx = text(390,1.09,txt);
    tx.FontSize = 12;
    
     txt = 'Curve 2';
    tx = text(520,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Straight motion 4';
    tx = text(590,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'U turn 2';
    tx = text(670,1.09,txt);
    tx.FontSize = 12;
    
    txt = 'Leaving';
    tx = text(710,1.09,txt);
    tx.FontSize = 12;
    txt = 'u-turn';
    tx = text(710,1.03,txt);
    tx.FontSize = 12;
    
    
    txt = 'Straight';
    tx = text(760,1.09,txt);
    tx.FontSize = 12;
     txt = 'motion 5';
    tx = text(760,1.03,txt);
    tx.FontSize = 12;
    
      
% end
cd('C:\Users\hafsa\OneDrive\Desktop\ICASSP\SMC19\SMC19 codes')

    print(figDB2,'abnSignalsUturn','-dpdf','-r0')
