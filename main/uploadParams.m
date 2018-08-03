function uploadParams()
metadata = getappdata(0, 'metadata');

% TODO: Need to refactor this part to make it easier to maintain
% Use same enumeration scheme as "refreshParams"
dataBuffer = zeros(1, 13);

dataBuffer(3) = metadata.cam(1).time(1);
dataBuffer(9) = metadata.cam(1).time(2);
if strcmpi(metadata.stim.type, 'puff')
    dataBuffer(6) = metadata.stim.p.puffdur;
    dataBuffer(10) = 3;    % This is the puff channel
elseif  strcmpi(metadata.stim.type, 'conditioning')
    dataBuffer(4) = metadata.stim.c.csnum;
    dataBuffer(5) = metadata.stim.c.csdur;
    dataBuffer(6) = metadata.stim.c.usdur;
    dataBuffer(7) = metadata.stim.c.isi;
    if ismember(metadata.stim.c.csnum, [5, 6])
        dataBuffer(8) = metadata.stim.c.cstone(metadata.stim.c.csnum - 4);
    end
    if ismember(metadata.stim.c.usnum, [5, 6])
        dataBuffer(8) = metadata.stim.c.cstone(metadata.stim.c.usnum - 4);
    end
    dataBuffer(10) = metadata.stim.c.usnum;
    dataBuffer(11) = metadata.stim.l.delay;
    dataBuffer(12) = metadata.stim.l.dur;
    dataBuffer(13) = metadata.stim.l.amp;
end

% ---- send data to microController ----
% TODO: Refactor micro controller communication to use handshake, etc
microController = getappdata(0, 'microController');
for i = 3:length(dataBuffer)
    fwrite(microController, i, 'int8');                  % header
    fwrite(microController, dataBuffer(i), 'int16');  % data
    % if mod(i, 4) == 0
    %     pause(0.010);
    % end
end