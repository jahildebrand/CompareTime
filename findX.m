function [t,ss] = findX(zID,slag,fs,ship,site)
% JAH 6-2021

i5  = find(zID(:,2) == ship);
% MTT5 = MTT(i5);
zID5 = zID(i5,1); %+ clockcor(site)/(24*60*60);

ss = size(zID5);
for i = 1: ss(1)
    t(i) = zID5(i) - slag{1,ship}(i,1)/(fs*24*60*60);% , 'second');
end
disp(['Ship ',num2str(ship),' Site ',num2str(site),' Number pulses: ',num2str(ss(1))]);


