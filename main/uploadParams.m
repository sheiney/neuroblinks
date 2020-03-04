function ok = uploadParams(metadata)

config = getappdata(0, 'config');

ok = 0; % Flag changed to 1 when function successfully completes

% Load enumerated variable indices into scope
% Enum is stored in struct
microControllerVariablesEnum;

stim_code = device2fieldname(config.stim.device);

% TODO: Need to refactor this part to make it easier to maintain
% Use same enumeration scheme as "refreshParams"
dataBuffer = zeros(1, length(fieldnames(uController)), 'int16');   % Get fieldnames for number of enums because stored in struct

dataBuffer(uController.PRETIME) = metadata.cam(1).time(1);
dataBuffer(uController.POSTTIME) = metadata.cam(1).time(2);
if strcmpi(metadata.stim.type, 'puff')
    dataBuffer(uController.USDUR) = metadata.stim.p.puffdur;
    dataBuffer(uController.USNUM) = 3;    % This is the puff channel
elseif  strcmpi(metadata.stim.type, 'conditioning')
    dataBuffer(uController.CSNUM) = metadata.stim.c.csnum;
    dataBuffer(uController.CSDUR) = metadata.stim.c.csdur;
    dataBuffer(uController.CSINT) = round(metadata.stim.c.csintensity * (2^config.PWM_RESOLUTION - 1));     % Scale to full analogWrite units
    dataBuffer(uController.USDUR) = metadata.stim.c.usdur;
    dataBuffer(uController.ISI) = metadata.stim.c.isi - config.tube_delay(config.rig);
    if ismember(metadata.stim.c.csnum, [5, 6])
        dataBuffer(uController.TONEFREQ) = metadata.stim.c.cstone(metadata.stim.c.csnum - 4);
    end
    if ismember(metadata.stim.c.usnum, [5, 6])
        dataBuffer(uController.TONEFREQ) = metadata.stim.c.cstone(metadata.stim.c.usnum - 4);
    end
    dataBuffer(uController.USNUM) = metadata.stim.c.usnum;

    % Note that in this version only electrical stimulation is supported and the pulse train generation is handled by the PulsePal so we only send delay and train duration to generate the PulsePal trigger pulse
    % dataBuffer(uController.STIMDEVICE) = stim_code;     % Char sent as ASCII code (uint8)
    dataBuffer(uController.STIMDELAY) = metadata.stim.(stim_code).delay;
    dataBuffer(uController.STIMTRAINDUR) = metadata.stim.(stim_code).train_dur;
    % dataBuffer(uController.STIMPULSEDUR) = metadata.stim.(stim_code).pulse_dur;
    % dataBuffer(uController.STIMFREQ) = metadata.stim.(stim_code).freq;
    % dataBuffer(uController.STIMAMP) = metadata.stim.(stim_code).amp;
end

% ---- send data to microController ----
% TODO: Refactor micro controller communication to use handshake, etc
microController = getappdata(0, 'microController');
for i = 1:length(dataBuffer)
    try
        % Note that the following code as written is inefficient because it writes a lot of empty data--need to only cycle through dataBuffer indices with values
        fwrite(microController, i, 'uint8');              % header
        fwrite(microController, dataBuffer(i), 'int16');  % data
    catch
        warning('Problem writing data to microcontroller: Index=%d, Value=%d\n', i, dataBuffer(i))
        return
    end
    % if mod(i, 4) == 0
    %     pause(0.010);
    % end
end

% Send parameters to PulsePal, if connected

if config.pulsepal.connected

    % Note that all times are suppled to PulsePal in seconds

    global PulsePalSystem;

    voltage_scale = 100;            % Assume using 100 uA setting on stim isolation unit knob

    % Use shorter variable names to improve readability below
    train_dur = metadata.stim.(stim_code).train_dur;
    pulse_dur = metadata.stim.(stim_code).pulse_dur;
    freq = metadata.stim.(stim_code).freq;
    current = metadata.stim.(stim_code).amp;

    % Default to output channel 1
    PulsePalSystem.Params.InterPhaseInterval(1) = 0;
    PulsePalSystem.Params.PulseTrainDelay(1) = 0;        % Note that actual delay is set in Neuroblinks microcontroller and already accounted for in trigger pulse so we set zero here
    PulsePalSystem.Params.PulseTrainDuration(1) = train_dur .* 1e-3; 

    % Assume biphasic pulses for simplicity now (that's what I always use)
    PulsePalSystem.Params.IsBiphasic(1) = 1;
    PulsePalSystem.Params.Phase1Duration(1) = pulse_dur .* 1e-6;
    PulsePalSystem.Params.Phase2Duration(1) = pulse_dur .* 1e-6;
    PulsePalSystem.Params.InterPulseInterval(1) = 1./freq - (2.*pulse_dur.*1e-6);
    PulsePalSystem.Params.Phase1Voltage(1) = 10 .* (current / voltage_scale);
    PulsePalSystem.Params.Phase2Voltage(1) = -10 .* (current / voltage_scale);

    % Use TTL sync pulse to trigger
    PulsePalSystem.Params.LinkTriggerChannel1 = 1;          % Read sync pulse from trig channel 1
    PulsePalSystem.Params.TriggerMode = 0;                  % 0 = normal (trigger on pulse onset), 1 = toggle (alternating pulses on and off), 2 = pulse gated

    ok = SyncPulsePalParams;

    if ~ok
        % How should we warn user if parameters didn't sync to PulsePal--should we stop program flow to a trial doesn't start?

    end

end

ok = 1;