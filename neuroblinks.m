% Set up environment and launch app 
function neuroblinks(varargin)

    % Load local configuration for these rigs
    % Should be somewhere in path but not "neuroblinks" directory or subdirectory
    neuroblinks_config

    % Set up defaults in case user doesn't specify all options
    rig = DEFAULTRIG;

    % fprintf('Device: %s, Rig: %d\n', device, rig);
    % return
    [basedir,mfile,ext]=fileparts(mfilename('fullpath'));
    oldpath=addpath(genpath(fullfile(basedir,'main')));

    config.rig = rig;
    config.oldpath = oldpath;   % save so we can restore later if desired
    setappdata(0, 'config', config)

    launch(rig)
