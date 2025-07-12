% CompareTime
% jah v1 5-2022
% compare DE output between sites for a given ship
% use SelectSite fout to get input DE files
clear all
global p
p = getRCParams; % paramter file
% hrout = fout(end-12:end-11);
% hrmnsc = fout(end-12:end-7);
% [fold,fin,fout] = SelectSite(p.site); % file in and file out
mtdoafn = cell(p.nships,1);
for iship = 1 : p.nships
mtdoafn{iship,1} = fullfile(p.mtfn,p.Hour,['mtdoa_',p.ymd,'_',p.Hour,p.Min,p.Sec,'s',num2str(iship)]);
end
%
% Site labels
lab = p.HARPName; % sites
nships = p.nships; % number of ships
nsites = length(lab);
nshots = 171; % number of shots

ttmat = zeros(nshots,nsites,nships);
% shiftmat=[1,1,1,1,1;...% mc
%         1,1,1,1,1;...% mp
%         1,1,1,1,1;...% dc
%         1,1,1,1,1;...% dt
%         1,1,1,1,1];% hh
shiftmat= ones(length(lab),nships);

% 
fs = p.fs;
C = linspecer(12,'qualitative');
%
for iship = 1 : nships
    dtfig(iship) = figure;
%     tfig(iship) = figure;
    for isite = 1 : nsites
        [~,~,fout] = SelectSite(lab{isite});
        [ttmat,ss] =  ShiftShip(C(isite,:),fs,ttmat,shiftmat,isite,iship,...
            fout,dtfig(iship));
    end
    figure(dtfig(iship)) % show pattern of time difference
    legend(lab)
%     figure(tfig(iship))
%     legend(lab)
end

C = linspecer(36,'qualitative');
% make TDOA for each ship
for iship = 1 : nships
    [mTDOA,mTime] = makeTDOA(ttmat(:,:,iship));
    stdoa = size(mTDOA);
    figure
    % subplot(stdoa(2),1)
    hold on
    for i = 1: stdoa(2)
        plot(mTDOA(:,i),'o','color',C(i,:));
    end
    [B,TF,~,~,~] = filloutliers(mTDOA,'linear','movmedian',20); % fix outlier points
    cBAD = nnz(TF); % number of bad data points
    if cBAD > 0
        disp(['Number of Bad Points ',num2str(cBAD),' for Ship ',num2str(iship)])
    end
    for i = 1: stdoa(2)
        plot(B(:,i),'color',C(i,:));
    end
    legend('2-1','3-1','4-1','5-1','3-2','4-2','5-2','4-3','5-3','5-4',...
        'Location','southeast','Orientation','horizontal','NumColumns',2)
    mTDOA = B;
    %
    save(mtdoafn{iship,1},'mTDOA','mTime','TF');
end






