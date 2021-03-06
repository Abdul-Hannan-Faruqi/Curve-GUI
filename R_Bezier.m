function [data,w] = R_Bezier(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
wbox  = figure('units','normalized','position',[.4 .4 .35 .2],'numbert','off','menub','non','toolbar','figure',...
    'name','Continuity and Tangents');

%% Button group
hw = uibuttongroup('units','normalized','position',[0.1,0.3,0.85,.3],...
            'title','Specify the weight vector: [w1; w2; ...]','fontn','courier','fonts',10);
handles.h3 = uicontrol('sty','edit','units','normalized','parent',hw,'position',[0.1,0.01,0.75,0.75],...
            'string','');

PushButton = uicontrol(gcf,'Style', 'push', 'String', 'OK','Position', [275 15 30 30],'CallBack', 'uiresume(gcbf)');

uiwait(wbox);

%% Storing values   

s = get(handles.h3,'string');
if (~isempty(s))
    w = str2num(s);
    data.flag = 1;
else
    warndlg('Please specify the weights');
end

% Close fig
close(wbox); 
end

