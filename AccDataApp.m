%% Only Accelerometer data comparison

clear all, close all, clc;

%Right pocket & walking with slippers (1)
RPWSlippers = load('RightPocketSlipers50steps.mat');
one = "Phone in the right pocket & walking with slippers";
%Left pocket & Walking with slippers (2)
LPWSlippers = load('LeftPocketSlipers51steps.mat');
two = "Phone in the left pocket & walking with slippers";
%Phone at hand stable & Walking with slippers (3)
HSWSlippers = load('AthandStablewithslipers.mat');
three = "Phone at hand stable & walking with slippers";
%Phone at hand waving & Walking with slippers (4)
HWWSlippers = load('AtHandWaving48steps.mat');
four = "Phone at hand waving & walking with slippers";

%Right Pocket & walking with Shoes (5)
RPWShoes = load('RightPocketWithShoes50steps.mat');
five = "Phone in the right pocket & walking with shoes";
%Left pocket & walking with Shoes (6)
LPWShoes = load('LeftPocketWithShoes48steps.mat');
six = "Phone in the left pocket & walking with shoes";
%Phone at hand stable & Walking with Shoes (7)
HSWShoes = load('AtHandWithShoes49steps.mat');
seven = "Phone at hand stable & walking with shoes";
%Phone at hand waving & Walking with slippers (8)
HWWShoes = load('AtHandWavingwithShoes48steps.mat');
eight = "Phone at hand waving & walking with slippers";

data = {RPWSlippers,LPWSlippers,HSWSlippers,HWWSlippers,RPWShoes,LPWShoes,HSWShoes,HWWShoes};

titles = {one,two,three,four,five,six,seven,eight};
titles = string(titles);

n = length(data);
figure(1)
for i=1:n
    [t,X,Y,Z,Combined] = AccDataParam(data{1,i});
    
    subplot(n,2,2*i-1) % 1 3 5  
    plot(t,[X,Y,Z]);
    title(['Acc data X-Y-Z from ',titles(:,i),],fontsize=16)
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');
    
    subplot(n,2,2*i)
    plot(t,Combined)
    [t,s]=title(['Acc data sqrt(X.^2+Y.^2+Z.^2) from ',titles(:,i)],fontsize=16)

    legend('Combined and normalized');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');
    
end


n = length(data);
figure(2)
lambda=30;
for i=1:n
    [t,X,Y,Z,Combined] = AccDataParam(data{1,i});
    [X_l1,status] = l1tf(X, lambda);
    [Y_l1,status] = l1tf(Y, lambda);
    [Z_l1,status] = l1tf(Z, lambda);
    
    Xd = X - X_l1;
    Yd = Y - Y_l1;
    Zd = Z - Z_l1;

    subplot(n,2,2*i-1) % 1 3 5  
    plot(t,[Xd,Yd,Zd]);
    title(['L1-trend filtering acc data X-Y-Z ',titles(:,i),],fontsize=16)
    legend('X', 'Y', 'Z');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');
    
    subplot(n,2,2*i)
    Combined = sqrt(Xd.^2+Yd.^2+Zd.^2);
    plot(t,Combined)
    title(['Combined acc data L1-trend filtering ',titles(:,i)],fontsize=16)
    
    legend('Combined and normalized');
    xlabel('Relative time (s)');
    ylabel('Acceleration (m/s^2)');
    
end


