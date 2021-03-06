function bspline_gen(P,pp,ee,fk,lk)
% P  : matrix containing the whole set of control points
% pp : order of the curve
% ee : the knot vector spacing type
		          
      	Px = P(:,1);
		Py = P(:,2);
		n = size(P,1) - 1;

m = n+pp;          % m+1 denotes the total number of knots

T = knot_vector_generation(m,ee,pp,P,fk,lk);
% assignin('base','T',T);       % assigns the T value to the workspace for
% inspection

%interval of full support......[a b]

a = T(pp);
b = T(m+1 -(pp-1));

%Generate  a B-spline curve
N  =  150;              % Resolution of the curve
x = zeros(1,N);
y = zeros(1,N);
for i =1:N
    t1 =(i-1)/(N-1);
    t = (1-t1)*a +t1*b;
    
    x(i) =0;
    y(i) = 0;
    
    
    for k=1:n+1
    %B-spline
    x(i) = x(i) +nb_spline_basis(pp,pp+k,T,t)*Px(k);
    y(i) = y(i) +nb_spline_basis(pp,pp+k,T,t)*Py(k);
    end
end
if fk == 1 && lk ==1 || fk == 0 && lk ==1
x(N) = Px(n+1);   % replacing the last point of the bslpine with the last control point
y(N) = Py(n+1);   % replacing the last point of the bslpine with the last control point
end             % This is due to open interval on the right of the knot
                  % spans
 grid on
 hold on
    plot(x,y,'Linewidth',1);        % Plot Bspline curve
    plot(Px,Py,'ro','LineWidth',1); % Plot Control points  
end


	
	
