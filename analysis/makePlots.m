function varargout = makePlots(trials,varargin)

ms2frm = @(ms) ms ./ 1e3 * 200;	% Convert ms to frames

if length(varargin) > 0
    isi = varargin{1};
    session = varargin{2};
    us = varargin{3};
    cs = varargin{4};
else
    isi = 200;
    session = 1; % Session s01
    us = 3;
    cs = 2;
end

%% Eyelid traces
hf1=figure;
hax=axes;

idx = find(trials.c_usnum==us & trials.c_csnum==cs & ismember(trials.session_of_day, session));

set(hax,'ColorOrder', jet(length(idx)), 'NextPlot', 'ReplaceChildren');
plot(trials.tm(1,:), trials.eyelidpos(idx, :)')     % transpose matrix before plotting to deal with rare cases where m == n and Matlab chooses to plot columns instead of rows
hold on 
plot(trials.tm(1, :), mean(trials.eyelidpos(idx, :)), 'k', 'LineWidth', 2)
axis([trials.tm(1, 1) trials.tm(1, end) -0.1 1.1])
title('CS-US')
xlabel('Time from CS (s)')
ylabel('Eyelid pos (FEC)')


%% CR amplitudes
pre = 1:ms2frm(100);
win = ms2frm(200 + isi):ms2frm(200 + isi + 15);
cramp = mean(trials.eyelidpos(:, win), 2) - mean(trials.eyelidpos(:, pre), 2);

hf2=figure;

idx = find(trials.c_usnum==us & trials.c_csnum==cs & ismember(trials.session_of_day, session));
plot(trials.trialnum(idx), cramp(idx), '.')
hold on
plot([1 length(trials.trialnum)], [0.1 0.1], ':k')
axis([1 length(trials.trialnum) -0.1 1.1])
title('CS-US')
xlabel('Trials')
ylabel('CR size')

if nargout > 0
    varargout{1} = hf1;
    varargout{2} = hf2;
end