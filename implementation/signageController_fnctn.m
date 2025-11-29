function [exectime, data] = signageController_fnctn(segment, data)
switch segment
    % Caso in cui la segnaletica specifica l'assenza di un'infrazione
    case 1
        exectime = 0.005;
    % Caso in cui la segnaletica specifica la presenza di un'infrazione
    case 2
        fine = ttTryFetch('fine_signal');       % Segnale per multa
        flash = ttTryFetch('flash_signal');     % Segnale per lampeggianti
        points = ttTryFetch('points_signal');   % Segnale per punti
        % Caso in cui la multa non e' nulla
        if ~isempty(fine)
            ttAnalogOut(1, fine.info);          % Scrive info su canale 1
            ttAnalogOut(2, flash.info);         % Scrive info su canale 2
            ttAnalogOut(3, points.info);        % Scrive info su canale 3
        end
        exectime = -1;
end