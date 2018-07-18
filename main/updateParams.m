function updateParams()
metadata = getappdata(0, 'metadata');

% Need to refactor this part to make it easier to maintain
datatoarduino = zeros(1, 13);

datatoarduino(3) = metadata.cam(1).time(1);
datatoarduino(9) = metadata.cam(1).time(2);
if strcmpi(metadata.stim.type, 'puff')
    datatoarduino(6) = metadata.stim.p.puffdur;
    datatoarduino(10) = 3;    % This is the puff channel
elseif  strcmpi(metadata.stim.type, 'conditioning')
    datatoarduino(4) = metadata.stim.c.csnum;
    datatoarduino(5) = metadata.stim.c.csdur;
    datatoarduino(6) = metadata.stim.c.usdur;
    datatoarduino(7) = metadata.stim.c.isi;
    if ismember(metadata.stim.c.csnum, [5, 6])
        datatoarduino(8) = metadata.stim.c.cstone(metadata.stim.c.csnum - 4);
    end
    if ismember(metadata.stim.c.usnum, [5, 6])
        datatoarduino(8) = metadata.stim.c.cstone(metadata.stim.c.usnum - 4);
    end
    datatoarduino(10) = metadata.stim.c.usnum;
    datatoarduino(11) = metadata.stim.l.delay;
    datatoarduino(12) = metadata.stim.l.dur;
    datatoarduino(13) = metadata.stim.l.amp;
end

% ---- send data to arduino ----
arduino = getappdata(0, 'arduino');
for i = 3:length(datatoarduino)
    fwrite(arduino, i, 'int8');                  % header
    fwrite(arduino, datatoarduino(i), 'int16');  % data
    if mod(i, 4) == 0
        pause(0.010);
    end
end