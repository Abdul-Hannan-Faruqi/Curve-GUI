
%% Curve Design (Interactive Graphical User Interface)
% An interactive Curve design app based on MATLAB GUI
% Created in MATLAB 2020a
% By Abdul Hannan Faruqi           , Dated Dec 17, 2020.
%
%
% REFERENCES
% [1] Various examples of mouse drag and drop from in.mathworks.com
% [2] CAED Lectures By Prof. Anupam Saxena from nptel channel on youtube.com
% [3] BSpline_GUI created by Jishal S Rahim and Suyash Pratap

function curve_gui    % GUI Function
%% Create main gui
fig  = 	figure('units','normalized','position',[.05 .05 .9 .9],'numbert','off','menub','non','toolbar','figure',...
    'name','Curve Design');
data = struct;       % Structure to share data across functions
data.type = 0;
%% Setting up the axes in the gui
ax   = axes( 'units','normalized','position',[.04 .15 .75 .7],...
    'Parent', fig, ...
    'XLimMode', 'manual', ...
    'YLimMode', 'manual','Box','on');
grid(ax,'on');

%% Setting the axes limits

% Template for editing the x axis limits
e1 = uicontrol('style','edit','units','normalized','position',[.71,.045,.08,.04],...
    'backgroundc',[1,1,1],'string','0 20','fonts',10,'fontn','courier',...
    'callback',@che);

% Template for editing the y axis limits
e2 = uicontrol('style','edit','units','normalized','position',[.71,0.005,.08,.04],...
    'backgroundc',[1,1,1],'string','0 20','fonts',10,'fontn','courier',...
    'callback',@che);

% Static text for x axis
uicontrol('style','text','units','normalized','position',[.69,0.01,.02,.035],...
    'string','y','fonts',12,'backgroundc',get(gcf,'color'))

% Static text for y axis
uicontrol('style','text','units','normalized','position',[.69,.045,.02,.035],...
    'string','x','fonts',12,'backgroundc',get(gcf,'color'))

% Static text 'Axes limits'
uicontrol('style','text','units','normalized','position',[.695,.085,.1,.025],...
    'backgroundc',[1,1,1],'string','Axes Limits','fonts',10,...
    'fontn','courier','backgroundc',get(gcf,'color'));

%% Basic Curve creating gui buttons

% Draw Button
uicontrol('sty','pushbutton','units','normalized','position',[0.45,.93,.12,.05],...
    'backgroundc',[1,1,1],'string','Draw','fonts',10,'fontn','courier',...
    'callback', @ggz);

handles.type = uicontrol('Style','popupmenu','units','normalized','position',[.08,.93,.12,.05],...
    'String',{'Curve Type','Bezier','Ferguson','B-Spline'},'fonts',10,'fontn','courier',...
    'callback',@type_select);

% Reset Button
uicontrol('style','push','units','normalized','position',[.3,.05,.12,.05],...
    'backgroundc',[1,1,1],'string','Reset','fonts',10,'fontn','courier',...
    'callback',@gg);

% static text 'Specify order'
hll = uibuttongroup('units','normalized','position',[0.25,0.93,.145,.065],...
    'title','Specify order','fontn','courier','fonts',10);

% Text box for entering the prefferd order of the spline
handles.h3 = uicontrol('sty','edit','units','normalized','parent',hll,'position',[0.01,0.01,0.95,0.9],...
    'string','');
set(hll,'visible','off');

%% Modify tangents for Ferguson curve

% Modify Tangents button
tang = uicontrol('style','push','units','normalized','position',[.85,.4,.12,.05],...
    'backgroundc',[1,1,1],'string','Modify Tangents','fonts',10,'fontn','courier',...
    'callback',@fc);

set(tang,'visible','off');

%% Modify weights for Bezier curve

% Set weights button
hw = uicontrol('style','push','units','normalized','position',[.85,.4,.12,.05],...
    'backgroundc',[1,1,1],'string','Set weights','fonts',10,'fontn','courier',...
    'callback',@bw);

set(hw,'visible','off');

%% hkn buttongroup for knot vectors

% Button Group 'Choice of knot vectors' ( Radio Buttons)
hkn = uibuttongroup('units','normalized','position',[.83,0.12,.15,.23],...
    'title','Clamping options','fontn','courier','fontsize',10);

%Radio Button for Uniform spacing method.
handles.h44 = uicontrol('sty','radio','parent',hkn,'units','normalized','position',[0,0.8,1,0.2],...
    'string','Both Ends Clamped');

%Radio Button for Chord Length spacing method.
handles.h55 = uicontrol('sty','radio','parent',hkn,'units','normalized','position',[0,0.534,1,0.2],...
    'string','Both Ends Free');

%Radio Button for Centripetal method.
handles.h66 = uicontrol('sty','radio','parent',hkn,'units','normalized','position',[0,0.268,1,0.2],...
    'string','First Knot Clamped');

%Radio Button for Centripetal method.
handles.h77 = uicontrol('sty','radio','parent',hkn,'units','normalized','position',[0,0.01,1,0.2],...
    'string','Last Knot Clamped ');
set(hkn,'visible','off');

%% hk buttongroup for choice of knot vectors

% Button Group 'Choice of knot vectors' ( Radio Buttons)
hk = uibuttongroup('units','normalized','position',[.83,.4,.15,.25],...
    'title','Choice of knot vectors','fontn','courier','fontsize',10);

% Radio Button for Uniform spacing method.
handles.h4 = uicontrol('sty','radio','parent',hk,'units','normalized','position',[0,0.75,1,0.2],...
    'string','Uniform');

% Radio Button for Chord Length spacing method.
handles.h5 = uicontrol('sty','radio','parent',hk,'units','normalized','position',[0,0.25,1,0.2],...
    'string','Chord Length');

% Radio Button for Centripetal method.
handles.h6 = uicontrol('sty','radio','parent',hk,'units','normalized','position',[0,0.5,1,0.2],...
    'string','Centripetal');

% PushButton for updating the order and knot selection of the B-spline
uicontrol('sty','pushbutton','parent',hk,'units','normalized','position',[0.05,0.05,0.9,.2],...
    'backgroundc',[1,1,1],'string','Update(knots/order)','fonts',10,'fontn','courier',...
    'callback',@refr);
set(hk,'visible','off');

%% hl button group of check boxes

% Button group for other options
hl = uibuttongroup('units','normalized','position',[.83,.7,.15,.2],...
    'title','Curves and Polygons','fontn','courier','fonts',11);

% Shows the Local Convex Hulls
handles.h8 = uicontrol('sty','check','parent',hl,'units','normalized','position',[0,0,1,1/4],...
    'string','Global Convex Hull','callback',@lch);
% 
% Showa the Local Convex hull
handles.h88 = uicontrol('sty','check','parent',hl,'units','normalized','position',[0,0.2,1,1/4],...
    'string','Local Convex Hull','callback',@llch);


% Shows the Control polyline
handles.h10 = uicontrol('sty','check','parent',hl,'units','normalized','position',[0,0.4,1,1/4],...
    'string','Control Polyline','value',1,'callback',@pol);

% Composite Bezier Curve
handles.h9 = uicontrol('sty','check','parent',hl,'units','normalized','position',[0,0.6,1,1/4],...
    'string','Composite Bezier Curve','callback',@bc);


%%  Font size

% Setting the font size of every radio button
set(findobj('style','radiobutton'),'fontsize',10)

%% Reset button simply closes and reopens the GUI

    function gg(varargin)
        close(gcf)
        curve_gui
    end

%% Changing the x or the y limits
    function che(varargin)
        
        xlim(str2num(get(e1,'string'))); %#ok<*ST2NM>
        ylim(str2num(get(e2,'string'))); % gets information from string of e2 and convert to num type
    end

che

%% Basic functions like refresh ,display of polylines, convex hull, bezier etc.
    function refr(varargin)         % callback for refresh button
        
        P =[x',y'];
        curve_gui_draw();
        
    end


    function pol_line()                % function for display of polyline
        P =[x',y'];
        Px = P(:,1);
        Py = P(:,2);
        plot(Px,Py,'k--','LineWidth',1);
    end


    function pol(varargin)            % Callback for polyline
        if  get(handles.h10,'Value')
            pol_line();
        else
            refr();
        end
    end

    function loc_conv_hull()          %  Function   for Local Convex Hulls
         P =[x',y'];
          ppstr = str2num(get(handles.h3,'string'));
          nn = length(P(:,1));
          for i = 1: (nn-ppstr+1)
              Pp = P((i:i+ppstr-1),1:2);
              kk = convhull(Pp);
             fill(Pp(kk,1),Pp(kk,2),'m','facealpha',0.25);
             hold on
          end
    end


function llch(varargin)            % Callback for Local Convex Hulls
        if  get(handles.h88,'Value')
            loc_conv_hull();
        else
            refr();
        end
end


    function conv_hull()               % Function for Global Convex Hulls
        P =[x',y'];
        kk = convhull(P);
        plot(P(kk,1),P(kk,2),'r-','LineWidth',1);
       fill(P(kk,1),P(kk,2),'r','facealpha',0.25);
    end



    function lch(varargin)            % Callback for Global Convex Hulls
        if  get(handles.h8,'Value')
            conv_hull();
        else
            refr();
        end
    end


    function bezier()                  % Function for Bezier Curve
        P = [x',y'];
        w = ones(length(P),1);
        bezier_gen(P,w);
    end

    function ferguson()                  % Function for Ferguson Curve
        P = [x',y'];
        ferguson_gen(ax,P,data);
    end

    function bc (varargin)              %Callback for Composite Bezier curve
        if  get(handles.h9,'Value')&& data.type == 1
            data.flag = 0;
            [x,y] = comp_bezier(P,x,y,data);
            if data.flag == 1
                bezier();
            end
        else
            warndlg('Please select Bezier Curve');
        end
    end

    function bw (varargin)              %Callback for Rational Bezier curve
        if  data.type == 1
            data.flag = 0;
            [data,w] = R_Bezier(data);
            if data.flag == 1
                curve_gui_draw();
            end
        else
            warndlg('Please select Bezier Curve');
        end
    end

    function fc (varargin)              %Callback for Ferguson curve
        if  data.type == 2
            data.c = 0;
            n = size(P,1);
            data.T = zeros(n,2);
            data.flag = 0;
            data = cont_choice(data);
            curve_gui_draw();
        else
            refr();
        end
    end

%% Variable Declaration
x        = [];               % x coords of control pts
y        = [];               % y coords of control pts
P        = [x',y'];          % set of control points
dragiP   = [];               % index of currently selected point for dragging

ctrl =     line(-1, -1, ...  % mark the control points when clicking
         'Parent', ax, ...   % interactively
         'LineStyle', 'none', ...
         'Marker', 'o');

%% Important functions

    function ggz(varargin)    % Function to add points
        if data.type == 3
        if isempty(get(handles.h3,'string'))
            % warning message when order field is empty
            f = warndlg('Please select choice of order. Hit Enter!!','Warning'); %#ok<NASGU>
        end
        end

        % Maximum xlimits and ylimits of the current axis
        xlimm = [str2num(get(e1,'string'))]; %#ok<NBRAK,*ST2NM>
        ylimm =	[str2num(get(e2,'string'))]; %#ok<NBRAK>
        
        
        try
            cancel = false;
            while ~cancel
                [x1,y1,button] = ginput(1);    % records input from the axes
                if isempty(x1) || isempty(y1)  % ENTER key
                    break;
                elseif x1 < xlimm(1,1) || x1 > xlimm(1,2) || y1 < ylimm(1,1) || y1 >  ylimm(1,2) % point outside domain
                    continue;    % Do nothing and continue
                end
                switch button
                    case 1               % left mouse button
                                         % record points
                    case 3               % right mouse button
                        cancel = true;   % cancel with adding the right clicked point
                    case 27              % ESC key
                        cancel = true;   % cancels mouse input
                        continue;
                end
                x = [x,x1]; %#ok<AGROW>
                y = [y,y1]; %#ok<AGROW>
                
                set(ctrl, 'XData', x, 'YData', y); % set the ctrl defined earlier
            end
        catch ex
            switch ex.identifier
                case 'MATLAB:ginput:FigureDeletionPause'
                    % preserve values for x and y
                otherwise
                    rethrow(ex);
            end
        end
        P = [x', y'];             % stores ctrl point values into P matrix
        if data.type == 2
            fc();
        end
        curve_gui_draw(); % draws the curve
        
    end

    function type_select(source, eventdata)
      str = source.String;
      val = source.Value;
      
      % Set current data to the selected data set.
      switch str{val}
          
      case 'Curve Type'
          data.type =0;
          f = warndlg('Please select curve type');
      case 'Bezier' % Bezier Curve selected
         data.type = 1;
         set(hw,'visible','on');
         set(hll,'visible','off');
         set(hk,'visible','off');
         set(hkn,'visible','off');
      case 'Ferguson' % Ferguson Curve selected
         data.type = 2;
         set(tang,'visible','on');
         set(hw,'visible','off');
         set(hll,'visible','off')
         set(hk,'visible','off');
         set(hkn,'visible','off');
      case 'B-Spline' % B-Spline Curve selected
         data.type = 3;
         set(hll,'visible','on')
         set(hk,'visible','on');
         set(hkn,'visible','on');
         set(hw,'visible','off');
      end
    end

%% Setting mouse control callbacks for the current fig and axes

%Associates the mouse clicks and motion functions with callbacks
set(ax, 'ButtonDownFcn', @curve_gui_onmousedown);   % function for add pts inside axes
set(fig, 'WindowButtonUpFcn', @curve_gui_onmouseup);     % function for move and del pts
set(fig, 'WindowButtonDownFcn', @curve_gui_figmousedown); % function for move and del pts
set(fig, 'WindowButtonMotionFcn', @curve_gui_onmousemove);% function for move and del pts
uiwait(fig);


%% Function for drawing the b-spline
    function curve_gui_draw()              % Draws a  B-spline following bspline_gen.m
        
         P = [x',y'];
        cla
        
        if data.type == 3
        ppstr = str2num(get(handles.h3,'string')); % extract 'order' value
        if get(handles.h5,'Value')                 % extracts the type of knots ee = 0 for uniform etc..
            ee=1.0;
        end
        
        if get(handles.h4,'Value')
            ee= 0;
        end
        
        if get(handles.h6,'Value')
            ee= 0.5;
        end
        
        if get(handles.h55,'Value')                 % extracts the type of knots ee = 0 for uniform etc..
             fk = 0;
             lk = 0;
        end
        
        if get(handles.h77,'Value')                 % extracts the type of knots ee = 0 for uniform etc..
           fk = 0;
           lk = 1;
        end
        
        if get(handles.h44,'Value')
            fk = 1;
            lk = 1;
        end
        
        if get(handles.h66,'Value')
           fk = 1;
           lk = 0;
        end

        bspline_gen(P,ppstr,ee,fk,lk);
        end
        
        if  data.type == 1
            bezier_gen(P,w);
        end 
        
        if  data.type == 2
            ferguson_gen(ax,P,data);
        end
        
        if  get(handles.h8,'Value')
            conv_hull();
        end
         if  get(handles.h88,'Value')
            loc_conv_hull();
        end
        if  get(handles.h10,'Value')
            pol_line();
        end
        
    end

%% Mouse control function (for Add points)
    function curve_gui_onmousedown(ax, event)  %#ok<INUSD>

        if data.type>0
        p = double(get(gca,'currentpoint'));
        text(0.5, 0.5, 'Left-click and drag to move, Right-click to delete', 'Parent',ax);
        P = [x',y'];
                 
                % add point clicked to current points
                x = [x, p(1,1)];
                y = [y, p(1,2)];
                P = [P;p(1,1:2)];
               
                curve_gui_draw();
        else
            warndlg('Please select curve type');
        end

    end

    function curve_gui_figmousedown(fig,event)        %#ok<INUSD>

        text(0.5, 0.5, 'Left-click and drag to move, Right-click to delete', 'Parent',ax);
        xlimm = [str2num(get(e1,'string'))];            %#ok<NBRAK,*ST2NM>
        p = double(get(gca,'currentpoint'));
        
        a = p(1,1);
        b = p(1,2);
        c = x;
        d = y;
        P = [x',y'];
        
    % Array of (distance)^2 between clicked point and the set of ctrl points
         dist = (abs(a - c) + abs(b - d));                                          
            % change its x and y to match click point
            [mindist,minix] = min(dist);  % closest point (min distance)
            if mindist < xlimm(1,2)/10    % corresponds to axes limits
                dragiP = minix;           % grab point index
            end  
    
            if strcmp(get(fig,'SelectionType'),'alt')          % Delete points
            
                dist = (abs(a - c) + abs(b - d)); % dist of clicked pt from all ctrl pts
                minn = min(dist);
                if minn < xlimm(1,2)/10
                x(dist == min(dist))=[];  % x value of the index corresponding to min dist is deleted
                y(dist == min(dist))=[];  % y value of the index corresponding to min dist is deleted
                end
           
                curve_gui_draw(); % draws curve 
                
            end
        end

        function curve_gui_onmouseup(fig, event) %#ok<INUSD> % tells what to do when releasing the left click
        % Fired when the user releases the mouse button.
            dragiP = [];  % no currently selected point
        end

        function curve_gui_onmousemove(fig, event) %#ok<INUSD>
        % Triggered when  moving the mouse.
            
            if isempty(dragiP)  % no point selected (not in drag mode)
            return;
            end
            p = double(get(gca,'currentpoint'));
        
            a = p(1,1);          % x coord of pointer over the figure window
            b = p(1,2);          % y coord of pointer over the figure window
        
            x(dragiP) = a;       % changes the x coordinate as you drag the mouse
            y(dragiP) = b;       % changes the y coordinate as you drag the mouse
         
            curve_gui_draw();
        end

end