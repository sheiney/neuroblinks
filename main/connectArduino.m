function arduino = connectArduino(config)

    %% -- start serial communication to arduino ---
    disp('Finding Arduino...')
    com_ports = findArduinos(config.MICROCONTROLLER_IDS);

    if isempty(com_ports{config.rig})
        error('No Arduino found for requested rig (%d)', config.rig);
    end

    arduino=serial(com_ports{config.rig},'BaudRate',115200);
    arduino.InputBufferSize = 512*8;
    arduino.DataTerminalReady='off';	% to prevent resetting Arduino on connect
    fopen(arduino);

end

function com_ports = findArduinos(ids)
    com_ports = cell(size(ids));
    
    % Call external function 'wmicGet' to pull in PnP info
    infostruct = wmicGet('Win32_PnPEntity');
    
    names={infostruct.Name};  % roll struct field into cell array for easy searching
    device_ids={infostruct.DeviceID};  % roll struct field into cell array for easy searching
    
    idx = find(contains(names,'Atmel'));   % All devices with "Atmel" in the name field (contains was introduced in Matlab recently)
    
    if isempty(idx)
        return
    end
    
    arduino_names = names(idx);
    arduino_device_ids = device_ids(idx);
    
    for i=1:length(ids)
        % Figure out which line the ID appears on...
        match = strfind(arduino_device_ids,ids{i});
        idx = find(~cellfun(@isempty,match));
        if ~isempty(idx)
            %...and find the corresponding COM port on that line
            com_ports{i} = regexp(arduino_names(idx),'(COM\d+)','match','once');
        end
    end
    
end