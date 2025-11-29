function [exectime, data] = speedSensor_fnctn(segment, data)
persistent speed_packet;                % Variabile per pacchetti persi
switch segment
    % Caso con variabile precedente vuota
    case 1
        % Caso variabile per pacchetti persi vuota
        if isempty(speed_packet)
            speed_packet = 0;           % Variabile pacchetti persi nulla
            data.packet = 0;            % Packet posto pari a 0
        end
        data.info = ttAnalogIn(1);      % Legge da canale 1 e salva in info
        exectime = 0.05;
    % Caso senza pacchetti persi
    case 2
        data.type = 'speed_signal';     % Salva in type il segnale
        data.time = ttCurrentTime;      % Salva in time l'istante attuale
        ttAnalogOut(1, data.info);      % Scrive valore info sul canale 1
        ttSendMsg(4, data, 80);         % Invia speed al gateway
        exectime = 0.005;
    % Caso con pacchetti persi
    case 3
        speed_packet = speed_packet + 1;        % Aumenta perdite
        data.packet = speed_packet;     % Salva in packet le perdite
        data.type = 'spe_signal';       % Salva in type segnale per perdite
        ttAnalogOut(2, data.packet);    % Scrive valore packet sul canale 2
        ttSendMsg(4, data, 1000);       % Invia speed al gateway
        exectime = -1;
end