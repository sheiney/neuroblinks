function launch(config)

%% Open GUI
clear MainWindow;    % Need to do this to clear persisent variables defined within MainWindow and subfunctions
gui.maingui = MainWindow;
set(gui.maingui, 'units', 'pixels')
current_pos = get(gui.maingui, 'position');
set(gui.maingui, 'position', [config.pos_mainwindow, current_pos(3:4)])

% Save handle for camera 1 preview axis
gui.cameraAx(1) = findobj(gui.maingui, 'Tag', 'cameraAx1');

gui.camera2gui = Camera2Window;
set(gui.camera2gui, 'units', 'pixels')
current_pos = get(gui.camera2gui, 'position');
set(gui.camera2gui, 'position', [config.pos_camera2gui, current_pos(3:4)])

% Save handle for camera 2 preview axis
gui.cameraAx(2) = findobj(gui.camera2gui, 'Tag', 'cameraAx2');

% % Open parameter dialog
% h = ParamsWindow;
% waitfor(h);

% Save structs to root app data
setappdata(0, 'gui', gui)

drawnow         % Seems necessary to update appdata before returning to calling function