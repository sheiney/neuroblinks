function savetrial()
% Load objects from root app data
camera=getappdata(0, 'camera');

% 4096 counts = 1 revolution = 15.24*pi cm for 6 inch diameter cylinder
counts2cm = @(count) double(count) ./ 4096 .* 15.24 .* pi; 

% pause(1e-3)
[vid, vid_ts] = getdata(camera, camera.FramesPerTrigger*(camera.TriggerRepeat + 1));
% pause(1e-3)

online_bhvana(vid);
metadata = getappdata(0, 'metadata');

% pause(1e-3)
setappdata(0, 'lastvid', vid);
setappdata(0, 'lastmetadata', metadata);

% Get encoder data from Arduino
if isappdata(0, 'arduino')
  arduino = getappdata(0, 'arduino');

  if arduino.BytesAvailable > 0
    fread(arduino, arduino.BytesAvailable); % Clear input buffer
  end

  fwrite(arduino, 2, 'uint8');  % Tell Arduino we're ready for it to send the data

  data_header = (fread(arduino, 1, 'uint8'));
  if data_header == 100
    encoder.counts = (fread(arduino, 200, 'int32'));
    encoder.displacement = counts2cm(encoder.counts - encoder.counts(1));
  end

  time_header = (fread(arduino, 1, 'uint8'));
  if time_header == 101
    encoder.time = (fread(arduino, 200, 'uint32'));
    encoder.time = encoder.time - encoder.time(1);
  end

end

videoname = sprintf('%s\\%s_%03d', metadata.folder, metadata.basename, metadata.cam.trialnum);
if trials.savematadata
    save(videoname, 'metadata')
elseif exist('encoder', 'var')
    save(videoname, 'vid', 'vid_ts', 'metadata', 'encoder', '-v6')
else
    save(videoname, 'vid', 'vid_ts', 'metadata', '-v6')
end

fprintf('Video data from trial %03d successfully written to disk.\n', metadata.cam.trialnum)


% --- trial counter updated and saved in memory ---
metadata.cam.trialnum = metadata.cam.trialnum + 1;

setappdata(0, 'metadata', metadata);