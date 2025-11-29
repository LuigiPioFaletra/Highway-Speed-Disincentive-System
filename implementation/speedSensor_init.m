function speedSensor_init
ttInitKernel('prioFP');     % Kernel a scheduling con priorita' fissata
ttSetKernelParameter('energyconsumption', 0.010);       % Consumo a 10 mW
clear speedSensor_fnctn;            % Rimuove variabili e libera memoria

% Creazione del task sensore della velocita'
name = 'speedSensor_task';                  % Il nome del sensore
starttime = 1.0;    % Il tempo di partenza del funzionamento del sensore
period = 0.5;       % Il periodo di funzionamento del sensore
fnctn = 'speedSensor_fnctn';                % La funzione del sensore
ttCreatePeriodicTask(name, starttime, period, fnctn);   % Realizza il task
prio = 1;           % La priorita' associata all'attivita' del sensore
ttSetPriority(prio, name);   % Imposta la priorita' del task sensore