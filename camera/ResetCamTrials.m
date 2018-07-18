function ResetCamTrials()

metadata=getappdata(0,'metadata');

metadata.cam(1).trialnum=1;

setappdata(0,'metadata',metadata);