function ucontroller_obj = connectMicrocontroller(config)

    % Set it up as a switch statement because we will add other options later
    switch config.device
        case 'arduino'
            ucontroller_obj = connectArduino(config);
        otherwise
            ucontroller_obj = [];
    end
