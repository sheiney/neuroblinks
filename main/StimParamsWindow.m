function varargout = StimParamsWindow(varargin)
% STIMPARAMSWINDOW MATLAB code for StimParamsWindow.fig
%      STIMPARAMSWINDOW, by itself, creates a new STIMPARAMSWINDOW or raises the existing
%      singleton*.
%
%      H = STIMPARAMSWINDOW returns the handle to a new STIMPARAMSWINDOW or the handle to
%      the existing singleton*.
%
%      STIMPARAMSWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STIMPARAMSWINDOW.M with the given input arguments.
%
%      STIMPARAMSWINDOW('Property','Value',...) creates a new STIMPARAMSWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StimParamsWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StimParamsWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StimParamsWindow

% Last Modified by GUIDE v2.5 30-Jan-2020 14:30:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StimParamsWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @StimParamsWindow_OutputFcn, ...
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


% --- Executes just before StimParamsWindow is made visible.
function StimParamsWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StimParamsWindow (see VARARGIN)

% Choose default command line output for StimParamsWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StimParamsWindow wait for user response (see UIRESUME)
% uiwait(handles.ParamFig);


% --- Outputs from this function are returned to the command line.
function varargout = StimParamsWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_stim_train_delay_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stim_train_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stim_train_delay as text
%        str2double(get(hObject,'String')) returns contents of edit_stim_train_delay as a double

config = getappdata(0, 'config');
gui = getappdata(0, 'gui');
metadata = getappdata(0, 'metadata');

maingui.handles = guidata(gui.maingui);

value = str2double(get(hObject, 'String'));
if ~isnan(value)
    metadata.stim.(device2fieldname(config.stim.device)).delay = value;
else
    msgbox('Please enter a numeric value');
end

setappdata(0, 'metadata', metadata);
% setappdata(0, 'config', config);

drawnow         % Seems necessary to update appdata before returning to calling function

% --- Executes during object creation, after setting all properties.
function edit_stim_train_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stim_train_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

metadata=getappdata(0,'metadata');
set(hObject,'String',num2str(metadata.stim.(device2fieldname(config.stim.device)).delay));


function edit_stim_pulse_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stim_pulse_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stim_pulse_width as text
%        str2double(get(hObject,'String')) returns contents of edit_stim_pulse_width as a double

config = getappdata(0, 'config');
metadata=getappdata(0,'metadata');

value = str2double(get(hObject, 'String'));
if ~isnan(value)
    metadata.stim.(device2fieldname(config.stim.device)).pulse_width = value;
else
    msgbox('Please enter a numeric value');
end

setappdata(0,'metadata',metadata);

drawnow         % Seems necessary to update appdata before returning to calling function

% --- Executes during object creation, after setting all properties.
function edit_stim_pulse_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stim_pulse_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

metadata=getappdata(0,'metadata');
set(hObject,'String',num2str(metadata.stim.(device2fieldname(config.stim.device)).pulse_width));

% --- Executes on button press in pushbutton_ok.
function pushbutton_ok_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.ParamFig);


% --- Executes on selection change in popupmenu_stim_device.
function popupmenu_stim_device_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_stim_device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_stim_device contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_stim_device

config = getappdata(0, 'config');
metadata=getappdata(0,'metadata');

config.stim.device = handles.popupmenu_stim_device.String(handles.popupmenu_stim_device.Value);
metadata.stim.device = config.stim.device;

setappdata(0,'metadata',metadata);
setappdata(0,'config',config);


% --- Executes during object creation, after setting all properties.
function popupmenu_stim_device_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_stim_device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

config = getappdata(0, 'config');

value = find(strcmp(handles.popupmenu_stim_device.String, config.stim.device));

if value < length(handles.popupmenu_stim_device.String)
    handles.popupmenu_stim_device.Value = value;
else
    handles.popupmenu_stim_device.Value = 1;
end
