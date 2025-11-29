function signageController_init
ttInitKernel('prioFP');     % Kernel a scheduling con priorita' fissata
ttCreateMailbox('fine_signal', 10);             % Mailbox per multa
ttCreateMailbox('flash_signal', 10);            % Mailbox per lampeggianti
ttCreateMailbox('points_signal', 10);           % Mailbox per punti

% Creazione del task gestore della segnaletica
name = 'signageController_task';                % Il nome del gestore
starttime = 1.0;    % Il tempo di partenza del funzionamento del gestore
period = 0.05;      % Il periodo di funzionamento del gestore
fnctn = 'signageController_fnctn';              % La funzione del gestore
ttCreatePeriodicTask(name, starttime, period, fnctn);   % Realizza il task
prio = 1;           % La priorita' associata all'attivita' del gestore
ttSetPriority(prio, name);  % Imposta la priorita' del task gestore

% Inizializzazione rete con nodo in ascolto su essa
handler_name = 'signageNetHandler';             % Nome handler rete
handler_fnctn = 'signageNetHandler_fnctn';      % Funzione handler rete
ttCreateHandler(handler_name, prio, handler_fnctn);     % Produce l'handler
ttAttachNetworkHandler(2, handler_name);        % Collega handler a rete 1