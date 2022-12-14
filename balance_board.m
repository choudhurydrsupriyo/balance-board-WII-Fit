close all
clear all
clc
sonfile=openSMR (['E:\Subhashish Da\balance_dummy_SC_21092022.smr']);
Pa=readSMRadc (sonfile,1,0,inf);% channel number 1 or 2 etc.
Pb=readSMRadc (sonfile,2,0,inf);% channel number 1 or 2 etc.
Pc=readSMRadc (sonfile,3,0,inf);% channel number 1 or 2 etc.
Pd=readSMRadc (sonfile,4,0,inf);% channel number 1 or 2 etc.
srate=5000;%per second 
wt=Pa(2:end)+Pb(2:end)+Pc+Pd;
grfa=(Pa(2:end)./wt)*100;%(1:(end-1))
grfb=(Pb(2:end)./wt)*100;
grfc=(Pc./wt)*100;
grfd=(Pd./wt)*100;
t=[0:1/5000:length(Pc)/5000];
t=t(2:length(t));
subplot(2,3,1);
plot(t,grfa);
xlabel('time (s)')
ylabel('body weight percentage (kg)');
hold on 
subplot(2,3,2);
plot(t,grfb);
xlabel('time (s)')
ylabel('body weight percentage (kg)');
subplot(2,3,3);
plot(t,grfc);
xlabel('time (s)')
ylabel('body weight percentage (kg)');
subplot(2,3,4);
plot(t,grfd);
xlabel('time (s)')
ylabel('body weight percentage (kg)');
%%
xa=215;
xb=-215;
xc=-215;
xd=215;
ya=118.5;
yb=118.5;
yc=-118.5;
yd=-118.5;
xcop=(Pa(2:end)*xa+Pb(2:end)*xb+Pc*xc+Pd*xd)./wt;
ycop=(Pa(2:end)*ya+Pb(2:end)*yb+Pc*yc+Pd*yd)./wt;
fco=fir1(1000,20/2500,'low'); %20Hz low pass
xcop=conv ([xcop(1)*ones(500,1);xcop;xcop(end)*ones(500,1)],fco,'same');
ycop=conv ([ycop(1)*ones(500,1);ycop;ycop(end)*ones(500,1)],fco,'same');
xcop=xcop(501:end-500);
ycop=ycop(501:end-500);

sdx=std (xcop)
sdy=std (ycop)
sdtot=sqrt(sdx^2+sdy^2)



subplot(2,3,5);
plot (xcop,ycop)
xlabel('ML displacement (mm)');
ylabel('AP displacement (mm)');


