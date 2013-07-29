function fn_imvalue(action,varargin)
% fn_imvalue
% fn_imvalue image
% fn_imvalue clean
% fn_imvalue end
% fn_imvalue('chgx'|'chgy'|'chgxy',newax)
%---
% Link images with same dimensions via a crosshair pointer, prints
% values, and enable common zooming and translations.
% Link plots with same x-axis and enable common x-zooming and
% x-translations.
% To prevent conflicts with other programs, it does nothing in windows
% that contain objects with a 'Tag' or 'ButtonDown' property already set.
%
%---
% Thomas Deneux 
% last modification: September 22th, 2007
% sorry, some comments are in french...

if nargin==0
    action = 'init';
end

if strcmp(action,'image'), action='init'; varargin = {true}; end
if strcmp(action,'end'), action='terminate'; end

feval(action,varargin{:});

%-----------
% User calls
%-----------
function init(axisimage)

set(0,'DefaultImageCreateFcn',{@imv_initAxesChildren})
set(0,'DefaultLineCreateFcn',{@imv_initAxesChildren})
if nargin<1, axisimage=false; end

infobase.axisimage = axisimage;
setappdata(0,'fn_imvalue',infobase)

for ha = findobj('type','axes')'
    initAxes(ha,'')
end

%-----------
function terminate

set(0,'DefaultImageCreateFcn','')
set(0,'DefaultLineCreateFcn','')
if isappdata(0,'fn_imvalue')
    rmappdata(0,'fn_imvalue')
end
for ha = findobj('type','axes')'
    terminateAxes(ha)
end

%-----------
function clean

delete(findobj(0,'Tag','ImValText'))
delete(findobj(0,'Tag','ImValCross'))

%-----------
function chgx(newax)

hObject = gca;
ax = axis(hObject);
newax = [newax(:)' ax([3 4])];
chgxy(newax)

%-----------
function chgy(newax)

hObject = gca;
ax = axis(hObject);
newax = [ax([1 2]) newax(:)'];
chgxy(newax)

%-----------
function chgxy(newax)
% manually change the axis in a graph and its linked graphs

hObject = gca;
info = getappdata(hObject,'fn_imvalue');
oldax = info.OldAxis;
isimg = info.IsImg;
hlist = linkedAxes(oldax,isimg);
for ha=hlist, chgAxis(ha,newax), end


%-------------------------
% Init and Terminate Axes
%-------------------------

function initAxes(hObject,type)

% infobase should already be initialized; info should be only if fn_imvalue
% was already active on this axes
infobase = getappdata(0,'fn_imvalue');
info = getappdata(hObject,'fn_imvalue');

% tant que les propri�t�s de l'axes (buttondownfcn, tag...) ne sont pas
% modifi�es par un nouveau 'plot' ou 'image' en 'hold off', plus besoin des
% appels automatiques � 'fn_imvalue'


% si cet axes est d�j� initialis� et contient une image, �ventuellement
% appliquer 'axis image' - TODO: is 'strcmp(type,'image')' necessary?!
if ~isempty(info) && info.IsImg && strcmp(type,'image') && infobase.axisimage
    axis(hObject,'image')
end

set(hObject,'DefaultLineCreateFcn','')
set(hObject,'DefaultImageCreateFcn','')

% s'il y a d�j� un callback ou un Tag dans cet axes provenant d'une autre application, ne rien faire
if ~strcmp(get(hObject,'Tag'),'fn_imvalue') % le plus probable ; plus rapide de d'abord tester ��
    if ~isempty(get(hObject,'Tag')), 
        set(hObject,'DefaultLineCreateFcn','')
        set(hObject,'DefaultImageCreateFcn','')
        return
    end 
    hc = [get(hObject,'parent') ; hObject ; get(hObject,'children')]';
    for h = hc
        if ~isempty(get(h,'ButtonDownFcn')) || ~isempty(get(h,'Tag'))
            return
        end
    end
end

hc = get(hObject,'children');
info.oldtag = get(hObject,'Tag');
set(hObject,'Tag','fn_imvalue')
setHitTestOff(hObject);
oldax = axis(hObject);
set(hObject,'ButtonDownFcn',{@imv_buttonDown})
isimg = any(strcmp(get(hc,'type'),'image'));
if isimg && infobase.axisimage, axis(hObject,'image'), end
info.IsImg = isimg;
hlist = linkedAxes(oldax,isimg);
if isempty(hlist)
    if isimg
        newpoint = get(hObject,'CurrentPoint'); 
        newpoint = newpoint([1 3]); 
        newpoint = min(max(newpoint,oldax([1 3])),oldax([2 4]));
    end
    newax = oldax;
else
    info1 = getappdata(hlist(1),'fn_imvalue');
    if isimg
        newpoint = info1.ImPoint;
        if isempty(newpoint), newpoint = get(hObject,'CurrentPoint'); newpoint = newpoint([1 3]); end
    end
    newax = info1.CurrentAxis;
end
info.OldAxis = oldax;
% NOW hObject becomes 'registered' for fn_imvalue
setappdata(hObject,'fn_imvalue',info);
if isimg
    chgValue(hObject,newpoint)
    chgAxis(hObject,newax)
else
    % impossible de changer l'affichage maintenant (axis(...)), car
    % il semble que cela empeche son ajustement par la suite si d'autres
    % 'lines' sont ajoutees, par exemple dans le meme appel a la fonction
    % 'plot' 
    
    % chgAxis(hObject,newax)
    info.CurrentAxis=oldax;
    setappdata(hObject,'fn_imvalue',info);
end

%-----------
function terminateAxes(hObject)

setHitTestBack(hObject)
set(hObject,'ButtonDownFcn','')

info = getappdata(hObject,'fn_imvalue');

if ~isempty(info)
    axis(hObject,info.OldAxis)
    set(hObject,'Tag',info.oldtag)
    rmappdata(hObject,'fn_imvalue')
elseif strcmp(get(hObject,'Tag'),'fn_imvalue')
    disp('strange, info is empty...')
    keyboard
    set(hObject,'Tag','')
end

hc = get(hObject,'children');
delete(findobj(hc,'Tag','ImValText'))
delete(findobj(hc,'Tag','ImValCross'))

%-----------
% Tools functions
%-----------
function setHitTestOff(ha,varargin)

set(ha,'DefaultLineHitTest','off');
set(ha,'DefaultImageHitTest','off');
set(ha,'DefaultPatchHitTest','off');

for ho=get(ha,'children')'
    setappdata(ho,'OldHitTest',get(ho,'HitTest'))
    set(ho,'HitTest','off')
end

%-----------
function setHitTestBack(ha,varargin)

set(ha,'DefaultLineHitTest',get(get(ha,'parent'),'DefaultLineHitTest'));
set(ha,'DefaultImageHitTest',get(get(ha,'parent'),'DefaultImageHitTest'));
set(ha,'DefaultPatchHitTest',get(get(ha,'parent'),'DefaultPatchHitTest'));

for ho=get(ha,'children')'
    if isappdata(ho,'OldHitTest')
        set(ho,'HitTest',getappdata(ho,'OldHitTest'))
    else
        set(ho,'HitTest','on') %...
    end
end

%-----------
function updateAxes(hObject)
% si axis(hObject) a �t� chang� entre-temps -> r�init

info = getappdata(hObject,'fn_imvalue');

if isempty(info), return, end
if info.IsImg, interest = 1:4; else interest = 1:2; end
oldaxis = info.OldAxis;
curaxis = info.CurrentAxis;
ax = axis(hObject);

chg = ~all(ax(interest)==curaxis(interest)) && ~all(ax(interest)==oldaxis(interest));
if chg
    info.OldAxis=ax;
    info.CurrentAxis=ax;
    setappdata(hObject,'fn_imvalue',info)
end

%-----------
function ret = linkedAxes(refaxis,isimg)

ret = [];
if isimg, interest = 1:4; else interest = 1:2; end
for ha = findobj('type','axes')'
    info1 = getappdata(ha,'fn_imvalue');
    if isempty(info1), continue, end
    oldaxis = info1.OldAxis;
    if all(oldaxis(interest)==refaxis(interest)), ret = [ret ha]; end
end


%-----------
function chgAxis(hObject,newax)

info = getappdata(hObject,'fn_imvalue');

if info.IsImg
    axis(hObject,newax)
    info.CurrentAxis = newax;
    
    ht = findobj(get(hObject,'children'),'Tag','ImValText');
    if ishandle(ht)
        val = get(ht,'String');
        delete(ht)
        createValText(hObject,val);
        info.ImValText = ht;
    else
        createValText(hObject,info.ImPoint);
    end
    cross(hObject)
else
    ax = axis(hObject);
    axis(hObject,[newax(1:2) ax(3:4)])
    info.CurrentAxis = newax(1:2);
end

setappdata(hObject,'fn_imvalue',info)

%-----------
function chgValue(hObject,newpoint)

info = getappdata(hObject,'fn_imvalue');
info.ImPoint = newpoint;
setappdata(hObject,'fn_imvalue',info)

ht = findobj(get(hObject,'children'),'Tag','ImValText');
if ishandle(ht)
    set(ht,'String',getValue(hObject,newpoint))
else
    createValText(hObject,newpoint);
end
cross(hObject)

%-----------
function val = getValue(hObject,point)

hi = findobj(get(hObject,'children'),'type','image');
if length(hi)~=1, error(['there should be one and only one image in' num2str(hObject)]), end
im = get(hi,'CData');
[ni nj] = size(im);

info = getappdata(hObject,'fn_imvalue');
oldaxis = info.OldAxis;
x0 = oldaxis(1); xrange = oldaxis(2)-x0;
y0 = oldaxis(3); yrange = oldaxis(4)-y0;
j = round( point(1)*nj/xrange - nj*x0/xrange + .5 );
i = round( point(2)*ni/yrange - ni*y0/yrange + .5 );
try
    val = im(i,j);
catch
    val = NaN;
end
val = ['val(' num2str(i) ',' num2str(j) ') = ' num2str(val)];

%-----------
function createValText(hObject,pointorvalue)

val = pointorvalue;
if ~ischar(val)
    val = getValue(hObject,pointorvalue);
end
ax = axis(hObject);
switch get(hObject,'ydir')
    case 'normal'
        ptext = ax([1 3]) + [0 1.03].*(ax([2 4])-ax([1 3]));
    case 'reverse'
        ptext = ax([1 3]) + [0 -0.03].*(ax([2 4])-ax([1 3]));
end
text('Parent',hObject,'Position',ptext,'String',val,'Tag','ImValText');

%-----------
function cross(hObject)   

delete(findobj(get(hObject,'children'),'Tag','ImValCross'))
info = getappdata(hObject,'fn_imvalue');
point = info.ImPoint;
ax = axis(hObject);
line([point(1) point(1)],[ax(3) ax(4)],'Parent',hObject, ...
    'Color','black','Tag','ImValCross','HitTest','off','CreateFcn','');
line([ax(1) ax(2)],[point(2) point(2)],'Parent',hObject, ...
    'Color','black','Tag','ImValCross','HitTest','off','CreateFcn','');

%-----------
% Callback calls
%-----------
function imv_initAxesChildren(hObject,dum)

ha = get(hObject,'parent');
type = get(hObject,'type');
% (try to) initialize axes
initAxes(ha,type)

%-----------
function imv_buttonDown(hObject,dum)

info = getappdata(hObject,'fn_imvalue');

% validate user changes in all axis ranges
hlist = findobj('type','axes');
for ha=hlist', updateAxes(ha), end

rect = fn_mouse('rect-');
isimg = info.IsImg;
oldax = info.OldAxis;
hlist = linkedAxes(oldax,isimg);

if strcmp(get(gcf,'SelectionType'),'alt')           % zoom out (reset)
    newax = oldax;
    if ~isimg, axis(hObject,newax), end
    for ha = hlist, chgAxis(ha,newax), end
elseif strcmp(get(gcf,'SelectionType'),'extend')    % zoom out (2x)
    ax = axis(hObject);
    newax = 2*ax - ax([2 1 4 3]);
    newax = [max(newax([1 3]),oldax([1 3])) min(newax([2 4]),oldax([2 4]))]; 
    newax = newax([1 3 2 4]);
    if ~isimg, axis(hObject,newax), end
    for ha = hlist, chgAxis(ha,newax), end
elseif all(rect(3:4)>0)                             % zoom to selection
    newax = [rect(1) (rect(1)+rect(3)) rect(2) (rect(2)+rect(4))];
    if isimg
        newax = [max(newax(1),oldax(1)) min(newax(2),oldax(2)) max(newax(3),oldax(3)) min(newax(4),oldax(4))]; 
    else
        newax = [max(newax(1),oldax(1)) min(newax(2),oldax(2)) newax(3:4)]; 
    end
    for ha = hlist, chgAxis(ha,newax), end
    % if it is a plot, only the x axis is changed everywhere
    % however we want also to change the y axis as the user specified in
    % the current axes
    if ~isimg, axis(hObject,newax), end
else
    newpoint = get(hObject,'CurrentPoint');
    newpoint = newpoint([1 3]);
    if isimg
        ax = axis(hObject);
        centre = mean(ax([1 3 ; 2 4]));
        window = diff(ax([1 3 ; 2 4]));
        disttoedge = 1/2 - abs(newpoint-centre)./window;
        if any(disttoedge<.05)                      % shift
            shift = min(max(newpoint-centre,oldax([1 3])-ax([1 3])),oldax([2 4])-ax([2 4]));
            newax = ax + kron(shift,[1 1]);
            for ha = hlist, chgAxis(ha,newax), end
        end                
        % display value
        for ha = hlist, chgValue(ha,newpoint), end
    else                                            % shift left or right
        ax = axis(hObject);
        width = ax(2)-ax(1);
        newxstart = newpoint(1)-width/2;
        newax = [newxstart (newxstart+width) ax(3:4)];
        for ha = hlist, chgAxis(ha,newax), end
    end
end

