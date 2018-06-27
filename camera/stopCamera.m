function stopCamera(n)

    % NEED TO GENERALIZE TO "N" CAMERAS
vidobj2 = getappdata(0,'vidobj2');

% Stop video object, callback will then execute
stop(vidobj2)