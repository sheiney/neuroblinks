% User data path
config.userdatapath = 'd:\data\behavior\ebc';

% Per user default parameter table (can be overwritten by per mouse config)
config.paramtable.data = ...
    [9,  200, 1, 1, 200, 20,3,0,0,0,1,10;...
     1,  200, 1, 1, 200, 0, 3,0,0,0,1,0;...
     ];

config.paramtable.randomize = 1;

config.trialtable = makeTrialTable(config.paramtable.data, config.paramtable.randomize);

% GUI layout

screensize = get(0,'ScreenSize');
config.screenx = screensize(3);
config.screeny = screensize(4);

% -- specify the location of bottomleft corner of MainWindow & AnalysisWindow  --
config.pos_mainwindow = [5,50];     
% config.size_mainwindow=[840 600]; 

config.pos_camera2gui = [850, 345]; % [849 344 524 303]    
% config.size_camera2gui=[840 600]; 

config.pos_analysiswindow = [850 50];    
% config.size_analysiswindow=[560 380];   

% Corresponds to checkbox on GUI for verbose reporting of log
config.verbose = 1;

config.use_encoder = 0;
config.use_pressure_sensor = 0;