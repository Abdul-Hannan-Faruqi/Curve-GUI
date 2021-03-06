function [val,u] =knot_vector_generation(m,ee,p,P,fk,lk) 
%% Parameters
% m  :  number of knots -1
% ee :  exponent used in paramtrization type
% P  :  array containing data points..
% fk :  first clamped
% lk :  last clamped

%% Generation of n+1 parameter values
u = zeros(1,size(P,1)-1);
u(1)=0;
for i = 1:size(P,1)-1
    u(i+1) = u(i) +(((norm(P(i+1,:)-P(i,:))))^ee);
end

u =u/max(u);

%Assume simple knots..
T= zeros(size(P,1)+p,1);
T((p+1:size(P,1)+p),1)=u;

for i=p:-1:1
    T(i) =T(i+1)-1;
end

% Clamping the  first point
if fk && ~lk
    T((p+1:size(P,1)+p),1)=u;
    T(p) = T(p+1)-1;
    for i = p-1:-1:1
        T(i) = T(i+1);
    end
    
end

% Clamping the last point
if ~fk && lk
    T((1:size(P,1)),1)=u;
    T(size(P,1)+1,1) = T(size(P,1),1) +1;
    for i =2:p
        T(size(P,1)+i) = T(size(P,1),1)+1;
    end
    
end

% Clamping the first and last points
if fk &&lk
    %first p  knots =0;
    for i=1:p
        T(i) =0;
    end
    
    
    for i = 1:p
        T(size(P,1)+i)=1;
    end
 
    for i = 1:size(P,1)+p -2*p    
        sump = 0;
        for j=1:p-1
            sump =sump+ u(i+j);
        end
        T(p+i,1) = sump/(p-1);
    end
end
val = T';

end