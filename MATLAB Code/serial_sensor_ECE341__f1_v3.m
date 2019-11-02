function varargout = serial_sensor_ECE341__f1_v3(varargin)
%SERIAL_SENSOR_ECE341__F1_V3 MATLAB code file for serial_sensor_ECE341__f1_v3.fig
%      SERIAL_SENSOR_ECE341__F1_V3, by itself, creates a new SERIAL_SENSOR_ECE341__F1_V3 or raises the existing
%      singleton*.
%
%      H = SERIAL_SENSOR_ECE341__F1_V3 returns the handle to a new SERIAL_SENSOR_ECE341__F1_V3 or the handle to
%      the existing singleton*.
%
%      SERIAL_SENSOR_ECE341__F1_V3('Property','Value',...) creates a new SERIAL_SENSOR_ECE341__F1_V3 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to serial_sensor_ECE341__f1_v3_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SERIAL_SENSOR_ECE341__F1_V3('CALLBACK') and SERIAL_SENSOR_ECE341__F1_V3('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SERIAL_SENSOR_ECE341__F1_V3.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help serial_sensor_ECE341__f1_v3

% Last Modified by GUIDE v2.5 30-Sep-2017 14:11:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @serial_sensor_ECE341__f1_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @serial_sensor_ECE341__f1_v3_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before serial_sensor_ECE341__f1_v3 is made visible.
function serial_sensor_ECE341__f1_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for serial_sensor_ECE341__f1_v3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

clc
% creates a list of all the avalilble COM ports and makes a list that is
% displayed in the gui
serialPorts = instrhwinfo('serial');
nPorts = length(serialPorts.SerialPorts);
if nPorts > 0
    set(handles.com_port_list, 'String', ...
        [{'Select a port'} ; serialPorts.SerialPorts ]);
    set(handles.com_port_list, 'Value', 2);
    set(handles.com_port_list, 'backgroundcolor', 'white');
else
    set(handles.com_port_list, 'backgroundcolor', [1 0.4 0.4]);
end

% UIWAIT makes serial_sensor_ECE341__f1_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = serial_sensor_ECE341__f1_v3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% gets values from the data fields
sec_to_record = str2double(get(handles.textbox1, 'String'));
data_points_per_sec = str2double(get(handles.textbox2, 'String'));
selected_item = get(handles.com_port_list, 'Value');
list_of_com_ports = get(handles.com_port_list, 'String');
selceted_com_port = cell2mat(list_of_com_ports(selected_item));

% checks to make sure all of the data entered into the textboxes is valid
if sec_to_record > 0 && floor(sec_to_record) == sec_to_record ...
        && data_points_per_sec > 0 && data_points_per_sec <= 25 ...
        && floor(1000/data_points_per_sec) == 1000/data_points_per_sec ...
        && contains(selceted_com_port, 'COM')
    %saves data so it can be used by the next gui to open
    setappdata(0,'sec_to_record_val', sec_to_record);
    setappdata(0,'data_points_per_sec_val', data_points_per_sec);
    setappdata(0,'selceted_com_port_val', selceted_com_port);
    
    close(serial_sensor_ECE341__f1_v3)
    run('serial_sensor_ECE341__f2_v3')
end

% --- Executes on selection change in com_port_list.
function com_port_list_Callback(hObject, eventdata, handles)
% hObject    handle to com_port_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns com_port_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from com_port_list
if get(hObject, 'Value') == 1
   set(hObject, 'backgroundcolor', [1 0.4 0.4])
else
    set(hObject, 'backgroundcolor', 'white')
end


% --- Executes during object creation, after setting all properties.
function com_port_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com_port_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textbox2_Callback(hObject, eventdata, handles)
% hObject    handle to textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox2 as text
%        str2double(get(hObject,'String')) returns contents of textbox2 as a double
val = str2double(get(hObject, 'String'));
if val <= 0 || val > 25 || floor(val) ~= val
   set(hObject, 'backgroundcolor', [1 0.4 0.4])
else
    set(hObject, 'backgroundcolor', 'white')
end


% --- Executes during object creation, after setting all properties.
function textbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textbox1_Callback(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox1 as text
%        str2double(get(hObject,'String')) returns contents of textbox1 as a double
val = str2double(get(hObject, 'String'));
if val <= 0 || floor(val) ~= val
   set(hObject, 'backgroundcolor', [1 0.4 0.4])
else
    set(hObject, 'backgroundcolor', 'white')
end

% --- Executes during object creation, after setting all properties.
function textbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% code to generate a list of all open COM ports
serialPorts = instrhwinfo('serial');
nPorts = length(serialPorts.SerialPorts);
if nPorts > 0
    set(handles.com_port_list, 'String', ...
        [{'Select a port'} ; serialPorts.SerialPorts ]);
    set(handles.com_port_list, 'Value', 2);
    set(handles.com_port_list, 'backgroundcolor', 'white');
else
    set(handles.com_port_list, 'backgroundcolor', [1 0.4 0.4]);
end
