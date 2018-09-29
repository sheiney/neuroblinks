function ok = initializeSession()
% This is executed when user presses the button to start a new session in in the main GUI
% Initializes per session variables, some of which can be loaded from mouse config files

metadata=getappdata(0,'metadata');
config=getappdata(0,'config');

for i=1:length(config.camera)

    metadata.cam(i).trialnum=1;
    metadata.cam(i).thresh=0.125;

    metadata.cam(i).cal=0;
    metadata.cam(i).calib_offset=0;
    metadata.cam(i).calib_scale=1;
    
end

metadata.ts=[datenum(clock) 0]; % two element vector containing datenum at beginning of session and offset of current trial (in seconds) from beginning

dirlist = dir(config.userdatapath);
dirs = [dirlist.isdir];
dirlistnames = {dirlist.name};
subdirs = dirlistnames(dirs);

mice = regexp(subdirs, '[a-zA-Z]\d\d\d', 'match', 'once');
mice = mice(~cellfun(@isempty, mice));

[idx, ok] = listdlg('PromptString', 'Select a mouse', 'SelectionMode', 'single', 'ListString', mice);

if ok
    mouse = mice{idx};
else
    return
end

metadata.mouse = mouse;

mousedir = fullfile(config.userdatapath, mouse); 

sessiondir = fullfile(mousedir, datestr(now,'yymmdd'));

mkdir(sessiondir)
cd(sessiondir)

metadata.folder = sessiondir;

condfile=fullfile(mousedir,'condparams.csv');

if exist(condfile, 'file')
%     paramtable = getappdata(0,'paramtable');

    config.paramtable.data = csvread(condfile);
    config.paramtable.randomize = handles.checkbox_randomize.Value;                 % Do we want to assume randomization here or read from gui?
    config.trialtable = makeTrialTable(config.paramtable.data, config.paramtable.randomize);
    
%     setappdata(0,'paramtable',paramtable);
%     setappdata(0,'trialtable',trialtable);
end

setappdata(0, 'metadata', metadata);
setappdata(0, 'config', config);

drawnow         % Seems necessary to update appdata before returning to calling function