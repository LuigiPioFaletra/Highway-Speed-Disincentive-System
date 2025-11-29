function [exectime, data] = gateway_fnctn(segment, data)
persistent lose_s;          % Variabile per pacchetti velocita' persi
persistent s_packet;        % Variabile per pacchetti velocita' ricevuti
persistent lose_w;          % Variabile per pacchetti peso persi
persistent w_packet;        % Variabile per pacchetti peso ricevuti
persistent lose_d;          % Variabile per pacchetti cilindrata persi
persistent d_packet;        % Variabile per pacchetti cilindrata ricevuti
switch segment
    % Caso con pacchetti persi o con variabili precedenti vuote
    case 1
        % Caso variabile per pacchetti velocita' persi vuota
        if isempty(lose_s)
            lose_s = 0;     % Variabile pacchetti velocita' persi nulla
            s_packet = 0;   % Variabile pacchetti velocita' ricevuti nulla
        end
        % Caso variabile per pacchetti peso persi vuota
        if isempty(lose_w)
            lose_w = 0;     % Variabile pacchetti peso persi nulla
            w_packet = 0;   % Variabile pacchetti peso ricevuti nulla
        end
        % Caso variabile per pacchetti cilindrata persi vuota
        if isempty(lose_d)
            lose_d = 0;     % Variabile pacchetti cilindrata persi nulla
            d_packet = 0;   % Variabile pacchetti cilindrata ricevuti nulla
        end
        spe = ttTryFetch('spe_signal');     % Perdite pacchetti velocita' 
        wei = ttTryFetch('wei_signal');     % Perdite pacchetti peso
        dis = ttTryFetch('dis_signal');     % Perdite pacchetti cilindrata
        % Caso di presenza di perdite per pacchetti velocita'
        if ~isempty(spe)
            ttAnalogOut(4, spe.packet);     % Scrive packet sul canale 4
            % Caso di corretta ricezione di ogni pacchetto velocita'
            if s_packet ~= spe.packet - 1
                lose_s = lose_s + (spe.packet - s_packet) - 1;  % Aumenta
            end
            s_packet = spe.packet;      % Uguaglia ricevuti a packet
            ttAnalogOut(5, lose_s);     % Scrive numero persi sul canale 5
            time_s = ttCurrentTime - spe.time;      % Istante per delay
            ttAnalogOut(1, time_s);     % Scrive delay sul canale 1
        end
        % Caso di presenza di perdite per pacchetti peso
        if ~isempty(wei)
            ttAnalogOut(6, wei.packet);     % Scrive packet sul canale 6
            % Caso di corretta ricezione di ogni pacchetto peso
            if w_packet ~= wei.packet - 1
                lose_w = lose_w + (wei.packet - w_packet) - 1;  % Aumenta
            end
            w_packet = wei.packet;      % Uguaglia ricevuti a packet
            ttAnalogOut(7, lose_w);     % Scrive numero persi sul canale 7
            time_w = ttCurrentTime - wei.time;      % Istante per delay
            ttAnalogOut(2, time_w);     % Scrive delay sul canale 2
        end
        % Caso di presenza di perdite per pacchetti cilindrata
        if ~isempty(dis)
            ttAnalogOut(8, dis.packet);     % Scrive packet sul canale 8
            % Caso di corretta ricezione di ogni pacchetto cilindrata
            if d_packet ~= dis.packet - 1
                lose_d = lose_d + (dis.packet - d_packet) - 1;  % Aumenta
            end
            d_packet = dis.packet;      % Uguaglia ricevuti a packet
            ttAnalogOut(9, lose_d);     % Scrive numero persi sul canale 9
            time_d = ttCurrentTime - dis.time;      % Istante per delay
            ttAnalogOut(3, time_d);     % Scrive delay sul canale 3
        end
        exectime = 0.08;
    % Caso senza pacchetti persi
    case 2
        s = ttTryFetch('speed_signal');         % Velocita' senza perdite
        w = ttTryFetch('weight_signal');        % Peso senza perdite
        d = ttTryFetch('displacement_signal');  % Cilindrata senza perdite
        % Caso di corretta ricezione di tutti i pacchetti velocita'
        if ~isempty(s)
            ttSendMsg([2 2], s, 3);     % Invia velocita' ad handler
        end
        % Caso di corretta ricezione di tutti i pacchetti peso
        if ~isempty(w)
            ttSendMsg([2 2], w, 3);     % Invia peso ad handler
        end
        % Caso di corretta ricezione di tutti i pacchetti cilindrata
        if ~isempty(d)
            ttSendMsg([2 2], d, 3);     % Invia cilindrata ad handler
        end
        exectime = 0.05;
    case 3
        exectime = -1;
end