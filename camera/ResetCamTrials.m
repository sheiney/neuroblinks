function ResetCamTrials()

metadata=getappdata(0,'metadata');

metadata.cam.trialnum=1;

setappdata(0,'metadata',metadata);