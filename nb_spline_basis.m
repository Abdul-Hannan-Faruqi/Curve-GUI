function val = nb_spline_basis(m,i,T,t)

% m :order
% i :index
% T :knot vector
% t : parameter value
% val : Bspline basis function value for parameter t

% Case 1  
if m==1    % last step of iteration
    if( t >= T(i-1) &&(t < T(i)))   
        val = 1;
    else
        val = 0;
    end
    
% Case 2
else
    if m >1
    
%p = (t-T(i-m))/(T(i-1)-(T(i-m));
%q = (T(i)-t)/(T(i)-(T(i-m+1));
    
% p and q are the weights
% Compute the b-spline basis.
    
    if T(i-1) ~=T(i-m)    % ~ stands for not equal to
        p = (t-T(i-m))/(T(i-1)-T(i-m));
    else
        p=0;              % When denominator is zero
    end
    
%  Compute q
    
   if T(i) ~= T(i-m+1)    
        q = ((T(i)-t))/(T(i)-T(i-m+1));
   else
        q =0;
   end
    val = p*nb_spline_basis(m-1,i-1,T,t)+ q*nb_spline_basis(m-1,i,T,t);
    end

end