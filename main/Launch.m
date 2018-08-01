function launch(config)

%% Open GUI
clear MainWindow;    % Need to do this to clear persisent variables defined within MainWindow and subfunctions
gui.maingui = MainWindow;
set(gui.maingui, 'units', 'pixels')
set(gui.maingui, 'position', [config.pos_mainwindow, config.size_mainwindow])

% Open parameter dialog
h = ParamsWindow;
waitfor(h);

% Save structs to root app data
setappdata(0, 'gui', gui)
setappdata(0, 'config', config)