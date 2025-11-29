function [exectime, data] = gatewayNetHandler_fnctn(~, data)
temp = ttGetMsg(1);                 % Riceve un messaggio dalla rete 1
% Caso di corretta ricezione del messaggio
if ~isempty(temp)
    ttTryPost(temp.type, temp);     % Invia un messaggio ad una mailbox
    ttCreateJob('gateway_task');    % Fa' partire il task del gateway
end
exectime = -1;