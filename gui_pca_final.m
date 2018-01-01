function varargout = gui_pca_final(varargin)
% GUI_PCA_FINAL MATLAB code for gui_pca_final.fig
%      GUI_PCA_FINAL, by itself, creates a new GUI_PCA_FINAL or raises the existing
%      singleton*.

%      H = GUI_PCA_FINAL returns the handle to a new GUI_PCA_FINAL or the handle to
%      the existing singleton*.
%
%      GUI_PCA_FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PCA_FINAL.M with the given input arguments.
%
%      GUI_PCA_FINAL('Property','Value',...) creates a new GUI_PCA_FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_pca_final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_pca_final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_pca_final

% Last Modified by GUIDE v2.5 06-Jan-2017 01:40:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_pca_final_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_pca_final_OutputFcn, ...
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


% --- Executes just before gui_pca_final is made visible.
function gui_pca_final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_pca_final (see VARARGIN)

% Choose default command line output for gui_pca_final

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
files = dir('D:\MAIA France\Image_processing\pcacode\test images\*.jpg');
for x = 1 : length(files)
    handles.images{x} = imread(['D:\MAIA France\Image_processing\pcacode\test images\' files(x).name])
end
set(handles.listbox1,'string',{files.name});

guidata(hObject, handles);
% UIWAIT makes gui_pca_final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_pca_final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
handles.input_index = get(handles.listbox1,'value')
[handles.Accuracy,img_color]=facerecognition(handles.input_index)
color_dir='D:\MAIA France\Image_processing\pcacode\actual_images\';
input_dir=dir('D:\MAIA France\Image_processing\pcacode\test images\*.jpg');
color_name=input_dir(handles.input_index).name
axes(handles.axes1);
imshow([color_dir color_name]);title(['Searching for ' color_name(1:end-5)]);

axes(handles.axes2);
imshow([color_dir img_color]);title(['Found ' img_color(1:end-5)]);
set(handles.edit3, 'String', num2str(handles.Accuracy))
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'xtick',[],'ytick',[])

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(gca,'xtick',[],'ytick',[])

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function Accuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit3, 'String', num2str(handles.Accuracy))
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
