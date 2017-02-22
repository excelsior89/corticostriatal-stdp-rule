% These two parameters are effectively the resolution controls
% for the output plot
step_size=50;
n_steps=80;

t_span=0:(step_size/1000):(n_steps-1)*(step_size)/1000;
W=zeros(n_steps,n_steps);

DA=zeros(10000,2);
TH=zeros(10000,2);
EL=zeros(10000,4);
DA_triggers=zeros(10000,1);
TH_triggers=zeros(10000,1);
EL_triggers=zeros(10000,1);

% The eligibility trace is triggered by a pre-post pairing
% which is always at the start of a plasticity event.
% This value represents the "raw" STDP response to the
% pre-post or post-pre spike pairing.
% A positive value corresponds to pre-post
% A negative value corresponds to pose-pre
% A larger magnitude corresponds to a more closely spaced pairing
EL_triggers(inds_el)=1;

for ii = 2:10000
    EL(ii,:)=EL(ii-1,:)+0.001*EL_dt(0,EL(ii-1,:),EL_triggers(ii));
end

        
% This loop can take some time
% (~0.025s per inner loop),
% Takes about 2 min with n_steps=80
for i = 1:n_steps
    for j = 1:n_steps
        
        % This section sets up a simulated response to
        % conditioned 10ms DA/Light stimuli at differing delays
        % following the pre-post pairing
        DA(:)=0;
        TH(:)=0;
        
        inds_da=(2:11)+(i-1)*step_size;
        inds_th=(2:11)+(j-1)*step_size;
        inds_el=2;
        
        DA_triggers(:)=0;
        DA_triggers(inds_da)=1;
        TH_triggers(:)=0;
        TH_triggers(inds_th)=1;
        
        for ii = 2:10000
            DA(ii,:)=DA(ii-1,:)+0.001*DA_dt(0,DA(ii-1,:),DA_triggers(ii));
            TH(ii,:)=TH(ii-1,:)+0.001*TH_dt(0,TH(ii-1,:),TH_triggers(ii));
        end
        
        % The change in synaptic weight is the integral of the plasticity
        % rule WRT time across the 10000ms simulation
        W(i,j)=trapz(0:0.001:9.999,3.02*EL(:,4).*(2.5*DA(:,2).*TH(:,2)-0.33*DA(:,2)-0.33*TH(:,2))-0.116*EL(:,4));
    
        % This is just a counter display
        if(mod(j,10)==0)
            fprintf('Processing (i)(j): %d of %d, %d of %d\n',i,n_steps,j,n_steps);
        end
    end
end

% Plotting
surf(t_span,t_span,W);shading interp;view(2)