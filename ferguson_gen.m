function ferguson_gen(ax,P,data)
% P : the matrix of control points			
      
        Px = P(:,1);        % x coord of points
		Py = P(:,2);        % y coord of points
		n = size(P,1) - 1;  % depends on number of specified control point
        
% Generate and plot the Ferguson curve

N  = 50;                  % Resolution of the Ferguson curve
F = zeros(N*n,2);
M = [2 -2 1 1; -3 3 -2 -1; 0 0 1 0; 1 0 0 0];
A = zeros(n-1,n-1);
B = zeros(n-1,2);
T = zeros(n+1,2);

if length(data.T)<n+1
    T(1,:) = data.T(1,:);
    T(n+1,:) = data.T(length(data.T),:);
else
    T = data.T;
end

if data.c == 2
for i = 1:n-1
    if i==1
        A(i,i:i+1) = [4,1];
        B(i,:) = 3*(P(i+2,:)-P(i,:))-T(i,:);
    elseif i == n-1
        A(i,i-1:i) = [1,4];
        B(i,:) = 3*(P(i+2,:)-P(i,:))-T(i+2,:);
    else
        A(i,i-1:i+1)= [1,4,1];
        B(i,:) = 3*(P(i+2,:)-P(i,:));
    end
end
    T(2:n,:) = linsolve(A,B);
end

for k =1:n    
    for i=1:N
        u =(i-1)/(N-1);
% Ferguson curve
    U = [u^3 u^2 u 1];
    G = [P(k,:);P(k+1,:);T(k,:);T(k+1,:)];
    F(i+(k-1)*N,:) = U*M*G;
    end
end

 axes(ax)
 grid on
 hold on
    plot(F(:,1),F(:,2),'g-','linewidth',1);   % Plot Ferguson curve
    plot(Px,Py,'ro','LineWidth',1);
end