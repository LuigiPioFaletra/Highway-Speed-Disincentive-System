function [exectime, data] = fineFlashPointsController_fnctn(segment, data)
switch segment
    % Caso di generazione non necessaria della multa
    case 1
        exectime = 0.005;
    % Caso di generazione necessaria della multa
    case 2
        fine.info = ttAnalogIn(1);      % Legge dal canale 1 la multa
        flash.info = ttAnalogIn(2);     % Legge dal canale 2 i lampeggianti
        points.info = ttAnalogIn(3);    % Legge dal canale 3 i punti
        % Caso in cui la multa non e' nulla
        if ~isempty(fine)
            fine.type = 'fine_signal';          % Segnale per multa
            flash.type = 'flash_signal';        % Segnale per lampeggianti
            points.type = 'points_signal';      % Segnale per punti
            ttSendMsg(4, fine, 80);         % Invia multa ad handler
            ttSendMsg(4, flash, 80);        % Invia lampeggianti ad handler
            ttSendMsg(4, points, 80);       % Invia punti ad handler
        end
        infringement = ttTryFetch('infringement_signal');   % Presa segnale
        % Caso di cattura corretta del segnale per infrazione
        if ~isempty(infringement)
            ttAnalogOut(1, infringement.info);  % Scrive info sul canale 1
        end
        exectime = -1;
end