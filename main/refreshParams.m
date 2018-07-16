function refreshParams(handles)
metadata = getappdata(0, 'metadata');
trials = getappdata(0, 'trials');

trials.savematadata = get(handles.checkbox_save_metadata, 'Value');
val = get(handles.popupmenu_stimtype, 'Value');
str = get(handles.popupmenu_stimtype, 'String');
metadata.stim.type = str{val};
if metadata.cam.cal, metadata.stim.type = 'Puff'; end % for Cal

metadata.stim.c.csdur = 0;
metadata.stim.c.csnum = 0;
metadata.stim.c.isi = 0;
metadata.stim.c.usdur = 0;
metadata.stim.c.usnum = 0;
metadata.stim.c.cstone = [0 0];

metadata.stim.l.delay = 0;
metadata.stim.l.dur = 0;
metadata.stim.l.amp = 0;

metadata.stim.p.puffdur = str2double(get(handles.edit_puffdur, 'String'));

switch lower(metadata.stim.type)
    case 'none'
        metadata.stim.totaltime = 0;
    case 'puff'
        metadata.stim.totaltime = metadata.stim.p.puffdur;
    case 'conditioning'
        trialvars = readTrialTable(metadata.cam.trialnum);
        metadata.stim.c.csdur = trialvars(1);
        metadata.stim.c.csnum = trialvars(2);
        metadata.stim.c.isi = trialvars(3);
        metadata.stim.c.usdur = trialvars(4);
        metadata.stim.c.usnum = trialvars(5);
        metadata.stim.c.cstone = str2num(get(handles.edit_tone, 'String'))*1000;
        if length(metadata.stim.c.cstone) < 2, metadata.stim.c.cstone(2) = 0; end
        metadata.stim.totaltime = metadata.stim.c.isi + metadata.stim.c.usdur;
        metadata.stim.l.delay = trialvars(6);
        metadata.stim.l.dur = trialvars(7);
        metadata.stim.l.amp = trialvars(8);
    otherwise
        metadata.stim.totaltime = 0;
        warning('Unknown stimulation mode set.');
end

% Set ITI using base time plus optional random range
base_ITI = str2double(get(handles.edit_ITI, 'String'));
rand_ITI = str2double(get(handles.edit_ITI_rand, 'String'));
metadata.stim.c.ITI = base_ITI + rand(1, 1) * rand_ITI;

metadata.cam.time(1) = str2double(get(handles.edit_pretime, 'String'));
metadata.cam.time(2) = metadata.stim.totaltime;
metadata.cam.time(3) = str2double(get(handles.edit_posttime, 'String')) - metadata.stim.totaltime;

metadata.now = now;

setappdata(0, 'metadata', metadata);
setappdata(0, 'trials', trials);