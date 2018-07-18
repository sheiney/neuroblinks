function camera = addCam(serialNum, config)
% Create camera object for camera with given serial number

disp('Finding cameras...')

% Get list of configured cameras
%     foundcams = imaqhwinfo('gige');
foundcams = imaqhwinfo(config.CAMADAPTOR);
founddeviceids = cell2mat(foundcams.DeviceIDs); 

if isempty(founddeviceids)
    error('No cameras found')
end

%====== Getting camera ID  =====
match=0;

for i=1:length(founddeviceids)
    camera = videoinput(config.CAMADAPTOR, founddeviceids(i), 'Mono8');
    src = getselectedsource(camera);
    if strcmp(src.DeviceID,serialNum)
        match=1;
        break
    end
    % If we get here the current camera didn't match
    delete(camera)
end

if ~match
    error('The camera you specified (%s) could not be found',serialNum);
end