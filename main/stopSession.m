function ok = stopSession(handles)

cameras=getappdata(0,'cameras');
microController=getappdata(0,'microController');
config=getappdata(0,'config');

ok = 0;

stopStreaming(handles)
stopPreviewing(cameras);

try
    fclose(microController);
%     delete(microController);
    delete(cameras);
%     rmappdata(0,'cameras');

    if config.pulsepal.connected

        EndPulsePal;
        config.pulsepal.connected = 0;
        
    end

    if config.use_open_ephys

        zeroMQrr('CloseThread', config.openephys_url);
        zeroMQrr('CloseAll');

    end

    ok = 1;

catch err
    warning(err.identifier,'Problem cleaning up objects. You may need to do it manually.')
end

setappdata(0, 'config', config)