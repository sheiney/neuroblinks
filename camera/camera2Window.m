function varargout = camera2Window(varargin)
% CAMERAWINDOW MATLAB code for cameraWindow.fig
%      CAMERAWINDOW, by itself, creates a new CAMERAWINDOW or raises the existing
%      singleton*.
%
%      H = CAMERAWINDOW returns the handle to a new CAMERAWINDOW or the handle to
%      the existing singleton*.
%
%      CAMERAWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERAWINDOW.M with the given input arguments.
%
%      CAMERAWINDOW('Property','Value',...) creates a new CAMERAWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cameraWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cameraWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cameraWindow

% Last Modified by GUIDE v2.5 01-Aug-2018 12:08:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camera2Window_OpeningFcn, ...
                   'gui_OutputFcn',  @camera2Window_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before camera2Window is made visible.
function camera2Window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camera2Window (see VARARGIN)


% Choose default command line output for camera2Window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camera2Window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = camera2Window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_instantReplay.
function pushbutton_instantReplay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_instantReplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

instantReplay(getappdata(0,'lastvid2'),getappdata(0,'lastmetadata'))

