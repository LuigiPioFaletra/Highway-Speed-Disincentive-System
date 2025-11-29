function gateway_init
ttInitKernel('prioFP')      % Kernel a scheduling con priorita' fissata
ttSetKernelParameter('energyconsumption', 0.010);       % Consumo a 10 mW
ttCreateMailbox('speed_signal');            % Mailbox per velocita'
ttCreateMailbox('weight_signal');           % Mailbox per peso      
ttCreateMailbox('displacement_signal');     % Mailbox per cilindrata
ttCreateMailbox('spe_signal');      % Mailbox per velocita' con perdite
ttCreateMailbox('wei_signal');      % Mailbox per peso con perdite
ttCreateMailbox('dis_signal');      % Mailbox per cilindrata con perdite
clear gateway_fnctn;                % Rimuove variabili e libera memoria

% Creazione del task gateway
name = 'gateway_task';              % Il nome del task del gateway
deadline = 0.01;                    % La scadenza del task del gateway
fnctn = 'gateway_fnctn';            % La funzione del task del gateway
ttCreateTask(name, deadline, fnctn);        % Realizza il task
prio = 1;       % La priorita' associata all'attività del task del gateway
ttSetPriority(prio, name);  % Imposta la priorita' del task gateway

% Inizializzazione rete con nodo in ascolto su essa
handler_name = 'gatewayNetHandler';         % Nome handler gateway
handler_fnctn = 'gatewayNetHandler_fnctn';  % Funzione handler gateway
ttCreateHandler(handler_name, prio, handler_fnctn);     % Produce l'handler
ttAttachNetworkHandler(1, handler_name);    % Collega handler a rete 1