function data = cont_choice(data)
% This is an interface for obtaining and storing tangent information for
% Ferguson curve

n = size(data.T,1);
handles = struct();

chbox  = figure('units','normalized','position',[.4 .4 .35 .2],'numbert','off','menub','non','toolbar','figure',...
    'name','Continuity and Tangents');

%% Button group
hg = uibuttongroup('units','normalized','position',[.35,0.65,.35,0.35],...
    'title','Select Continuity type','fontn','courier','fonts',10, 'SelectionChangedFcn',@cselection);

% Radio Button for C1
handles.h1 = uicontrol('sty','radio','parent',hg,'units','normalized','position',[0.2,0.2,1,1/3],...
    'string','C1', 'Tag','1');

% Radio Button for C2
handles.h2 = uicontrol('sty','radio','parent',hg,'units','normalized','position',[0.6,0.2,1,1/3],...
    'string','C2','Tag','2');

PushButton = uicontrol(gcf,'Style', 'push', 'String', 'OK','Position', [275 15 30 30],'CallBack', 'uiresume(gcbf)');
cselection(hg, struct( 'NewValue', handles.h1) );
uiwait(chbox);

%% Continuity Selection

function cselection(hObject, eventdata)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

    switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
        case '1'
            hct = uibuttongroup('units','normalized','position',[0.1,0.3,0.85,.3],...
            'title','Specify the set of Tangent Vectors as [T1x T1y; T2x T2y; ...]','fontn','courier','fonts',10);
            handles.h3 = uicontrol('sty','edit','units','normalized','parent',hct,'position',[0.1,0.01,0.75,0.75],...
            'string','');

        case '2'
            hct2 = uibuttongroup('units','normalized','position',[0.1,0.3,0.85,.3],...
            'title','Tangent Vectors [Tx Ty]','fontn','courier','fonts',10);
            handles.h4 = uicontrol('sty','edit','units','normalized','parent',hct2,'position',[0.025,0.01,0.45,0.75],...
            'string','Start Tangent');
            handles.h5 = uicontrol('sty','edit','units','normalized','parent',hct2,'position',[0.525,0.01,0.45,0.75],...
            'string','End Tangent');
    end
end

%% Storing values    
if get(handles.h1,'Value')
    data.c = 1;
    s = get(handles.h3,'string');
    if (~isempty(s))
        data.T = str2num(s);
        data.flag = 1;
    else
        warndlg('Please enter the tangent vectors');
    end
end
if get(handles.h2,'Value')
    data.c =2;
    s1 = get(handles.h4,'string');
    if (~isempty(s1))
        data.T(1,:) = str2num(s1);
        data.flag = 1;
    else
        warndlg('Please enter the tangent vectors');
    end
    s2 = get(handles.h5,'string');
    if (~isempty(s2))
        data.T(n,:) = str2num(s2);
        data.flag = 1;
    else
        warndlg('Please enter the tangent vectors');
    end
end

% Close fig
close(chbox); 

end
