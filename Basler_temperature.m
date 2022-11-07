clc
clear 
close all
delete(imaqfind)

vid = videoinput('gentl', 1, 'Mono8');
src = getselectedsource(vid);

src.ExposureAuto = 'Continuous';
triggerconfig(vid,'manual');
src.DeviceLinkThroughputLimit = 300000000;
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
vid.ROIPosition = [1100 600 1400 1400];

start(vid);
trigger(vid);
cold_image = getdata(vid);
answer = questdlg('Start recording?', 'Recording', 'Yes', 'No', 'Yes');   
while answer == 'Yes'
    tic
    trigger(vid);
    img = getdata(vid);    
    result = abs(img-cold_image);
    imshow(result, "Colormap", turbo, 'DisplayRange', [0 70], 'Border', 'tight');
    toc
end
stop(vid);

%flipud(hot)
