function launch(config)

%% Open GUI
clear MainWindow;    % Need to do this to clear persisent variables defined within MainWindow and subfunctions
gui.maingui = MainWindow;
set(gui.maingui, 'units', 'pixels')
current_pos = get(gui.maingui, 'position');
set(gui.maingui, 'position', [config.pos_mainwindow{config.rig}, current_pos(3:4)]) % mod 2 because we have 2 rigs per computer/monitor

% Save handle for camera 1 preview axis
gui.cameraAx(1) = findobj(gui.maingui, 'Tag', 'cameraAx1');

% Connect to whitenoise device if using
if ~strcmp(config.WHITENOISE_DEVICE_IDS{config.rig}, '')
    whitenoise_device = connectWhitenoiseDevice(config);
    setappdata(0, 'whitenoise_device', whitenoise_device)
end

% config.running = 1;

% % Open parameter dialog
% h = ParamsWindow;
% waitfor(h);

% Save structs to root app data
setappdata(0, 'gui', gui)
% setappdata(0, 'config', config)

drawnow         % Seems necessary to update appdata before returning to calling function