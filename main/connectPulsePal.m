function [pulsepal, config] = connectPulsePal(config)
    % Do we get an ID for pulsepal to identify it subsequently?
    pulsepal = [];

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
    catch        
        ok = 0;       
    end

    config.pulsepal.connected = ok;

end