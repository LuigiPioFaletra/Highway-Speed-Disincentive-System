function [exectime, data] = displacementSensor_fnctn(segment, data)
persistent displacement_packet;         % Variabile per pacchetti persi
switch segment
    % Caso con variabile precedente vuota
    case 1
        % Caso variabile per pacchetti persi vuota
        if isempty(displacement_packet)
            displacement_packet = 0;    % Variabile pacchetti persi nulla
            data.packet = 0;            % Packet posto pari a 0
        end
        data.info = ttAnalogIn(1);      % Legge da canale 1 e salva in info
        exectime = 0.05;
    % Caso senza pacchetti persi
    case 2
        data.type = 'displacement_signal';     % Salva in type il segnale
        data.time = ttCurrentTime;      % Salva in time l'istante attuale
        ttAnalogOut(1, data.info);      % Scrive valore info sul canale 1
        ttSendMsg(4, data, 80);         % Invia disp al gateway
        exectime = 0.005;
    % Caso con pacchetti persi
    case 3
        displacement_packet = displacement_packet + 1;  % Aumenta perdite  
        data.packet = displacement_packet;     % Salva in packet le perdite
        data.type = 'dis_signal';       % Salva in type segnale per perdite
        ttAnalogOut(2, data.packet);    % Scrive valore packet sul canale 2
        ttSendMsg(4, data, 1000);       % Invia disp al gateway
        exectime = -1;
end