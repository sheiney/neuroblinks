% User data path
config.userdatapath = 'd:\data\behavior\ebc';

% Per user default parameter table (can be overwritten by per mouse config)
config.paramtable.data = ...
    [9,  200,1,200, 20,3,0,0,0,1,10;...
     1,  200,1,200, 0, 3,0,0,0,1,0;...
     ];

config.paramtable.randomize = 1;

config.trialtable = makeTrialTable(config.paramtable.data, config.paramtable.randomize);

% GUI layout
% -- specify the location of bottomleft corner of MainWindow & AnalysisWindow  --
config.pos_mainwindow = [5,50];     
% config.size_mainwindow=[840 600]; 

config.pos_camera2gui = [5,45];     
% config.size_camera2gui=[840 600]; 

config.pos_analysiswindow = [5 45];    
% config.size_analysiswindow=[560 380];   