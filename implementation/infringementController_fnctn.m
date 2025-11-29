function [exectime, data] = infringementController_fnctn(segment, data)
switch segment
    % Caso di infrazione non commessa
    case 1
        exectime = 0.005;
    % Caso di infrazione commessa
    case 2
        s = ttTryFetch('speed_signal');         % Velocita' senza perdite
        w = ttTryFetch('weight_signal');        % Peso senza perdite
        d = ttTryFetch('displacement_signal');  % Cilindrata senza perdite
        % Caso di corretta ricezione di tutti i pacchetti velocita'
        if ~isempty(s)
            ttAnalogOut(1, s.info);             % Scrive info sul canale 1
        end
        % Caso di corretta ricezione di tutti i pacchetti peso
        if ~isempty(w)
            ttAnalogOut(2, w.info);             % Scrive info sul canale 2
        end
        % Caso di corretta ricezione di tutti i pacchetti cilindrata
        if ~isempty(d)
            ttAnalogOut(3, d.info);             % Scrive info sul canale 3
        end
        infr.info = ttAnalogIn(1);              % Legge info dal canale 1
        % Caso in cui la lettura e' andata a buon fine
        if ~isempty(infr)
            infr.type = 'infringement_signal';  % Segnale in type
            ttSendMsg(3, infr, 80);         % Invia infrazione ad handler
        end
        exectime = -1;
end