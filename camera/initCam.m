function initCam(config)

% First delete any existing image acquisition objects
imaqreset

disp('Finding camera...')
 % Get list of configured cameras
foundcams = imaqhwinfo(config.CAMADAPTOR);
founddeviceids = cell2mat(foundcams.DeviceIDs); 

if isempty(founddeviceids)
    error('No cameras found')
end

%====== Getting camera ID  =====
cam = 0;
%     cam = 1;

for i=1:length(founddeviceids)
    vidobj = videoinput(config.CAMADAPTOR, founddeviceids(i), 'Mono8');
    src = getselectedsource(vidobj);
    if strcmp(src.DeviceID,ALLOWEDCAMS{rig})
        cam = i;
    end
    delete(vidobj)
end

if ~cam
    error('The camera you specified (%d) could not be found',rig);
end

disp('Creating video object...')
vidobj = videoinput(config.CAMADAPTOR, channel, 'Mono8');

configureBaslerAce(vidobj, config)

setappdata(0,'vidobj',vidobj)