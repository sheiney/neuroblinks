function ok = stopSession(handles)

cameras=getappdata(0,'cameras');
microController=getappdata(0,'microController');

ok = 0;

stopStreaming(handles)
stopPreviewing(cameras);

try
    fclose(microController);
    delete(microController);
    delete(cameras);
    rmappdata(0,'cameras');

    ok = 1;

catch err
    warning(err.identifier,'Problem cleaning up objects. You may need to do it manually.')
end

