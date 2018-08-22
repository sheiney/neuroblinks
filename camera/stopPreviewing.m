function stopPreviewing(cameras)
% Pulled this out as a function so it can be called from elsewhere

for i=1:length(cameras)
    stoppreview(cameras(i));
end