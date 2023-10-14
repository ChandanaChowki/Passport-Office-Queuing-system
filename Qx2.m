function  [ST,T] =Qx2(L,mu)


% clear all; %empty memory
ST=[];
rng(1);% rand(’seed’,0)%set random seed
% lambda=7; %arrival rate
% mu=10; %service rate
endtime=1000; %simulation length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0; %current time
tstep=0.5; %average time between consecutive measurement events
currcustomers=0; %current number of customers in system
event=zeros(1,3); %constructs vector to keep time for next arrival
%(pos 1),next service completion (pos 2) and next
% measurement event (pos 3)
event(1)=L(1); %time for next arrival1
event(2)=inf; %no next service completion (empty system)
event(3)=exprnd(tstep); %time for next measurement event
nbrmeasurements=0; %number of measurement events so far
nbrdeparted=0; %number of departed customers
nbrarrived=0; %number of customers that have arrived throughout the simulations
i=1;
while t<endtime
    [t,nextevent]=min(event);
    if nextevent==1
        event(1)=L(i)+t;
        while i<length(L)
            i=i+1;
        end
        currcustomers=currcustomers+1;
        nbrarrived=nbrarrived+1; %one more customer has arrived to the system through the simulations
        arrivedtime(nbrarrived)=t; %the new customer arrived at time t
        if currcustomers==1
            R=exprnd(1/mu);
            ST(end+1)=R;
            event(2)=R+t;
        end
    elseif nextevent==2
        currcustomers=currcustomers-1;
        timeinsystem=t-arrivedtime(nbrarrived-currcustomers);
        nbrdeparted=nbrdeparted+1; %one more customer has departed%from the system through the%simulations
        T(nbrdeparted)=timeinsystem;
        if currcustomers>0
            R=exprnd(1/mu);
            ST(end+1)=R;
            event(2)=R+t;
        else
            event(2)=inf;
        end
    else
        nbrmeasurements=nbrmeasurements+1; %one more measurement event
        N(nbrmeasurements)=currcustomers;
        event(3)=event(3)+exprnd(tstep);
    end
end
