function [exectime, data] = fineFlashPointsNetHandler_fnctn(~, data)
temp = ttGetMsg(2);                 % Riceve un messaggio dalla rete 2
% Caso di corretta ricezione del messaggio
if ~isempty(temp)
    ttTryPost(temp.type, temp);     % Invia un messaggio ad una mailbox
end
exectime = -1;