clc, clear all, close all
Xfo=0.07;
Yfo=0.1;

rfo=[0;-0.5;0];
r0 = [0.3;-1.2;1.2];
dr0= 0.8*[-0.8;2;-0.2];

x(:,1)=[r0;dr0];
g=9.81;
gv=[0;0;-g];
taub=0:0.05:1;
xb0=r0*ones(size(taub))+dr0*taub+gv*taub.^2/2;
pRf=rotx(15)*roty(15)*rotz(15);
nf=pRf*[0;0;1];

tausome=0.34;
xb0some=r0+dr0*tausome+gv*tausome.^2/2;
xb0some =[0.0280
   -0.5200
   -0.0131];

zsome=(nf'*rfo-nf'*[xb0some(1:2);0])/nf(3);
xb0some(3)=zsome
zf=1.3;
rPd=xb0some;
[t1,X1] = ode45(@(t,X) VHIPVarCoP(t,X,zf,rPd,1),[0 3],x);
[t2,X2] = ode45(@(t,X) VHIPVarCoP(t,X,zf,rPd,2),[0 3],x);
rsim1=X1(:,1:3)';
rsim2=X2(:,1:3)';
%%
figure(3)
plot3(x(1,1),x(2,1),x(3,1),'xr'); hold on, grid on
plot3(rsim1(1,:),rsim1(2,:),rsim1(3,:)); 
plot3(rsim2(1,:),rsim2(2,:),rsim2(3,:));
plot3(xb0(1,:),xb0(2,:),xb0(3,:));
plot3(xb0some(1,:),xb0some(2,:),xb0some(3,:),'bx'); 
plot3(rsim1(1,end),rsim1(2,end),rsim1(3,end),'xc')
plot3(rsim2(1,end),rsim2(2,end),rsim2(3,end),'xc')
R4pfo=pRf*[[Xfo Xfo -Xfo -Xfo Xfo];[Yfo -Yfo -Yfo Yfo Yfo];zeros(1,5)]+rfo*ones(1,5);
plot3(R4pfo(1,:),R4pfo(2,:),R4pfo(3,:),'r'), hold on
legend('$r_0$','Orbital Energy','Sliding Mode','Ballistic Trajectory','CoP','Final Position')
axis([-1 1 -1.5 0.5 -0.5 1.5])
%%
xlabel('x')
ylabel('y')
zlabel('z')