function varargout = PATTERN_PROJECT(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PATTERN_PROJECT_OpeningFcn, ...
                   'gui_OutputFcn',  @PATTERN_PROJECT_OutputFcn, ...
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


% --- Executes just before PATTERN_PROJECT is made visible.
function PATTERN_PROJECT_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = PATTERN_PROJECT_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TrainDatabasePath = uigetdir(strcat(matlabroot,'\work'), 'Select training database path' );
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname]=uigetfile('*.jpg','Select An Image');
TestImage = strcat(pathname,filename);
im = imread(TestImage);

x=get(handles.uipanel1,'SelectedObject');
y=get(x,'string');
switch y
    case 'PCA'
        recognized_img=facerecog(handles.TrainDatabasePath,TestImage);
    case 'FLD'
        T = CreateDatabase(handles.TrainDatabasePath);
        [m V_PCA, V_Fisher, ProjectedImages_Fisher] = FisherfaceCore(T);
        recognized_img = Recognition(TestImage, m, V_PCA, V_Fisher, ProjectedImages_Fisher);
end


selected_img = strcat(handles.TrainDatabasePath,'\',recognized_img);
select_img = imread(selected_img);
imshow(im);
axes(handles.axes1);
imshow(select_img);
axes(handles.axes2);
