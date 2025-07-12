function [tdoa,mTime] = makeTDOA(ttmat)
%JAH
%make TDOA from matrix of travel times
%Columns are numbers of array 1,2,3,4,5
% order of TDOA columns:
% 2-1 3-1 4-1 5-1 3-2 4-2 5-2 4-3 5-3 5-4
%
% %
    stt = size(ttmat); mmrow = 10e5;
    for i = 1 : stt(2)
        mrow = find(ttmat(:,i)>0,1,'last');
        mmrow = min(mmrow,mrow);
    end
    mTime(1:mmrow) = ttmat(1:mmrow,1); % use site 1 = MC as time reference
    col = 1;
    gsum = stt(2) * (stt(2) -1) / 2; % from Gauss n*(n-1)/2
    tdoa = zeros(mmrow, gsum);
    %
    for i = 1: stt(2) - 1
        for j = i+1: stt(2)

            tdoa(1:mmrow,col) = 24*60*60 *(ttmat(1:mmrow,j) - ttmat(1:mmrow,i));% in seconds
            col = col + 1;

        end
    end
end