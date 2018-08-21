function stopPreview(cameras)
% Pulled this out as a function so it can be called from elsewhere
% Note that this is calling case sensitive IMAQ function; probably need to
% change name of this wrapping function for clarity

for i=1:length(cameras)
    stoppreview(cameras(i));
end