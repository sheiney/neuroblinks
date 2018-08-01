% Set up environment and launch app 
function neuroblinks(varargin)

    % Load local configuration for these rigs
    % Should be somewhere in path but not "neuroblinks" directory or subdirectory
    neuroblinks_config

    % Load local configuration for these rigs
    rig_config;
    user_config;

    % Set up defaults in case user doesn't specify all options
    rig = DEFAULTRIG;
    device = DEFAULTDEVICE;

    % Input parsing
    % Values passed override defaults set in neuroblinks_config
    if nargin > 0
        for i=1:nargin
            if any(strcmpi(varargin{i},config.ALLOWEDDEVICES))
                device = varargin{i};
            elseif ismember(varargin{i},1:length(config.CAMERA1_IDS))
                rig = varargin{i}; 
            end
        end
    end

    % fprintf('Device: %s, Rig: %d\n', device, rig);
    % return
    [basedir,mfile,ext]=fileparts(mfilename('fullpath'));
    oldpath=addpath(genpath(fullfile(basedir,'main')));

    config.rig = rig;
    config.device = device;
    config.oldpath = oldpath;   % save so we can restore later if desired

    launch(config)