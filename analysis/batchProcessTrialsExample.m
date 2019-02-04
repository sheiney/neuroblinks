base_dir = 'd:\data\behavior\ebc';

%%
mouse = 'M001';
isi = 250;
session = 1;
us = 3;
cs = 1;
day_offset = 0;
day = datestr(now - day_offset, 'yymmdd');

folder = fullfile(base_dir,  mouse, day);

trials = processTrials(folder, 'recalibrate');  % Recalibrate eyelid

if ~isempty(trials)
    
    save(fullfile(folder, 'trialdata.mat'), 'trials');

    [hf1, hf2]=makePlots(trials, isi, session, us, cs);

    hgsave(hf1, fullfile(folder, 'CRs.fig'));
    hgsave(hf2, fullfile(folder, 'CR_amp_trend.fig'));

    print(hf1, fullfile(folder, sprintf('%s_%s_CRs.pdf', mouse, day)), '-dpdf')
    print(hf2, fullfile(folder, sprintf('%s_%s_CR_amp_trend.pdf', mouse, day)), '-dpdf')

end

