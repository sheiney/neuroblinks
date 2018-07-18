function abortCameraAcquisition()

camera = getappdata(0,'camera');
src = getappdata(0,'src');

stop(camera);
flushdata(camera);

src.FrameStartTriggerSource = 'Freerun';