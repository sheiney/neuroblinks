function savetrial()

% For encoder
% 4096 counts = 1 revolution = 15.24*pi cm for 6 inch diameter cylinder
counts2cm = @(count) double(count) ./ 4096 .* 15.24 .* pi; 

% Load objects from root app data
cameras=getappdata(0, 'cameras');
metadata = getappdata(0, 'metadata');

setappdata(0, 'lastmetadata', metadata);

% Get encoder data from microController
if isappdata(0, 'microController')
  microController = getappdata(0, 'microController');

  if microController.BytesAvailable > 0
    fread(microController, microController.BytesAvailable); % Clear input buffer
  end

  fwrite(microController, 2, 'uint8');  % Tell microController we're ready for it to send the data

  data_header = (fread(microController, 1, 'uint8'));
  if data_header == 100
    encoder.counts = (fread(microController, 200, 'int32'));
    encoder.displacement = counts2cm(encoder.counts - encoder.counts(1));
  end

  time_header = (fread(microController, 1, 'uint8'));
  if time_header == 101
    encoder.time = (fread(microController, 200, 'uint32'));
    encoder.time = encoder.time - encoder.time(1);
  end

end

% Get videos from cameras
for i=1:length(cameras)

  if strcmp(cameras{i}.Running, 'on')
    stop(cameras{i})
  end

  acquiredFrameDiff = cameras{i}.FramesAvailable < cameras{i}.FramesPerTrigger * (cameras{i}.TriggerRepeat + 1);
  if acquiredFrameDiff > 0
      warning('There is a difference of %d between the number of frames you expected and the number that were acquired', acquiredFrameDiff)
  end

  [vid, vid_ts] = getdata(cameras{i}, cameras{i}.FramesAvailable);

  % Keep data from last trial in memory even if we don't save it to disk
  setappdata(0, sprintf('lastvid%d', i), vid);

  videoname = sprintf('%s\\%s_cam%d_%03d', metadata.folder, metadata.basename, i, metadata.cam(i).trialnum);
  if exist('encoder', 'var')
      save(videoname, 'vid', 'vid_ts', 'metadata', 'encoder', '-v6')
  else
      save(videoname, 'vid', 'vid_ts', 'metadata', '-v6')
  end

  metadata.cam(i).trialnum = metadata.cam(i).trialnum + 1;

end

% online_bhvana(vid);

setappdata(0, 'metadata', metadata);

fprintf('Video data from trial %03d successfully written to disk.\n', metadata.cam(1).trialnum)