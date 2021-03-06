function bezier_gen(P,w)
% P : the matrix of control points			
      
        Px = P(:,1);        % x coord of points
		Py = P(:,2);        % y coord of points
		n = size(P,1) - 1;  % depends on number of specified control points


% Generate and plot the Bezier curve

N  =  150;                  % Resolution of the Bezier curve
bex = zeros(1,N);
bey = zeros(1,N);

for i =1:N
    t1 =(i-1)/(N-1);
   
    
% Bezier curve..
    bex(i)  = 0;
    bey(i)  = 0;
    
    for k=1:n+1
%Bezier curve
    c = factorial(n)/(factorial(k-1)*factorial(n-(k-1)));
    c = c*((1-t1)^(k-1))*(t1)^(n-(k-1));
    
    bex(i) = bex(i) +c*w(k)*Px(k);
    bey(i) = bey(i) +c*w(k)*Py(k);
    end
end

B = [bex; bey];
  
 grid on
 hold on
    plot(B(1,:),B(2,:),'m-','linewidth',1);   % Plot Bezier curve
    plot(Px,Py,'ro','LineWidth',1);
end