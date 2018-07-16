function stopCamera(n)

    % NEED TO GENERALIZE TO "N" CAMERAS
camera2 = getappdata(0,'camera2');

% Stop video object, callback will then execute
stop(camera2)