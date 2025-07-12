function [ttmat,ss,S,dt] = ...
    ShiftShip(C,fs,ttmat,shiftmat,isite,iship,fout,dtfig)
% JAH 5-2022
load(fout) % load DE data
MTT = MTTfix(MTT);
[t,ss] = findX(zID,slag,fs,iship,isite);
shift = shiftmat(isite,iship);
lt = length(t);
% figure(tfig)
% plot(t(shift:lt),'o','color',C(1,:))
% hold on
ttmat(1:lt-shift+1,isite,iship) = t(shift:lt);
dt = diff(t)*24*60*60;
figure(dtfig)
plot(dt(shift:end),'o','color',C(1,:))
S = sum(dt(5:86));
hold on
dt = seconds(dt);