function uploadParams()
metadata = getappdata(0, 'metadata');

% Load enumerated variable indices into scope
% Enum is stored in struct
microControllerVariablesEnum;

% TODO: Need to refactor this part to make it easier to maintain
% Use same enumeration scheme as "refreshParams"
dataBuffer = zeros(1, length(fieldnames(uController)), 'uint16');   % Get fieldnames for number of enums because stored in struct

dataBuffer(uController.PRETIME) = metadata.cam(1).time(1);
dataBuffer(uController.POSTTIME) = metadata.cam(1).time(2);
if strcmpi(metadata.stim.type, 'puff')
    dataBuffer(uController.USDUR) = metadata.stim.p.puffdur;
    dataBuffer(uController.USNUM) = 3;    % This is the puff channel
elseif  strcmpi(metadata.stim.type, 'conditioning')
    dataBuffer(uController.CSNUM) = metadata.stim.c.csnum;
    dataBuffer(uController.CSDUR) = metadata.stim.c.csdur;
    dataBuffer(uController.USDUR) = metadata.stim.c.usdur;
    dataBuffer(uController.ISI) = metadata.stim.c.isi;
    if ismember(metadata.stim.c.csnum, [5, 6])
        dataBuffer(uController.TONEFREQ) = metadata.stim.c.cstone(metadata.stim.c.csnum - 4);
    end
    if ismember(metadata.stim.c.usnum, [5, 6])
        dataBuffer(uController.TONEFREQ) = metadata.stim.c.cstone(metadata.stim.c.usnum - 4);
    end
    dataBuffer(uController.USNUM) = metadata.stim.c.usnum;
    % dataBuffer(11) = metadata.stim.l.delay;
    % dataBuffer(12) = metadata.stim.l.dur;
    % dataBuffer(13) = metadata.stim.l.amp;
end

% ---- send data to microController ----
% TODO: Refactor micro controller communication to use handshake, etc
microController = getappdata(0, 'microController');
for i = 1:length(dataBuffer)
    fwrite(microController, i, 'int8');                  % header
    fwrite(microController, dataBuffer(i), 'int16');  % data
    % if mod(i, 4) == 0
    %     pause(0.010);
    % end
end