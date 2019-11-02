function varargout = serial_sensor_ECE341__f2_v3(varargin)
%SERIAL_SENSOR_ECE341__F2_V3 MATLAB code file for serial_sensor_ECE341__f2_v3.fig
%      SERIAL_SENSOR_ECE341__F2_V3, by itself, creates a new SERIAL_SENSOR_ECE341__F2_V3 or raises the existing
%      singleton*.
%
%      H = SERIAL_SENSOR_ECE341__F2_V3 returns the handle to a new SERIAL_SENSOR_ECE341__F2_V3 or the handle to
%      the existing singleton*.
%
%      SERIAL_SENSOR_ECE341__F2_V3('Property','Value',...) creates a new SERIAL_SENSOR_ECE341__F2_V3 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to serial_sensor_ECE341__f2_v3_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SERIAL_SENSOR_ECE341__F2_V3('CALLBACK') and SERIAL_SENSOR_ECE341__F2_V3('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SERIAL_SENSOR_ECE341__F2_V3.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help serial_sensor_ECE341__f2_v3

% Last Modified by GUIDE v2.5 28-Jul-2018 17:24:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @serial_sensor_ECE341__f2_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @serial_sensor_ECE341__f2_v3_OutputFcn, ...
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


% --- Executes just before serial_sensor_ECE341__f2_v3 is made visible.
function serial_sensor_ECE341__f2_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for serial_sensor_ECE341__f2_v3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

clc

% UIWAIT makes serial_sensor_ECE341__f2_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = serial_sensor_ECE341__f2_v3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% gets valuse that were entered in last gui
% sec_to_record = getappdata(0,'sec_to_record_val');
% data_points_per_sec = getappdata(0,'data_points_per_sec_val');
% selceted_com_port = getappdata(0,'selceted_com_port_val');
data_points_per_sec = 10;
sec_to_record = 5;

% finds how many data points are needed to store all of the measurments
num_of_data_points = data_points_per_sec * sec_to_record;
step_size = 1 / data_points_per_sec;

% preallocated a 2d array to store all the data in
% time_index = 1;
light_index = 2;
steinhart_index = 3;
linear_temp_index = 4;
temp_error_index = 5;
raw_data = zeros(5, num_of_data_points + 1);
calc_data = zeros(5, num_of_data_points + 1);
calc_data(1, 1:end) = 0 : step_size : num_of_data_points * step_size;

% sets up the 3 graphs
axes(handles.axes1);
handles.h_light = scatter(raw_data(1, 1 : 1), raw_data(light_index, 1 : 1));
set(handles.h_light, 'Marker', '.');
set(handles.h_light, 'SizeData', 70);
set(handles.h_light,'XDataSource','calc_data');
set(handles.h_light,'YDataSource','calc_data');
title('Light Sensor Data');
xlabel('Time (sec)');
ylabel('Senosor Readings (Lux)');
grid on
legend({'Linear'})

axes(handles.axes2);
hold on
handles.h_temp = scatter(raw_data(1, 1 : 1), raw_data(steinhart_index, 1 : 1));
set(handles.h_temp, 'Marker', '.');
set(handles.h_temp, 'SizeData', 70);
set(handles.h_temp,'XDataSource','calc_data');
set(handles.h_temp,'YDataSource','calc_data');
handles.h_linear_temp = scatter(raw_data(1, 1 : 1), raw_data(linear_temp_index, 1 : 1));
set(handles.h_linear_temp, 'Marker', 'x');
set(handles.h_linear_temp, 'SizeData', 50);
set(handles.h_linear_temp,'XDataSource','calc_data');
set(handles.h_linear_temp,'YDataSource','calc_data');
title('Temp Sensor Data');
xlabel('Time (sec)');
ylabel('Senosor Readings (Celcuis)');
grid on
legend({'Steinhart', 'Linear'})
hold off

axes(handles.axes3);
handles.h_temp_error = scatter(raw_data(1, 1 : 1), raw_data(4, 1 : 1));
set(handles.h_temp_error, 'Marker', '.');
set(handles.h_temp_error, 'SizeData', 70);
set(handles.h_temp_error,'XDataSource','calc_data');
set(handles.h_temp_error,'YDataSource','calc_data');
title('Temp Sensor Error Data');
xlabel('Time (sec)');
ylabel('Difference in Degrees');
grid on
legend({'Difference'})

% measurmets that were taken with a meter to linearize the data
x1_temp = 2.61; % voltage
y1_temp = 22;   % celcius
x2_temp = 4.35; % voltage
y2_temp = 90;   % celcius
slope_temp = (y2_temp - y1_temp) / (x2_temp - x1_temp);

x1_light = 1.96;    % voltage
y1_light = 25;      % lux
x2_light = 4.25;    % voltage
y2_light = 500;     % lux
slope_light = (y2_light - y1_light) / (x2_light - x1_light);

%open the COM port that the avr is connected to
% delete(instrfind);
% serial_1 = serial(selceted_com_port, 'baudrate', 19200);
% fopen(serial_1);
% fwrite(serial_1, data_points_per_sec);
data_points_measured = 0;

handles.output = hObject;
guidata(hObject, handles);

% get measurments from the avr and updates the plots.
% Checking for a min and max value
while data_points_measured <= num_of_data_points
    data_points_measured = data_points_measured + 1;
    
    %plot 1 light
    %raw_data(2, data_points_measured) = str2double(fgetl(serial_1));
    raw_data(light_index, data_points_measured) = rand * 1000;
    light_voltage_reading = ( raw_data(light_index, data_points_measured) / 1023 ) * 5;
    lx_light = (light_voltage_reading - x1_light) * slope_light + y1_light;
    if lx_light < 0
        lx_light = 0;
    end
    calc_data(light_index, data_points_measured) = lx_light;
    set(handles.h_light,'XData', calc_data(1, 1 : data_points_measured), ...
        'YData', calc_data(light_index, 1 : data_points_measured));
    %min
    [min_val, min_index] = min( calc_data(light_index, 1 : data_points_measured) );
    text = sprintf('Min Value: %.02f\nat %0.2f seconds', min_val, ...
        calc_data(1, min_index));
    set(handles.text_1_1, 'String', text);
    %max
    [max_val, max_index] = max( calc_data(light_index, 1 : data_points_measured) );
    text = sprintf('Max Value: %.02f\nat %0.2f seconds', max_val, ...
        calc_data(1, max_index));
    set(handles.text_1_2, 'String', text);
    
    %plot 2 steinhart temp
    %raw_data(3, data_points_measured) = str2double(fgetl(serial_1));
    raw_data(3, data_points_measured) = rand * 1000;
    steinhart = 10000 / raw_data(steinhart_index, data_points_measured);
    steinhart = steinhart / 25;
    steinhart = log10( steinhart );
    steinhart = steinhart / 3950;
    steinhart = steinhart + 1 / (25 + 273.15);
    steinhart = 1 / steinhart;
    steinhart = steinhart - 273.15;
    calc_data(steinhart_index, data_points_measured) = steinhart - 3.5; % -3.5 for calibration
    set(handles.h_temp,'XData', calc_data(1, 1 : data_points_measured), ...
        'YData', calc_data(steinhart_index, 1 : data_points_measured));
    
    %min
    [min_val, min_index] = min( calc_data(steinhart_index, 1 : data_points_measured) );
    text = sprintf('Min Value: %.02f\nat %0.2f seconds', min_val, ...
        calc_data(1, min_index));
    set(handles.text_2_1, 'String', text);
    %max
    [max_val, max_index] = max( calc_data(steinhart_index, 1 : data_points_measured) );
    text = sprintf('Max Value: %.02f\nat %0.2f seconds', max_val, ...
        calc_data(1, max_index));
    set(handles.text_2_2, 'String', text);
    
    %plot 2 linear temp
    data_temp = raw_data(steinhart_index, data_points_measured);
    data_temp = (data_temp / 1023) * 5;
    calc_data(linear_temp_index, data_points_measured) = (data_temp - x1_temp) ...
        * slope_temp + y1_temp;
    set(handles.h_linear_temp,'XData', calc_data(1, 1 : data_points_measured), ...
        'YData', calc_data(linear_temp_index, 1 : data_points_measured));
    
    %min
    [min_val, min_index] = min( calc_data(linear_temp_index, 1 : data_points_measured) );
    text = sprintf('Min Value: %.02f\nat %0.2f seconds', min_val, ...
        calc_data(1, min_index));
    set(handles.text_3_1, 'String', text);
    %max
    [max_val, max_index] = max( calc_data(linear_temp_index, 1 : data_points_measured) );
    text = sprintf('Max Value: %.02f\nat %0.2f seconds', max_val, ...
        calc_data(1, max_index));
    set(handles.text_3_2, 'String', text);
    
    %plot 3 error
    calc_data(temp_error_index, data_points_measured) = ...
        calc_data(linear_temp_index, data_points_measured) ...
        - calc_data(steinhart_index, data_points_measured);
    set(handles.h_temp_error,'XData', calc_data(1, 1 : data_points_measured), ...
        'YData', calc_data(temp_error_index, 1 : data_points_measured));
    %min
    [min_val, min_index] = min( calc_data(temp_error_index, 1 : data_points_measured) );
    text = sprintf('Min Value: %.02f\nat %0.2f seconds', min_val, ...
        calc_data(1, min_index));
    set(handles.text_4_1, 'String', text);
    %max
    [max_val, max_index] = max( calc_data(temp_error_index, 1 : data_points_measured) );
    text = sprintf('Max Value: %.02f\nat %0.2f seconds', max_val, ...
        calc_data(1, max_index));
    set(handles.text_4_2, 'String', text);
    
    drawnow;
end

% close the COM port
% fwrite(serial_1, 0);
% fclose(serial_1);

% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_1.
function checkbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_1_2

if get(hObject, 'Value')
    axes(handles.axes1)
    grid on 
    axes(handles.axes2)
    grid on 
    axes(handles.axes3)
    grid on 
else
    axes(handles.axes1)
    grid off
    axes(handles.axes2)
    grid off
    axes(handles.axes3)
    grid off
end

% --- Executes on button press in checkbox_2.
function checkbox_2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_2

if get(hObject, 'Value')
    axes(handles.axes1)
    legend({'Linear'})
    axes(handles.axes2)
    legend({'Steinhart', 'Linear'})
    axes(handles.axes3)
    legend({'Difference'})
else
    axes(handles.axes1)
    legend('off')
    axes(handles.axes2)
    legend('off')
    axes(handles.axes3)
    legend('off')
end
