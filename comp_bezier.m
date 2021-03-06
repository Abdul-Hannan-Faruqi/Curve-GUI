function [x,y] = comp_bezier(P,x,y,data)
% Continuity information for composite Bezier curve

n = length(P);
handles = struct();

chbox  = figure('units','normalized','position',[.4 .4 .35 .2],'numbert','off','menub','non','toolbar','figure',...
    'name','Continuity Parameters');
hg = uibuttongroup('units','normalized','position',[.35,0.65,.35,0.35],...
    'title','Select Continuity type','fontn','courier','fonts',10, 'SelectionChangedFcn',@cselection);

% Radio Button for Moving the control points
handles.h1 = uicontrol('sty','radio','parent',hg,'units','normalized','position',[0.2,0.2,1,1/3],...
    'string','C1', 'Tag','1');

% Radio Button for Adding the control points after the last ctrl point
handles.h2 = uicontrol('sty','radio','parent',hg,'units','normalized','position',[0.6,0.2,1,1/3],...
    'string','C2','Tag','2');

PushButton = uicontrol(gcf,'Style', 'push', 'String', 'OK','Position', [275 15 30 30],'CallBack', 'uiresume(gcbf)');
cselection(hg, struct( 'NewValue', handles.h1) );
uiwait(chbox);

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
            'title','Set lambda','fontn','courier','fonts',10);
            handles.h3 = uicontrol('sty','edit','units','normalized','parent',hct,'position',[0.1,0.01,0.75,0.75],...
            'string','');

        case '2'
            hct2 = uibuttongroup('units','normalized','position',[0.1,0.3,0.85,.3],...
            'title','Choose parameter values','fontn','courier','fonts',10);
            handles.h4 = uicontrol('sty','edit','units','normalized','parent',hct2,'position',[0.025,0.01,0.45,0.75],...
            'string','lambda');
            handles.h5 = uicontrol('sty','edit','units','normalized','parent',hct2,'position',[0.525,0.01,0.45,0.75],...
            'string','mu');
    end
end

    
if get(handles.h1,'Value')
    s = get(handles.h3,'string');
    if (~isempty(s))
        lambda = str2double(s);
        x(n+1) = (lambda+1)*P(n,1)-lambda*P(n-1,1);
        y(n+1) = (lambda+1)*P(n,2)-lambda*P(n-1,2);
        data.flag = 1;
    else
        warndlg('Please specify the parameters');
    end
end
if get(handles.h2,'Value')
    data.c =2;
    s1 = get(handles.h4,'string');
    s2 = get(handles.h5,'string');
    if (isempty(s1)|| isempty(s2))
        warndlg('Please specify the parameters');
    else
        data.flag = 1;
        lambda = str2double(s1);
        mu = str2double(s2);
        x(n+1) = (lambda+1)*P(n,1)-lambda*P(n-1,1);
        y(n+1) = (lambda+1)*P(n,2)-lambda*P(n-1,2);
        x(n+2) = (1+2*lambda-(mu*lambda^2/2))*(P(n,1)-P(n-1,1))-lambda*(P(n-1,1)-P(n-2,1));
        y(n+2) = (1+2*lambda-(mu*lambda^2/2))*(P(n,2)-P(n-1,2))-lambda*(P(n-1,2)-P(n-2,2));
    end    
end
close(chbox);

end

