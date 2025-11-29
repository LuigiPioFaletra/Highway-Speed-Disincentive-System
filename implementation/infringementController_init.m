function infringementController_init
ttInitKernel('prioFP');     % Kernel a scheduling con priorita' fissata
ttCreateMailbox('speed_signal', 10);            % Mailbox per velocita'
ttCreateMailbox('weight_signal', 10);           % Mailbox per peso
ttCreateMailbox('displacement_signal', 10);     % Mailbox per cilindrata

% Creazione del task gestore dell'infrazione
name = 'infringementController_task';           % Il nome del gestore
starttime = 1.0;    % Il tempo di partenza del funzionamento del gestore
period = 0.05;      % Il periodo di funzionamento del gestore
fnctn = 'infringementController_fnctn';         % La funzione del gestore
ttCreatePeriodicTask(name, starttime, period, fnctn);   % Realizza il task
prio = 1;           % Priorita' associata all'attivita' del gestore
ttSetPriority(prio, name);  % Imposta la priorita' del task gestore

% Inizializzazione rete con nodo in ascolto su essa
handler_name = 'infringementNetHandler';        % Nome handler rete
handler_fnctn = 'infringementNetHandler_fnctn';     % Funzione handler rete
ttCreateHandler(handler_name, prio, handler_fnctn);     % Produce l'handler
ttAttachNetworkHandler(2, handler_name);        % Collega handler a rete 1