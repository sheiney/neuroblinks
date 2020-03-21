function config = connectPulsePal(config)
    % Note that the PulsePal library relies on a global object PulsePal in the base workspace so doesn't have a handle that needs to be passed around
    % We just keep a config setting telling us whether or not a PulsePal is connected

    % Do we get an ID for pulsepal to identify it subsequently?
    % pulsepal = [];

    %% -- start serial communication to PulsePal ---
    disp('Connecting to PulsePal...')

    % This is the faster version if you have PlatformIO command line tools installed
    com_port = getComPort(config.PULSEPAL_IDS{config.rig});

    if ~isempty(com_port)
        config.pulsepal.com_ports(config.rig) = com_port; 
    else
        error('No PulsePal found for requested rig (%d)', config.rig);        
    end

    try               
        PulsePal(com_port)
        ok = 1;    
    catch ME   
        ok = 0;   
        warning('Error connecting to PulsePal--no PulsePal currently connected');
    end

    config.pulsepal.connected = ok;

end