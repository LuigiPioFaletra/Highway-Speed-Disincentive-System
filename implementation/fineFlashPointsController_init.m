function fineFlashPointsController_init
ttInitKernel('prioFP');     % Kernel a scheduling con priorita' fissata
ttCreateMailbox('infringement_signal', 10)      % Mailbox per infrazione

% Creazione del task gestore della multa
name = 'fineFlashPointsController_task';        % Il nome del gestore
starttime = 1.0;    % Il tempo di partenza del funzionamento del gestore
period = 0.05;      % Il periodo di funzionamento del gestore
fnctn = 'fineFlashPointsController_fnctn';      % La funzione del gestore
ttCreatePeriodicTask(name, starttime, period, fnctn);   % Realizza il task
prio = 1;           % Priorita' associata all'attivita' del gestore
ttSetPriority(prio, name);  % Imposta la priorita' del task gestore

% Inizializzazione rete con nodo in ascolto su essa
handler_name = 'fineFlashPointsNetHandler';     % Nome handler rete
handler_fnctn = 'fineFlashPointsNetHandler_fnctn';  % Funzione handler rete
ttCreateHandler(handler_name, prio, handler_fnctn);     % Produce l'handler
ttAttachNetworkHandler(2, handler_name);        % Collega handler a rete 1