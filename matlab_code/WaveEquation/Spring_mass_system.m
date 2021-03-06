%This code demostrates a wave equation with spring-mass system

%% suggestion: avoid symbolic computation to be fast, make K larger.


%with length L
%Solution to the PDE is uploaded in OneDrive. 
add_my_paths;
L=pi;  %length
tt=10; %time
K=5; %"N" value for fourier sine series
N   = 301;  dx = L/(N-1); %infinitasimal x
x   = 0:dx:L;%domain

index=1;
fig=figure;

%% representing solution using symbolic computation: slow 
for time=1:0.2:tt 
    v=0;
    for nn=1:K 
        eigenf=sin(nn*pi*x/L); %eigenfunction
        w = sin(time) + (x/pi)*-1*sin(time);
        %solve 2nd order diffeq
        syms a(t)
        Da = diff(a,t);
        ode = diff(a,t,2)+nn^2*diff(a,t) == 2*(1/nn-sin(pi*nn)/(pi*nn^2))*sin(t)/pi;
        if nn==1
            cond1 = a(0) == 1;
            cond2 = Da(0) == 0;
        else
            cond1 = a(0) == (-2*sin(pi*nn))/(pi*(nn^2-1));
            cond2 = Da(0) == 2*nn*(cos(pi*nn)+1)/(pi*(nn^2-1));;
        end
        conds = [cond1 cond2];
        aSol(t) = dsolve(ode,conds);
        aSolution=matlabFunction(aSol);
        
        
        v=v+aSolution(time)*eigenf;
    end
    u=v+w; %final solution
    plot(x,u,'b-','LineWidth',2); 
    xlabel('x'); ylabel('u'); 
    xlim([-0.5 L]); ylim([-1.3 1.3]);
    set_positionFontsAll;
    drawnow;
    frame = getframe(fig);
    im{index} = frame2im(frame);
    index=index+1;
    clf;
end
filename = sprintf('springmass.gif');
im_to_gif(filename,im,index-1); %make .gif file for each n value
