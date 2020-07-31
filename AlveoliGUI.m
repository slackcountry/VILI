function varargout = AlveoliGUI(varargin)
% ALVEOLIGUI MATLAB code for AlveoliGUI.fig

% Last Modified by GUIDE v2.5 01-Jul-2020 23:27:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlveoliGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @AlveoliGUI_OutputFcn, ...
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
%%%%%% End initialization code - DO NOT EDIT   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes just before AlveoliGUI is made visible.
function AlveoliGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlveoliGUI (see VARARGIN)



% Choose default command line output for AlveoliGUI
handles.output = hObject;

% Define the key press fcn to control axes1 rotation
handles.figure1.WindowButtonDownFcn = @KeyFcnA;
% handles.axes1.ButtonDownFcn = @KeyFcnA;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AlveoliGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function KeyFcnA(src,evnt)
% src   returns the figure being changed, named AlveoliGUI
% evnt  returns KeyData with Key and Modifier
handles = guidata(src);   % Move the src data to handles for modding dims
rotate3d
guidata(src,handles);

function KeyFcnB(src,evnt)
% src   returns the figure being changed, named AlveoliGUI
% evnt  returns KeyData with Key and Modifier
handles = guidata(src);   % Move the src data to handles for modding dims

guidata(src,handles);

% --- Outputs from this function are returned to the command line.
function varargout = AlveoliGUI_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;
cla
%set rotation slider bar min and max
handles.alphaMin.String = -90;
handles.alphaMax.String = 90;
handles.betaMin.String = -90;
handles.betaMax.String = 90;
handles.gammaMin.String = -90;
handles.gammaMax.String = 90;

handles.slider4.Value = 0;
handles.slider4.Min =  -90; %get from dialog boxes
handles.slider4.Max = 90;

handles.slider5.Value = 0;
handles.slider5.Min =  -90; %get from dialog boxes
handles.slider5.Max = 90;

handles.slider6.Value = 0;
handles.slider6.Min =  -90; %get from dialog boxes
handles.slider6.Max = 90;

% sets defaults to zero for initialization
handles.aT.String = num2str(handles.slider4.Value);
handles.bT.String = num2str(handles.slider5.Value);
handles.gT.String = num2str(handles.slider6.Value);

% Set Scale Default
handles.xyScale.Value = 5;
handles.xyScale.String = handles.xyScale.Value;
handles.zScale.Value = 5;
handles.zScale.String = handles.zScale.Value;

handles.savedEdit.Value = 0;
handles.savedEdit.String = handles.savedEdit.Value;

handles.normDirection = 0;  % initialize standard normal direction upwards
guidata(hObject, handles);

% Create and handle factor size inputs
function xyScale_Callback(hObject, eventdata, handles)

whichScale = 'xyScale';
str = get(hObject,'String');
val = str2num(char(str));
if ~isempty(val)
    if (val >= 1) && (val <= 1000)
        handles.(whichScale).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichScale).Value));
    end
else
    set(hObject,'String',num2str(handles.(whichScale).Value));
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xyScale_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zScale_Callback(hObject, eventdata, handles)

whichScale = 'zScale';
str = get(hObject,'String');
val = str2num(char(str));
if ~isempty(val)
    if (val >= 1) && (val <= 1000)
        handles.(whichScale).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichScale).Value));
    end
else
    set(hObject,'String',num2str(handles.(whichScale).Value));
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function zScale_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%%%%%%%%%%%%%%    PLANE   and SEED  SLIDERS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function planeDim_Callback(hObject, eventdata, handles)  

% --- Executes during object creation, after setting all properties.
function planeDim_CreateFcn(hObject, eventdata, handles)    

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

%  set(handles.slider1, 'Max',100);
%  set(handles.slider1, 'Min', 1);
%  set(handles.slider1, 'SliderStep' , [1,1] );
%%%set the initial conditions of the slider
hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.xT.String = num2str(handles.slider1.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.yT.String = num2str(handles.slider2.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.zT.String = num2str(handles.slider3.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.aT.String = num2str(handles.slider4.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.bT.String = num2str(handles.slider5.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(hObject.Max-hObject.Min);
hObject.SliderStep(2) = 5/(hObject.Max-hObject.Min);
hObject.Value = round(hObject.Value);
handles.gT.String = num2str(handles.slider6.Value);
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%%%%   SUBPLOT RANGE EDIT     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edit2_Callback(hObject, eventdata, handles)    %%%%  X Size

x = eval(get(handles.edit2,'String'));
if ~isempty(x)
    if (min(x) >= 1) && (max(x) <= size(handles.V,1))        % /handles.xyScale.Value
        handles.x = x;
    else
        set(hObject,'String','OutOfBnds')
    end
else
    set(hObject,'String','Error')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)    %%% Y Size

y = eval(get(handles.edit3,'String'));
if ~isempty(y)
    if (min(y) >= 1) && (max(y) <= size(handles.V,2))
        handles.y = y;
    else
        set(hObject,'String','OutOfBnds')
    end
else
    set(hObject,'String','Error')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)   %%% Z Size

z = eval(get(handles.edit4,'String'));
if ~isempty(z)
    if (min(z) >= 1) && (max(z) <= size(handles.V,3))
        handles.z = z;
    else
        set(hObject,'String','OutOfBnds')
    end
else
    set(hObject,'String','Error')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%     SLIDER EDITS    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xT_Callback(hObject, eventdata, handles)

whichSlider = 'slider1';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function yT_Callback(hObject, eventdata, handles)

whichSlider = 'slider2';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function yT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zT_Callback(hObject, eventdata, handles)

whichSlider = 'slider3';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function zT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gT_Callback(hObject, eventdata, handles)


whichSlider = 'slider6';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= -90) && (val <= 90)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end

handles = updatePlane(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function gT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function aT_Callback(hObject, eventdata, handles)

whichSlider = 'slider4';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= -90) && (val <= 90)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end

handles = updatePlane(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function aT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bT_Callback(hObject, eventdata, handles)
whichSlider = 'slider5';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= -90) && (val <= 90)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end

handles = updatePlane(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bT_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function alphaMin_CreateFcn(hObject, eventdata, handles)


%%%%%%%%%%%    SEED CALLBACKS AND FUNCTION    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in seedButton. Place the seed in hAx
function seedButton_Callback(hObject, eventdata, handles)

handles = updateSeed(handles);
guidata(hObject, handles);


% --- Executes on slider movement.
function seedZ_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(handles.seedZ.Max-handles.seedZ.Min);
hObject.SliderStep(2) = 5/(handles.seedZ.Max-handles.seedZ.Min);
handles.seedZ.Value = round(handles.seedZ.Value);
handles.editSeedZ.String = num2str(handles.seedZ.Value);
handles = updateSeed(handles);

% --- Executes during object creation, after setting all properties.
function seedZ_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function seedX_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(handles.seedX.Max-handles.seedX.Min);
hObject.SliderStep(2) = 5/(handles.seedX.Max-handles.seedX.Min);
handles.seedX.Value = round(handles.seedX.Value);
handles.editSeedX.String = num2str(handles.seedX.Value);
handles = updateSeed(handles);

% --- Executes during object creation, after setting all properties.
function seedX_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function seedY_Callback(hObject, eventdata, handles)

hObject.SliderStep(1) = 1/(handles.seedY.Max-handles.seedY.Min);
hObject.SliderStep(2) = 5/(handles.seedY.Max-handles.seedY.Min);
handles.seedY.Value = round(handles.seedY.Value);
handles.editSeedY.String = num2str(handles.seedY.Value);
handles = updateSeed(handles);

% --- Executes during object creation, after setting all properties.
function seedY_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function editSeedX_Callback(hObject, eventdata, handles)

whichSlider = 'seedX';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
handles = updateSeed(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editSeedX_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editSeedY_Callback(hObject, eventdata, handles)

whichSlider = 'seedY';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
handles = updateSeed(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editSeedY_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editSeedZ_Callback(hObject, eventdata, handles)

whichSlider = 'seedZ';
str = get(hObject,'String');
val = str2num(str);
if ~isempty(val)
    if (val >= handles.(whichSlider).Min) && (val <= handles.(whichSlider).Max)
        handles.(whichSlider).Value = val;
    else
        set(hObject,'String',num2str(handles.(whichSlider).Value))
    end
else
    set(hObject,'String',num2str(handles.(whichSlider).Value))
end
handles = updatePlane(handles);
handles = updateSeed(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editSeedZ_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%  Function to update the Seed location in hAx
function handles = updateSeed(handles)
delete(findobj('Tag','seed'));
hold(handles.hAx, 'on');
handles.patches.seed = plot3(handles.hAx,handles.seedX.Value,handles.seedY.Value,handles.seedZ.Value,'ko');         % plot a dot for target testing
handles.patches.seed.Tag = 'seed';
handles.patches.seed.Color = [1 0 0];
handles.patches.seed.MarkerSize = 10;
handles.patches.seed.Marker = '*';
handles.patches.seed.LineWidth = 2;

%create a function to avoid errors if axes1 is handled before plot imported
function axes1_ButtonDownFcn(hObject,eventdata,guidata)
rotate3d on;







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %%%%%%%%%% IMPORT FILE and PLOT    %%%%%%%%%%%%
% --- Executes on button press in selectButton.
function selectButton_Callback(hObject, eventdata, handles)

gca
cla

%get info of current working folder, make it the default location for
%uigetfile, to find segmentations to open
fileInfo = dir;

%File Reader 3D - User select a 3D binary file in format .mha, .vtk, .nii & more
[file,path] = uigetfile({'*.*'},'File Selector','fileInfo.folder');
handles.segFilename = [path file];

[handles.V,handles.info] = ReadData3D(handles.segFilename);
%save bounds
handles.boundsX = [1 length(handles.V(:,1,1))];
handles.boundsY = [1 length(handles.V(1,:,1))];
handles.boundsZ = [1 length(handles.V(1,1,:))];

display('File selected');
display(handles.info);

%set the edit boxes to include the entire region
handles.edit2.String = ['1:' num2str(length(handles.V(:,1,1)))];
handles.edit3.String = ['1:' num2str(length(handles.V(1,:,1)))];
handles.edit4.String = ['1:' num2str(length(handles.V(1,1,:)))];


% Display a simplified version of the whole volume
% Calculate data for PLOT axes1
handles.factor = [handles.xyScale.Value handles.xyScale.Value handles.zScale.Value];
handles.nV = reducevolume(handles.V,handles.factor);       %reduce the volume to make simple display quickly [reducing factors]
   %Reducevolume function switches the x and y
   %axes for some reason.
handles.nV = permute(handles.nV,[2 1 3]);
nsf = isosurface(handles.nV,0.5);       
handles.nsf = reducepatch(nsf, 0.8);          %find the reduced patch to display quickly

% Volume was reduced by factor, so expand size by factor to regain original
% size
handles.nsf.vertices(:,1) = handles.nsf.vertices(:,1)*handles.factor(1);
handles.nsf.vertices(:,2) = handles.nsf.vertices(:,2)*handles.factor(1);
handles.nsf.vertices(:,3) = handles.nsf.vertices(:,3)*handles.factor(3);

handles.patches.tissue = patch(handles.nsf);    %Create the Patch in axis1 for the reduced surface patches

handles.patches.tissue.FaceColor =  'magenta';
handles.patches.tissue.EdgeColor = 'r';
handles.patches.tissue.EdgeAlpha = .5;
lightangle(90,-60);
lightangle(270,-60);
lightangle(0,90);
lighting gouraud;


%Set up Axes1
grid(handles.axes1,'on');
axis equal         %'Square' didn't really help by expanding z
% handles.axes1.PlotBoxAspectRatio = [1 1 1]; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% set aspect for thin section
handles.axes1.CameraPosition = [40 20 350];


%%%%% Set axes of the GUI PLOT. Beginning and end defined by file size 
handles.axes1.XLim = handles.boundsX;
handles.axes1.YLim = handles.boundsY;
handles.axes1.ZLim = handles.boundsZ;
handles.axes1.XLabel.String = 'X';
handles.axes1.YLabel.String = 'Y';
handles.axes1.ZLabel.String = 'Z';
handles.axes1.XMinorTick = 'on';
handles.axes1.YMinorTick = 'on';


%Display Segmentation size in text boxes under File Dimensions
handles.text12.String = handles.info.Dimensions(1); 
handles.text13.String = handles.info.Dimensions(2); 
handles.text14.String = handles.info.Dimensions(3); 

guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%% SUB PLOT   %%%%%%%%%%%%%%%%%%%
% --- Executes on button press in SubplotButton.
function SubplotButton_Callback(hObject, eventdata, handles)
% hObject    handle to SubplotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(findobj('type', 'patch','Tag','sub')); %clear any previous subplots
handles.x = eval(get(handles.edit2,'String'));
handles.y = eval(get(handles.edit3,'String'));
handles.z = eval(get(handles.edit4,'String'));

x1 = [min(handles.x) max(handles.x) max(handles.x) min(handles.x)];
y1 = [min(handles.y) min(handles.y) max(handles.y) max(handles.y)];
z1 = [min(handles.z) min(handles.z) min(handles.z) min(handles.z)];
handles.patches.sub = patch(handles.axes1,x1,y1,z1,'b','FaceAlpha',.2);
handles.patches.sub.Tag = 'sub';
x2 = [min(handles.x) max(handles.x) max(handles.x) min(handles.x)];
y2 = [min(handles.y) min(handles.y) min(handles.y) min(handles.y)];
z2 = [min(handles.z) min(handles.z) max(handles.z) max(handles.z)];
handles.patches.sub = patch(handles.axes1,x2,y2,z2,'b','FaceAlpha',.2);
handles.patches.sub.Tag = 'sub';
x3 = [max(handles.x) max(handles.x) max(handles.x) max(handles.x)];
y3 = [min(handles.y) min(handles.y) max(handles.y) max(handles.y)];
z3 = [min(handles.z) max(handles.z) max(handles.z) min(handles.z)];
handles.patches.sub = patch(handles.axes1,x3,y3,z3,'b','FaceAlpha',.2);
handles.patches.sub.Tag = 'sub';
guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              %%%%%%%%%%%%%%%    PLOT    %%%%%%%%%%%%%%%%%%
% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)

% clear handles.vTmp if it already exists, because the user is plotting a
% new subplot area
if isfield(handles,'vTmp') == 1
    handles = rmfield(handles,"vTmp");   %remove existing subplot patches
end
% put load file operation here, loading patch alveoli patches, but not
% handles.vTmp (to plot new area)
fileInfo = dir;
[handles.savePath] = uigetdir('fileInfo.folder','Select Alveoli Load Source');

cd(eval('handles.savePath'))     % Change the working directory to save folder
if isempty(dir('*.mat'));
    disp('No alveoli in load file');
else
listing = dir('Alv*.mat');     %list the file contents of only Alv files
handles.savedEdit.Value = length(listing); % set counter to number of counted alv in directory 
handles.savedEdit.String = handles.savedEdit.Value;

load(listing(end).name);  %load all the patches stored in handles.pat from last file
handles.pat = pat;
end


handles.subplotFig = figure(2);

handles.hAx = axes(handles.subplotFig);
handles.hAx.CameraPosition = [40 20 350];
clf(handles.hAx)

%Take in user data to define segmentation boundary
% run again in case user does not select subplot
handles.x = eval(get(handles.edit2,'String'));
handles.y = eval(get(handles.edit3,'String'));
handles.z = eval(get(handles.edit4,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Begin creating the SUBPLOT  
%Define the indices. Beginning and end defined by subplot and reduced by factor
% Here the increased sampling resolution in x and y is reduced to match
% that of the z resolution. This smooths the alveoli for interpolation

% Display plot at lower resolution for speed
xInds(1) = 1 + (handles.x(1)-1);
tmpEnd = 1 + (handles.x(end) -1);
handles.xInds = xInds(1):handles.factor(1):tmpEnd;
% replace step with factor
yInds(1) = 1 + (handles.y(1) -1);
tmpEnd = 1 + (handles.y(end) -1);
handles.yInds = yInds(1):handles.factor(1):tmpEnd;

zInds(1) = 1 + (handles.z(1) -1);
tmpEnd = 1 + (handles.z(end) -1);
handles.zInds = zInds(1):handles.factor(3):tmpEnd;

% Error handling if user defines area larger than input
[m,n,o] = size(handles.V);
handles.xInds(handles.xInds > m) = []; handles.xInds(handles.xInds < 1) = [];
handles.yInds(handles.yInds > n) = []; handles.yInds(handles.yInds < 1) = [];
handles.zInds(handles.zInds > o) = []; handles.zInds(handles.zInds < 1) = [];
%%% else, scaling could be handles.x, meaning unreduced

% Create an isosurface subplot of original data with reduced indices for
% speedy plotting
[Yq,Xq,Zq] = meshgrid(handles.xInds,handles.yInds,handles.zInds);    % create an updated meshgrid of query locations
handles.vReduced = interp3(handles.V,Xq,Yq,Zq,'cubic');   %find the interpolated V matrix at query locations
handles.fvSub = isosurface(Yq,Xq,Zq,handles.vReduced);  %% notice that V(y,x,z) avoids dim mismatch 
handles.patches.subtissue = patch(handles.fvSub);
axis equal
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modify the subplot UI
% axis(handles.hAx,[handles.xInds(1) handles.xInds(end) handles.yInds(1) handles.yInds(end) handles.zInds(1) handles.zInds(end)]);
set(handles.hAx,'XMinorTick','on');
set(handles.hAx,'YMinorTick','on');

handles.subplotFig.Name = 'Subvolume Plot';

grid(handles.hAx,'on');
handles.hAx.XLabel.String = 'X';
handles.hAx.YLabel.String = 'Y';
handles.hAx.ZLabel.String = 'Z';

% Lighting - 3 lights from orthagonal angles
lightangle(90,-60);
lightangle(270,-60);
lightangle(90,90);
lightangle(70,70);

% handles.patches.subtissue.LineWidth = 0.01;
% handles.patches.subtissue.EdgeColor = [.5 .5 0];
h = handles.patches.subtissue;
h.FaceColor =  'yellow';
h.EdgeColor = 'none';
h.BackFaceLighting = 'reverselit';
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.2;
h.DiffuseStrength = 0.5;   % reflected brightness
h.SpecularStrength = 0.8;
h.SpecularExponent = 25;
h.SpecularColorReflectance = 0.5;
% h.BackFaceLighting = 'unlit';
% h.LineStyle = '-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update sliders to match subsegment. Subplot size determines min and max
handles.slider1.Max = handles.x(end);
handles.slider1.Value = xInds(1);
handles.slider1.Min =  xInds(1); %get from dialog boxes

handles.slider2.Max = handles.y(end);
handles.slider2.Value = yInds(1);
handles.slider2.Min =  yInds(1); %get from dialog boxes

handles.slider3.Max = handles.z(end);
handles.slider3.Value = zInds(1);
handles.slider3.Min =  zInds(1); %get from dialog boxes

% %set the corresponding Slider text boxes
handles.xT.String = num2str(handles.slider1.Value);
handles.yT.String = num2str(handles.slider2.Value);
handles.zT.String = num2str(handles.slider3.Value);
handles.gT.String = num2str(handles.slider6.Value);

handles.text17.String = num2str(handles.slider1.Min);
handles.text18.String = num2str(handles.slider2.Min);
handles.text19.String = num2str(handles.slider3.Min);
handles.gammaMin.String = num2str(handles.slider6.Min);

handles.text21.String = num2str(handles.slider1.Max);
handles.text22.String = num2str(handles.slider2.Max);
handles.text23.String = num2str(handles.slider3.Max);
handles.gammaMax.String = num2str(handles.slider6.Max);

%%%%%%%%% Initialize the seed sliders with proper values %%%%%%%%%%%%%%%%%
handles.seedX.Max = handles.slider1.Max;
handles.seedX.Value = handles.slider1.Value;
handles.seedX.Min = handles.slider1.Min;
handles.xMin.String = num2str(handles.seedX.Min);
handles.xMax.String = num2str(handles.seedX.Max);

handles.seedY.Max = handles.slider2.Max;
handles.seedY.Value = handles.slider2.Value;
handles.seedY.Min =  handles.slider2.Min; %get from dialog boxes
handles.yMin.String = num2str(handles.seedY.Min);
handles.yMax.String = num2str(handles.seedY.Max);

handles.seedZ.Max = handles.slider3.Max;
handles.seedZ.Value = handles.slider3.Value;
handles.seedZ.Min =  handles.slider3.Min; %get from dialog boxes
handles.zMin.String = num2str(handles.seedZ.Min);
handles.zMax.String = num2str(handles.seedZ.Max);

handles.editSeedX.String = num2str(handles.seedX.Value);
handles.editSeedY.String = num2str(handles.seedY.Value);
handles.editSeedZ.String = num2str(handles.seedZ.Value);

% check to see if past measured patches are close enough to plot
if isfield(handles,'pat') == 1   % check is patch has been created before
    for i = 1:length(handles.pat)
        if isempty(handles.pat(i).vertices)
            continue
        end
        a = {handles.pat.initPos};  %create a cell structure to index initial positions
        b = a{1,i}; 
        disxMin = handles.slider1.Min - b(1);  % see if initial position is within 100 of subplot
        disyMin = handles.slider2.Min - b(2);
        diszMin = handles.slider3.Min - b(3);

        disxMax = handles.slider1.Max - b(1);  % see if initial position is within 100 of subplot
        disyMax = handles.slider2.Max - b(2);
        diszMax = handles.slider3.Max - b(3);


        if disxMin <= 100 && disyMin <=100 && diszMin <= 150 && disxMax >= -100 && disyMax >= -100 && diszMax >= -150
            f = handles.pat(i).faces;
            v = handles.pat(i).vertices;
            c = handles.pat(i).EdgeColor;
            patch('Faces',f,'Vertices',v,'EdgeColor',c,'facealpha',0.4);
        end
    end
end
guidata(hObject, handles);



%%%%%%%%%%%%%%%   PLANE CREATION    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press to create a plane
function planeButton_Callback(hObject, eventdata, handles)

handles = updatePlane(handles);     % use updatePlane function when button is pushed

handles.subplotFig.KeyPressFcn = @keyPress;   % initiate button control of plane

guidata(figure(2),handles);    % store guidata in figure 2 / subplot
   
function keyPress(h,e);
handles = guidata(h);    % guidata is stored in h
switch e.Key
    
    case 'rightarrow'
        planeButton_Callback(handles.planeButton,[],handles);
        %%%% X Increment
        if  isempty(e.Modifier) && (handles.slider1.Value < handles.slider1.Max)
            handles.slider1.Value = round(handles.slider1.Value) + 5;
            handles.xT.String = num2str(handles.slider1.Value);
            handles = updatePlane(handles);
        elseif isempty(e.Modifier) && (handles.slider1.Value == handles.slider1.Max)
            return
        %%%% Alpha Increment
        elseif strcmp(e.Modifier{:},'control') && (handles.slider4.Value < handles.slider4.Max)
            handles.slider4.Value = round(handles.slider4.Value) + 5;
            handles.aT.String = num2str(handles.slider4.Value);
            handles = updatePlane(handles);
        end
    case 'leftarrow'
        planeButton_Callback(handles.planeButton,[],handles);
        %%%% X Decrement
        if isempty(e.Modifier) && (handles.slider1.Value > handles.slider1.Min)
            handles.slider1.Value = round(handles.slider1.Value) - 5;
            handles.xT.String = num2str(handles.slider1.Value);
            handles = updatePlane(handles);
        elseif isempty(e.Modifier) && (handles.slider1.Value == handles.slider1.Min)
            return
        %%%% Alpha decrement
        elseif strcmp(e.Modifier{:},'control') && (handles.slider4.Value > handles.slider4.Min)
            handles.slider4.Value = round(handles.slider4.Value) - 5;
            handles.aT.String = num2str(handles.slider4.Value);
            handles = updatePlane(handles);
        end
        

    case 'uparrow'     % up Y transpose. z up with 'shift' hold. beta up with 'ctl'
        planeButton_Callback(handles.planeButton,[],handles);
        if isempty(e.Modifier) && (handles.slider2.Value < handles.slider2.Max) %eveluate use of modifier, and error handle min/max
            handles.slider2.Value = round(handles.slider2.Value) + 5;       %update slider value
            handles.yT.String = num2str(handles.slider2.Value);             %update slider string
            handles = updatePlane(handles);                                 %update plane location
        elseif isempty(e.Modifier) && (handles.slider2.Value == handles.slider2.Max)
            return
        elseif strcmp(e.Modifier{:},'shift') && (handles.slider3.Value < handles.slider3.Max)
            handles.slider3.Value = round(handles.slider3.Value) + 5;
            handles.zT.String = num2str(handles.slider3.Value);
            handles = updatePlane(handles);
        elseif strcmp(e.Modifier{:},'control') && (handles.slider5.Value < handles.slider5.Max)
            handles.slider5.Value = round(handles.slider5.Value) + 5;
            handles.bT.String = num2str(handles.slider5.Value);
            handles = updatePlane(handles);
        end
        
        
    case 'downarrow'  % down Y, down Z with 'shift', down beta with 'ctl'
        planeButton_Callback(handles.planeButton,[],handles);
        if isempty(e.Modifier) && (handles.slider2.Value > handles.slider2.Min)
            handles.slider2.Value = round(handles.slider2.Value) - 5;
            handles.yT.String = num2str(handles.slider2.Value);
            handles = updatePlane(handles);
        elseif isempty(e.Modifier) && (handles.slider2.Value == handles.slider2.Min)
            return
        elseif strcmp(e.Modifier{:},'shift') && (handles.slider3.Value > handles.slider3.Min)
            handles.slider3.Value = round(handles.slider3.Value) - 5;
            handles.zT.String = num2str(handles.slider3.Value);
            handles = updatePlane(handles);
        elseif strcmp(e.Modifier{:},'control') && (handles.slider5.Value > handles.slider5.Min)
            handles.slider5.Value = round(handles.slider5.Value) - 5;
            handles.bT.String = num2str(handles.slider5.Value);
            handles = updatePlane(handles);
        end
        
%     case 'd'    % Seed X increment
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedX.Value < handles.seedX.Max)
%             handles.seedX.Value = round(handles.seedX.Value) + 5;
%             handles.editSeedX.String = num2str(handles.seedX.Value);
%             handles = updateSeed(handles);
%         end   
%     case 'a'    % Seed X decrement
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedX.Value > handles.seedX.Min)
%             handles.seedX.Value = round(handles.seedX.Value) - 5;
%             handles.editSeedX.String = num2str(handles.seedX.Value);
%             handles = updateSeed(handles);
%         end
%     case 'e'    % Seed Z increment
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedZ.Value < handles.seedZ.Max)
%             handles.seedZ.Value = round(handles.seedZ.Value) + 5;
%             handles.editSeedZ.String = num2str(handles.seedZ.Value);
%             handles = updateSeed(handles);
%         end  
%     case 'q'    % Seed Z decrement
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedZ.Value > handles.seedZ.Min)
%             handles.seedZ.Value = round(handles.seedZ.Value) - 5;
%             handles.editSeedZ.String = num2str(handles.seedZ.Value);
%             handles = updateSeed(handles);
%         end
%     case 'w'    % Seed Y increment
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedY.Value < handles.seedY.Max)
%             handles.seedY.Value = round(handles.seedY.Value) + 5;
%             handles.editSeedY.String = num2str(handles.seedY.Value);
%             handles = updateSeed(handles);
%         end
%     case 's'    % Seed Y decrement
%         planeButton_Callback(handles.planeButton,[],handles);
%         if (handles.seedY.Value > handles.seedY.Min)
%             handles.seedY.Value = round(handles.seedY.Value) - 5;
%             handles.editSeedY.String = num2str(handles.seedY.Value);
%             handles = updateSeed(handles);
%         end
        
    case 'r'  % enable rotation when r selected
        rotate3d;
        handles.subplotFig.KeyPressFcn = @keyPress;
    case 'a'  % move x lim when rotate selected
        handles.subplotFig.Children.View(1) = handles.subplotFig.Children.View(1) + 5;
    case 'd'  % move x lim when rotate selected
        handles.subplotFig.Children.View(1) = handles.subplotFig.Children.View(1) - 5;    
    case 'w'  % move x lim when rotate selected
        handles.subplotFig.Children.View(2) = handles.subplotFig.Children.View(2) + 5;
    case 's'  % move x lim when rotate selected
        handles.subplotFig.Children.View(2) = handles.subplotFig.Children.View(2) - 5;  
    
        % movement of the XYZ limits
    case 'u'
        handles.subplotFig.Children.XLim = handles.subplotFig.Children.XLim - 5;
    case 'i'
        handles.subplotFig.Children.XLim = handles.subplotFig.Children.XLim + 5;
    case 'j'
        handles.subplotFig.Children.YLim = handles.subplotFig.Children.YLim - 5;
    case 'k'
        handles.subplotFig.Children.YLim = handles.subplotFig.Children.YLim + 5;
    case 'n'
        handles.subplotFig.Children.ZLim = handles.subplotFig.Children.ZLim - 5;
    case 'm'
        handles.subplotFig.Children.ZLim = handles.subplotFig.Children.ZLim + 5;
        
        
end

% This function will plot a new plane as sliders are adjusted
function handles = updatePlane(handles)
delete(findobj('type', 'patch','Tag','plane'));   % Delete old plane position
delete(findobj('type', 'Quiver','Tag','planeArrow'));   % Delete old arrow position

len = str2double(get(handles.planeDim,'String'));    % length vector for plane dims

%transpose factors - center of plane
xTrans = handles.slider1.Value;
yTrans = handles.slider2.Value;
zTrans = handles.slider3.Value;
alpha = handles.slider4.Value;  %roration around x (in degrees)
beta = handles.slider5.Value;  %rotation around y 
gamma = handles.slider6.Value;  %rotation around z 

%Make a plane
X = [-len len len -len];
Y = [-len -len len len];
Z = [0 0 0 0 ];

% Transpose Matrix
RX = [1 0 0
    0 cosd(alpha) -sind(alpha)
    0 sind(alpha) cosd(alpha)];

RY = [cosd(beta) 0 sind(beta)
    0 1 0
    -sind(beta) 0 cosd(beta)];

RZ = [cosd(gamma) -sind(gamma) 0
    sind(gamma) cosd(gamma) 0
    0 0 1];

R = RZ*RY*RX;
% R = RX*RY*RZ;

v1 = [X(1) Y(1) Z(1)];
v2 = [X(2) Y(2) Z(2)];
v3 = [X(3) Y(3) Z(3)];
v4 = [X(4) Y(4) Z(4)];

v1T = v1*R;
v2T = v2*R;
v3T = v3*R;
v4T = v4*R;

% Rotated matrix
Xt = [v1T(1) v2T(1) v3T(1) v4T(1)];
Yt = [v1T(2) v2T(2) v3T(2) v4T(2)];
Zt = [v1T(3) v2T(3) v3T(3) v4T(3)];

% patch(Xt,Yt,Zt,'r')                
% Plot plane transposed and transformed
handles.X = Xt + xTrans;
handles.Y = Yt + yTrans;
handles.Z = Zt + zTrans;
hold on
handles.patches.plane = patch(handles.hAx,handles.X,handles.Y,handles.Z,'b');            %plot a transposed plane
handles.patches.plane.Tag = 'plane';

%Calculate start and normal for arrow
start = [handles.slider1.Value handles.slider2.Value handles.slider3.Value];
pM.Faces = [2 3 4; 2 4 1; 5 6 7; 5 7 8; 5 6 2; 5 1 2; 6 7 3; 6 2 3; 7 3 4; 7 8 4;
    8 4 1; 8 5 1];
% the vertices of this box
pM.Vertices = [handles.X(1) handles.Y(1) handles.Z(1); handles.X(2) handles.Y(2) handles.Z(2); ...
    handles.X(3) handles.Y(3) handles.Z(3); handles.X(4) handles.Y(4) handles.Z(4)];
%find the unit normal vector to any plane angle created
V=[pM.Vertices];
 V=V-mean(V); 
 [U,S,W]=svd(V,0);
 normal=W(:,end);

if handles.normDirection == 0 % 0 = upwards. If upwards, make sure normal vector is up
    if normal(3) <= 0
        normal = -(normal);
    end
else
    if normal(3) >= 0
        normal = -(normal);
    end
end
figure(2);   % prevent this from calling wrong axis
hold on
q = quiver3(start(1),start(2),start(3),5*normal(1),5*normal(2),5*normal(3));  %execute ARROW function
q.MaxHeadSize = 4;
q.LineWidth = 3;
q.Color = 'r';
q.Tag = 'planeArrow';
handles.normal = normal;


function [handles,gridOUTPUT] = VoxelMaker(handles,X,Y,Z,i)

%create a rectangular box
pM.Faces = [2 3 4; 2 4 1; 5 6 7; 5 7 8; 5 6 2; 5 1 2; 6 7 3; 6 2 3; 7 3 4; 7 8 4;
    8 4 1; 8 5 1];
% the vertices of this box
pM.Vertices = [X(1) Y(1) Z(1); X(2) Y(2) Z(2); X(3) Y(3) Z(3); X(4) Y(4) Z(4)];

normal = handles.pNorm{i};

%create a %%%  second plane %%% offset thickness distance away from the first
[nVert,~] = size(pM.Vertices);
thickness = 5;    %Makes some overlap to prevent gaps in plane
tMat = repmat(normal'*thickness,nVert,1); %translation mtx
pM.Vertices = [pM.Vertices; pM.Vertices-tMat];
% subtracting tMat moves the offset downwards and away

xx = handles.boundsX(1):handles.boundsX(2);
yy = handles.boundsY(1):handles.boundsY(2);
zz = handles.boundsZ(1):handles.boundsZ(2);
%%%%%% Voxelise creates voxels of the plane, without reduced spacing
[gridOUTPUT,gridCOx,gridCOy,gridCOz] = VOXELISE(xx,yy,zz,pM,'xyz');
% volumeViewer(gridOUTPUT)

if isfield(handles,'vTmp') == 1
    vTmp = handles.vTmp;
else
%     % if vTmp does not already exist, create and locate the working subplot
%     % data in the correct place in the original bounds
    vTmp = zeros(handles.boundsX(2),handles.boundsY(2),handles.boundsZ(2));
%     % put subplot data into vTmp
    vTmp(handles.x,handles.y,handles.z) = handles.V(handles.x,handles.y,handles.z);
    vTmp = vTmp./max(max(max(vTmp)));  % Error handling - Parenchyma Borders/tissue are now 1's, airspace is 0's
end

% Find the segmentation that's inside the plane
ind = find(gridOUTPUT == 1 & vTmp == 1);

%%%%%%%%%%%%% Change to = 0 for pockets insted of lumps  %%%%%%%%%%%%%%%%%%
% vTmp(gridOUTPUT == 1)=2;    %  Display plane as 2's
vTmp(ind) = 2;        % % Display the plane/segmentation overlap as 2's

handles.vTmp = vTmp;          % Combine the plane and the submatrix
% volumeViewer(handles.vTmp, 'VolumeType','Labels')




% --- Executes on button press Preview Alveolar Volume.
function regionGrow_Callback(hObject, eventdata, handles)

if isfield(handles,'planeCount') == 0;   % if stored plane does not exist, use current plane location coordinates
    disp('Error. Please store the plane and try again.')
    return
else
    for i = 1:(handles.planeCount-1)
        X = handles.Xplan{i};
        Y = handles.Yplan{i};
        Z = handles.Zplan{i};
        [handles, gridOUTPUT] = VoxelMaker(handles,X,Y,Z,i);  % Store plane in handles.vTmp
    end
end
% Airspace = 0
% Parenchyma = 1
% Plane/Segmentation overlap = 2
% Plane = 3
% Tissue segmented from volume = 4 (see below)

handles.initPos = [handles.seedX.Value handles.seedY.Value handles.seedZ.Value];

[handles.rG, handles.binary] = regionGrowing(handles.vTmp, handles.initPos);

volumeViewer(7*handles.binary + handles.vTmp, 'VolumeType','Labels');
% volumeViewer(7*handles.binary + handles.vTmp);

handles.vTmp(handles.vTmp==2) = 1;  %remove the plane from the segment going forward

guidata(hObject,handles);


% --- Executes on button press in saveDestination.
function saveDestination_Callback(hObject, eventdata, handles)

% Choose folder destination for saving alveoli stats
[handles.savePath] = uigetdir('fileInfo.folder','Select Save Destination Folder for Alveoli');
guidata(hObject,handles);


%%%%%%%%%%  MEASURE AND SAVE BUTTON   %%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Measure the avleolus and save its data to vars file---
function savebutton_Callback(hObject, eventdata, handles)

if isfield(handles,'binary') == 0 %if the user has not previewed the volume, break
    disp('Please Preview Alveolar Volume before measuring.');
    return
else
    disp('Measuring...');
end

[FV] = smoothInterp(handles);  %smooth the data and create Isosurface FV
    
[FV2,maxDepth] = RemovePlaneData(handles,FV);   %Remove primary plane from Alv

[aBase,maxD,minD] = transform(handles);

[PrincipalCurvatures,vol,area,avgK,cTmp] = getCurves(FV2,handles,aBase,maxD);



%get Main Plot Window (figure2), and mark the avl as measured
figure(2)
bTmp = permute(cTmp,[2 1 3]);
p = isosurface(bTmp);


%  SAVE DATA to file
counter = handles.savedEdit.Value+1;
if counter > 12 && counter < 25  %if you count more than 12 alveoli, restart color scheme
    counter2 = counter-12;
elseif counter > 24 && counter < 37
    counter2 = counter-24;
elseif counter > 36 && counter < 49
    counter2 = counter-36;
elseif counter > 48 && counter < 61
    counter2 = counter-48;
elseif counter > 60 && counter < 73
    counter2 = counter-60;
elseif counter > 72 && counter < 85
    counter2 = counter-72;
elseif counter > 84 && counter < 97
    counter2 = counter-84;
elseif counter > 96 && counter < 109
    counter2 = counter-96;
else
    counter2 = counter;
end
switch counter2
    case 1
        p.EdgeColor = [0.6350 0.0780 0.1840];   %dark red
    case 2 
        p.EdgeColor = 	[1 0 0];   % red 
    case 3
        p.EdgeColor = [0.8500 0.3250 0.0980]; %burnt orange
    case 4
        p.EdgeColor = [0.9290 0.6940 0.1250]; %orange
    case 5
        p.EdgeColor = [1 1 0];
    case 6
        p.EdgeColor = [0.8 .95 0]; % light green
    case 7
        p.EdgeColor = [0 1 0]; % green
    case 8
        p.EdgeColor = [0.4660 0.6740 0.1880]; % dark green
    case 9
        p.EdgeColor = 	[0 1 1];  %cyan
    case 10
        p.EdgeColor = [0 0 1];   % Blue
    case 11
        p.EdgeColor = [0 0.4470 0.7410];  %Dark blue
    case 12
        p.EdgeColor = [0.4940 0.1840 0.5560]; % purple
      %restart counter to 1
end
patch(p);
p.count = counter;
%store the position of the patch as its seed point
% initPos(1) = handles.initPos(2) + handles.slider1.Min;
% initPos(2) = handles.initPos(1) + handles.slider2.Min;
% initPos(3) = handles.initPos(3) + handles.slider3.Min;
p.initPos = handles.initPos;
handles.pat(counter) = p;      % assign this particular patch to a row of handles.pat



%%%%% Create the numbered 'Alv#' files   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use the counter to generate a structure of variables in each file
if counter < 10
    alvNum = sprintf('Alv00%d', counter);
    filename = [handles.savePath '\' alvNum];
    % create the file numbered for each alveoli
    eval(sprintf('Alv00%d = matfile(filename,''Writable'',true)', counter));
    myStruct = eval(sprintf('Alv00%d',counter));
elseif counter < 100
    alvNum = sprintf('Alv0%d', counter);
    filename = [handles.savePath '\' alvNum];
    eval(sprintf('Alv0%d = matfile(filename,''Writable'',true)', counter));
    myStruct = eval(sprintf('Alv0%d',counter));
else
    alvNum = sprintf('Alv%d', counter);
    filename = [handles.savePath '\' alvNum];
    eval(sprintf('Alv%d = matfile(filename,''Writable'',true)', counter));
    myStruct = eval(sprintf('Alv%d',counter));
end

myStruct.binary = handles.binary;
myStruct.vTmp = handles.vTmp;
myStruct.pat = handles.pat;
myStruct.FV2 = FV2;
myStruct.PrincipalCurvatures = PrincipalCurvatures;
myStruct.initPos = handles.initPos;
myStruct.vol = vol;
myStruct.area = area;
myStruct.aBase = aBase;
myStruct.maxDepth = maxDepth;
myStruct.maxD = maxD;
myStruct.minD = minD;
myStruct.avgK = avgK;
myStruct.xInds = handles.xInds;
myStruct.yInds = handles.yInds;
myStruct.zInds = handles.zInds;
% myStruct.Circularity = Circularity;

% handles.m.(genvarname(['alv' num2str(counter)]))(1,1:10) = {handles.binary,FV2,PrincipalCurvatures,handles.initPos,vol,area,aBase,maxDepth,maxD,minD};
handles.savedEdit.Value = counter;           % iterate the counter
handles.savedEdit.String = counter;
disp('Alveoli counted. Dont forget to delete planes before moving on.')
guidata(hObject,handles)

function savedEdit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function savedEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in coverHole.
function coverHole_Callback(hObject, eventdata, handles)

handles = trimData(handles);
volumeViewer(handles.vTmp, 'VolumeType','Labels')
guidata(hObject,handles);


% --- Executes on button press in removeSeg.
function removeSeg_Callback(hObject, eventdata, handles)

handles.initPos = [handles.seedX.Value handles.seedY.Value handles.seedZ.Value];
% using the position of the seed, grow the region of the leaked top,
% and remove it by setting it to zero
tic
[handles.rG, binTmp] = regionGrowing(handles.vTmp, handles.initPos);
toc
%binTmp is a segmentation of the unwanted 1's (leaked airspace)
handles.vTmp = handles.vTmp - single(binTmp);
% remove it from vTmp
handles.vTmp(handles.vTmp < 0) = 0;  %this statement will avoid errors
% in case there are small gaps in the segmentation, preventing 0-1 error

handles.vTmp(handles.vTmp==2) = 1;  %remove the plane from the segment
% volumeViewer(handles.binary,'VolumeType','Labels')

handles.subplotFig = figure(2);

handles.hAx = axes(handles.subplotFig);

clf(handles.hAx)

% a = length(handles.V(:,1,1));
% b = length(handles.vTmp(:,1,1));
% if a == b                % prevent vTmp from plotting backwards

% vTmp is the working patch, pTmp is permuted for plotting
handles.pTmp = permute(handles.vTmp,[2 1 3]);   % isosurface switches x and y
    % Create an isosurface subplot of the updated data
handles.fvSub = isosurface(handles.pTmp, 0.5); 

handles.patches.subtissue = patch(handles.fvSub);

% Modify the subplot UI
% axis(handles.hAx,[handles.xInds(1) handles.xInds(end) handles.yInds(1) handles.yInds(end) handles.zInds(1) handles.zInds(end)]);
set(handles.hAx,'XMinorTick','on');
set(handles.hAx,'YMinorTick','on');
handles.subplotFig.Name = 'Main Plot'
handles.patches.subtissue.FaceColor =  'yellow';
handles.patches.subtissue.EdgeColor = 'black';
axis equal
handles.hAx.CameraPosition = [40 20 350];

grid(handles.hAx,'on');
handles.hAx.XLabel.String = 'X';
handles.hAx.YLabel.String = 'Y';
handles.hAx.ZLabel.String = 'Z';
% rotate3d on

% Lighting - 3 lights from orthagonal angles
lightangle(90,-60);
lightangle(270,-60);
lightangle(0,90);

h = handles.patches.subtissue;
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.5;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.LineStyle = 'none';
% check to see if past measured patches are close enough to subplot, and
% render those patches



if isfield(handles,'pat') == 1   % check is patch has been created before
    for i = 1:length(handles.pat)
        if isempty(handles.pat(i).vertices)
            continue
        end
        a = {handles.pat.initPos};  %create a cell structure to index initial positions
        b = a{1,i}; 
        disxMin = handles.slider1.Min - b(1);  % see if initial position is within 100 of subplot
        disyMin = handles.slider2.Min - b(2);
        diszMin = handles.slider3.Min - b(3);

        disxMax = handles.slider1.Max - b(1);  % see if initial position is within 100 of subplot
        disyMax = handles.slider2.Max - b(2);
        diszMax = handles.slider3.Max - b(3);


        if disxMin <= 100 && disyMin <=100 && diszMin <= 150 && disxMax >= -100 && disyMax >= -100 && diszMax >= -150
            f = handles.pat(i).faces;
            v = handles.pat(i).vertices;
            c = handles.pat(i).EdgeColor;
            patch('Faces',f,'Vertices',v,'EdgeColor',c,'facealpha',0.4);
        end
    end
end

guidata(hObject,handles);


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)

% Select location to load Alv
fileInfo = dir;
[handles.savePath] = uigetdir('fileInfo.folder','Select Alveoli Load Source');

cd(eval('handles.savePath'))     % Change the working directory to save folder

listing = dir('Alv*.mat');     %list the file contents of only Alv files
handles.savedEdit.Value = length(listing); % set counter to number of counted alv in directory 
handles.savedEdit.String = handles.savedEdit.Value;


load(listing(end).name);  %load handles.vTmp and all the patches stored in handles.pat from last file
handles.vTmp = vTmp;
handles.pat = pat;
handles.xInds = xInds;
handles.yInds = yInds;
handles.zInds = zInds;

disp('Previous data loading from current directory');

%error handling if there is a need to plot again, plot last used subvolume and
%counted alveoli
if isfield(handles,'vTmp') == 1
    handles.subplotFig = figure(2);
    handles.hAx = axes(handles.subplotFig);
    clf(handles.hAx)
    % Create an isosurface subplot of the updated data
       % prevent vTmp from plotting backwards
    handles.pTmp = permute(handles.vTmp,[2 1 3]);   % isosurface switches x and y
    handles.fvSub = isosurface(handles.pTmp, 0.5);  
    handles.patches.subtissue = patch(handles.fvSub);
    pat = handles.pat;

    % plot patches that were counted in this session
    for i = 1:length(pat)
        if isempty(pat(i).vertices)   % error prevention if alveoli are deleted
        continue
        end
        handles.patches.alreadMeas(i) = patch('Faces',pat(i).faces,'Vertices',pat(i).vertices,'EdgeColor',pat(i).EdgeColor);
    end
    
else
    %in case there was no data to load
    % Create an isosurface subplot of original data
    disp('No data from previously saved file was found');

    %Take in user data to define segmentation boundary
    handles.x = eval(get(handles.edit2,'String'));
    handles.y = eval(get(handles.edit3,'String'));
    handles.z = eval(get(handles.edit4,'String'));

    %%%%%Begin creating the SUBPLOT  
    %Define the indices. Beginning and end defined by subplot and reduced by factor
    % Here the increased sampling resolution in x and y is reduced to match
    % that of the z resolution. This smooths the alveoli for interpolation
    xInds(1) = 1 + (handles.x(1)-1);
    tmpEnd = 1 + (handles.x(end) -1);
    handles.xInds = xInds(1):handles.factor(1):tmpEnd;
    % replace step with factor
    yInds(1) = 1 + (handles.y(1) -1);
    tmpEnd = 1 + (handles.y(end) -1);
    handles.yInds = yInds(1):handles.factor(1):tmpEnd;

    zInds(1) = 1 + (handles.z(1) -1);
    tmpEnd = 1 + (handles.z(end) -1);
    handles.zInds = zInds(1):handles.factor(3):tmpEnd; 
       
    % Error handling if user defines area larger than input
    [m,n,o] = size(handles.V);
    handles.xInds(handles.xInds > m) = []; handles.xInds(handles.xInds < 1) = [];
    handles.yInds(handles.yInds > n) = []; handles.yInds(handles.yInds < 1) = [];
    handles.zInds(handles.zInds > o) = []; handles.zInds(handles.zInds < 1) = [];

    [Yq,Xq,Zq] = meshgrid(handles.xInds,handles.yInds,handles.zInds);    % create an updated meshgrid of query locations
    handles.vReduced = interp3(handles.V,Xq,Yq,Zq,'cubic');   %find the interpolated V matrix at query locations
    handles.fvSub = isosurface(Yq,Xq,Zq,handles.vReduced);  %% notice that V(y,x,z) avoids dim mismatch 
    handles.patches.subtissue = patch(handles.fvSub);
end


% % Modify the subplot UI
% axis(handles.hAx,[xInds(1) xInds(end) yInds(1) yInds(end) zInds(1) zInds(end)]);
set(handles.hAx,'XMinorTick','on');
set(handles.hAx,'YMinorTick','on');
handles.subplotFig.Name = 'Main Plot';
handles.patches.subtissue.FaceColor =  'yellow';
handles.patches.subtissue.EdgeColor = 'none';
axis equal;
grid(handles.hAx,'on');
handles.hAx.XLabel.String = 'X';
handles.hAx.YLabel.String = 'Y';
handles.hAx.ZLabel.String = 'Z';
% rotate3d on

% Lighting - 3 lights from orthagonal angles
lightangle(90,-60);
lightangle(270,-60);
lightangle(90,90);
lightangle(80,80);
% handles.patches.subtissue.LineWidth = 0.01;
% handles.patches.subtissue.EdgeColor = [.5 .5 0];
h = handles.patches.subtissue;
h.BackFaceLighting = 'reverselit';
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.2;
h.DiffuseStrength = 0.7;
h.SpecularStrength = 0.8;
h.SpecularExponent = 25;

% h.LineStyle = '-';

% Update subplot ranges if incorrect
handles.edit2.String = [num2str(xInds(1)) ':' num2str(xInds(end))];
handles.edit3.String = [num2str(yInds(1)) ':' num2str(yInds(end))];
handles.edit4.String = [num2str(zInds(1)) ':' num2str(zInds(end))];

% Update sliders to match subsegment. Subplot size determines min and max
handles.slider1.Max = xInds(end);
handles.slider1.Value = xInds(1);
handles.slider1.Min =  xInds(1); %get from dialog boxes

handles.slider2.Max = yInds(end);
handles.slider2.Value = yInds(1);
handles.slider2.Min =  yInds(1); %get from dialog boxes

handles.slider3.Max = zInds(end);
handles.slider3.Value = zInds(1);
handles.slider3.Min =  zInds(1); %get from dialog boxes

% %set the corresponding Slider text boxes
handles.xT.String = num2str(handles.slider1.Value);
handles.yT.String = num2str(handles.slider2.Value);
handles.zT.String = num2str(handles.slider3.Value);
handles.gT.String = num2str(handles.slider6.Value);

handles.text17.String = num2str(handles.slider1.Min);
handles.text18.String = num2str(handles.slider2.Min);
handles.text19.String = num2str(handles.slider3.Min);
handles.gammaMin.String = num2str(handles.slider6.Min);

handles.text21.String = num2str(handles.slider1.Max);
handles.text22.String = num2str(handles.slider2.Max);
handles.text23.String = num2str(handles.slider3.Max);
handles.gammaMax.String = num2str(handles.slider6.Max);

%%%%%%%%% Initialize the seed sliders with proper values %%%%%%%%%%%%%%%%%
handles.seedX.Max = handles.slider1.Max;
handles.seedX.Value = handles.slider1.Value;
handles.seedX.Min = handles.slider1.Min;
handles.xMin.String = num2str(handles.seedX.Min);
handles.xMax.String = num2str(handles.seedX.Max);

handles.seedY.Max = handles.slider2.Max;
handles.seedY.Value = handles.slider2.Value;
handles.seedY.Min =  handles.slider2.Min; %get from dialog boxes
handles.yMin.String = num2str(handles.seedY.Min);
handles.yMax.String = num2str(handles.seedY.Max);

handles.seedZ.Max = handles.slider3.Max;
handles.seedZ.Value = handles.slider3.Value;
handles.seedZ.Min =  handles.slider3.Min; %get from dialog boxes
handles.zMin.String = num2str(handles.seedZ.Min);
handles.zMax.String = num2str(handles.seedZ.Max);

handles.editSeedX.String = num2str(handles.seedX.Value);
handles.editSeedY.String = num2str(handles.seedY.Value);
handles.editSeedZ.String = num2str(handles.seedZ.Value);

% check to see if past measured patches are close enough to subplot, and
% render those patches
if isfield(handles,'pat') == 1   % check is patch has been created before
    for i = 1:length(handles.pat)
        if isempty(handles.pat(i).vertices)
            continue
        end
        a = {handles.pat.initPos};  %create a cell structure to index initial positions
        b = a{1,i}; 
        disxMin = handles.slider1.Min - b(1);  % see if initial position is within 100 of subplot
        disyMin = handles.slider2.Min - b(2);
        diszMin = handles.slider3.Min - b(3);

        disxMax = handles.slider1.Max - b(1);  % see if initial position is within 100 of subplot
        disyMax = handles.slider2.Max - b(2);
        diszMax = handles.slider3.Max - b(3);


        if disxMin <= 100 && disyMin <=100 && diszMin <= 150 && disxMax >= -100 && disyMax >= -100 && diszMax >= -150
            f = handles.pat(i).faces;
            v = handles.pat(i).vertices;
            c = handles.pat(i).EdgeColor;
            patch('Faces',f,'Vertices',v,'EdgeColor',c,'facealpha',0.4);
        end
    end
end
guidata(hObject, handles);


% --- Executes on button press in analyzeAlveoli.
function analyzeAlveoli_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeAlveoli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ allK, allVol, allSA, allBase, PC1, PC2,gPC, maxDepth, rF, cspec, nmgPC,nnnPC,stdnPC, nK1,nK2,nKDiff,colors,markers,initPos] = VloadFinalStats(handles);
% [ VallK, VallVol, VallSA, VallBase, VPC1, VPC2,VgPC, VmaxDepth, VrF, Vcspec, VnmgPC,VnnnPC,VstdnPC, VnK1,VnK2,VnKDiff,Vcolors,Vmarkers,VinitPos] = VloadFinalStats(handles);

handles.allK = allK;
handles.allVol = allVol;
handles.allSA = allSA;
handles.allBase = allBase;
VrSAV = VallSA./VallVol;
rSAV = allSA./allVol;
VrSAV = VallSA./VallVol;
handles.rSAV = rSAV;
handles.rF = rF;
handles.nmgPC = nmgPC;
handles.nnnPC = nnnPC;
handles.stdnPC = stdnPC;
handles.nK1 = nK1;
handles.nK2 = nK2;
handles.nKDiff = nKDiff;
% deformity score for vili
Vdeformity = [4 5 2 3 4 5 5 4 2 4 3 5 2 4 4 1 4 2 3 5 5 5 2 4 1 1 4 ]';

% deformity for control
deformity = [1 3 2 2 4 5 1 4 5 4 2 3 1 4 2 5 5 2 1 2 2 3 2 2 3 1 2 3 1 4 2 2 3 4]';

VmeanPC = mean(VallK); % mean of all k1
VmeanPC1 = VmeanPC(1);
VmeanPC2 = VmeanPC(2); % mean of all k2

disp(['Mean curvature k(1) = ',num2str(round(meanPC1,4)),' and k(2) = ',num2str(round(meanPC2,4)),...
' mean volume = ',num2str(mean(allVol)),' um^3.']);
disp(['Mean SA = ',num2str(mean(allSA)),' um^2 and mean mouth area = ',num2str(mean(allBase)),' um^2.']);


% mean of mean curvature and std plotting
VmgPC = cellfun(@(m) mean(m,'omitnan'),VgPC);  % this will find the mean and variance of MEAN curvatures
VsgPC = cellfun(@(s) std(s,'omitnan'),VgPC);

VmPC1 = cellfun(@(m) mean(m,'omitnan'),VPC1);  % this will find the mean of MINIMUM curves
VsPC1 = cellfun(@(s) std(s,'omitnan'),VPC1);

VmPC2 = cellfun(@(m) mean(m,'omitnan'),VPC2);  % mean and std of MAXIMUM curves
VsPC2 = cellfun(@(s) mean(s,'omitnan'),VPC2);

VPCr = abs(VmPC1)./VmPC2;     % ratio of min:max curves

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Curvature plot
plotCurvatures(VallK)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Surface Area and Volume

[fitresult, gof] = SAtoVolFit(allVol, allSA,colors,markers,deformity)
% alveoli with large residuals are likely to be damaged

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% comparison of Volume and SA to mean curvatures
curv_to_volume(VallVol,VmPC1,VmPC2,VnK1,VnK2,Vcolors,Vmarkers);


% SA_and_Vol_K(mgPC,allVol,allSA,colors,markers)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   SA:Vol   vs.  Gaussian Curvatures
% correlates with mean gaussian curve
%%%% also rSAV and deformity
SAV_Curv(rSAV,nnnPC,colors,markers,deformity)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% comparison of deformity score and curvature variance
DeformityCurv(Vdeformity,VnK1,VnK2,VnKDiff,Vcolors,Vmarkers)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rF and the curves
rFplots(rF, allBase, allVol, nK1, nK2, nKDiff,colors,markers)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pull out individual alveoli
% Note, colors in plots do not match colors in GUI Subplot
% i = 21;
% listing = dir('Alv*.mat');  
% eval(sprintf('alv%d = importdata(listing(i).name)', i));
% 
% figure()
% ax = gca;
% ax.XLabel.String = 'X (\mum)';
% ax.YLabel.String = 'Y (\mum)';
% ax.ZLabel.String = 'Z (\mum)';
% ax.CameraPosition = [0 1000 0]
% axis equal
% b = eval([sprintf('alv%d',i) '.binary']);
% bb = permute(b,[2 1 3]);
% f = isosurface(bb);
% patch('Faces',f.faces,'Vertices',f.vertices,'EdgeColor',cell2mat(Vcolors(i)),'EdgeAlpha',0.6,'facealpha',1,'FaceColor','k');
% 
% 
% % color in gui subplot:
% alvColor = alv21.pat(i).EdgeColor
% 
% figure('name','Triangle Mesh Curvature','numbertitle','off','color','w');
% colormap jet
% meanK = (0.5*sum(alv21.PrincipalCurvatures));
% caxis([-0.1 0.1]);   %%%%%%%%%%%%% auto ranging or leave out outliers?
% mesh_h=patch(alv21.FV2,'FaceVertexCdata',meanK','facecolor','interp','edgecolor','interp','EdgeAlpha',0.2);
% %set some visualization properties
% set(mesh_h,'ambientstrength',0.1);
% axis equal
% view([-45,35.2]);
% lightangle(90,-60);
% lightangle(270,-60);
% lightangle(0,90);
% lighting phong
% colorbar();

guidata(hObject,handles)


% --- Executes on button press in deletePlanes.
function deletePlanes_Callback(hObject, eventdata, handles)
% clear memory of planes (in green) and clear counter
handles.planeCount = [];    % reset the plane counter
handles = rmfield(handles,'planeCount');
handles = rmfield(handles,'pNorm');
handles.Xplan = [];
handles.Yplan = [];
handles.Zplan = [];
delete(findobj('type', 'patch','Tag','storedPlane'));   % Delete old plane patch
guidata(hObject,handles);

% --- Executes on button press in storePlane.
function storePlane_Callback(hObject, eventdata, handles)

% STORE PLANE LOCATION Button
if isfield(handles,'planeCount') == 0;   % if plane counter does not exist, create
    handles.planeCount = 1;
end

planeCount = handles.planeCount;
    

%Create and store plane dims
len = str2double(get(handles.planeDim,'String'));    % length vector for plane dims

%transpose factors - center of plane
xTrans = handles.slider1.Value;
yTrans = handles.slider2.Value;
zTrans = handles.slider3.Value;
alpha = handles.slider4.Value;  %roration around x (in degrees)
beta = handles.slider5.Value;  %rotation around y 
gamma = handles.slider6.Value;  %rotation around z 

if handles.planeCount == 1    % store the rotation of primary plane for later rotation
    handles.alphaPrime = alpha;
    handles.betaPrime = beta;
    handles.gammaPrime = gamma;
end

%Make a plane
X = [-len len len -len];
Y = [-len -len len len];
Z = [0 0 0 0 ];

% Transpose Matrix
RX = [1 0 0
    0 cosd(alpha) -sind(alpha)
    0 sind(alpha) cosd(alpha)];

RY = [cosd(beta) 0 sind(beta)
    0 1 0
    -sind(beta) 0 cosd(beta)];

RZ = [cosd(gamma) -sind(gamma) 0
    sind(gamma) cosd(gamma) 0
    0 0 1];

R = RZ*RY*RX;

v1 = [X(1) Y(1) Z(1)];
v2 = [X(2) Y(2) Z(2)];
v3 = [X(3) Y(3) Z(3)];
v4 = [X(4) Y(4) Z(4)];

v1T = v1*R;
v2T = v2*R;
v3T = v3*R;
v4T = v4*R;

% Rotated matrix
Xt = [v1T(1) v2T(1) v3T(1) v4T(1)];
Yt = [v1T(2) v2T(2) v3T(2) v4T(2)];
Zt = [v1T(3) v2T(3) v3T(3) v4T(3)];

% patch(Xt,Yt,Zt,'r')                
% Plot plane transposed and transformed
handles.Xplan{planeCount} = Xt + xTrans;
handles.Yplan{planeCount} = Yt + yTrans;
handles.Zplan{planeCount} = Zt + zTrans;
hold on
handles.patches.plane = patch(handles.hAx,handles.Xplan{planeCount},handles.Yplan{planeCount},handles.Zplan{planeCount},'g');            %plot a transposed plane
handles.patches.plane.Tag = 'storedPlane';

handles.pNorm{planeCount} = handles.normal; % store the orientation of the plane

handles.planeCount = planeCount + 1;

guidata(hObject,handles)


% --- Executes on button press in segmentToggle.
function segmentToggle_Callback(hObject, eventdata, handles)
a = get(hObject,'Value'); %returns toggle state of segmentToggle
handles.normDirection = a;
if a ==1 
    hObject.BackgroundColor = [0.9 0.4 0.4];
else
    hObject.BackgroundColor = [0.6627 0.8431 0.9216];
end
handles = updatePlane(handles);   
guidata(hObject,handles)
