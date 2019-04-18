clear;clc;

houseParty = 0;
convolution = 1;
choppedAndScrewed = 0;
vocalIsolation = 0;
beatMaker = 0;
audioVisualizer = 0;


song = 'Wonderwall.mp3';
IR = 'BigHallIR.wav';
outputName = 'WonderwallResponse.wav';

%import audio
[in, Fs] = audioread(song);

if (convolution == 1)
    %import impulse response
    h = audioread(IR);
    
    %convolve
    out = fconv(in, h);
    
    player = audioplayer(out, Fs);
    audiowrite(outputName,out,Fs);
    play(player)
    
elseif (houseParty == 1)
    % Make a Low-pass filter
    %set cutoff frequency
    fc = 500;
    
    % Design a Butterworth filter.
    [b, a] = butter(10,fc/(Fs/2));
    
    % Apply the Butterworth filter.
    filteredSignal = filter(b, a, in);
    
    % Play the sound.
    player = audioplayer(filteredSignal, Fs);
    audiowrite(outputName,filteredSignal,Fs);
    play(player);
    
elseif (choppedAndScrewed == 1)
    player = audioplayer(in, 35000);
    audiowrite(outputName,in,35000);
    play(player);
    
elseif (vocalIsolation == 1)
    % Make a high-pass filter
    %set cutoff frequency
    fc = 2000;
    
    % Design a Butterworth filter.
    [b, a] = butter(6,fc/(Fs/2), 'high');
    
    % Apply the Butterworth filter.
    filteredSignal = filter(b, a, in);
    
    filteredSignal = filteredSignal .* 10^(15/20);
    
    % Play the sound.
    player = audioplayer(filteredSignal, Fs);
    play(player);
    
elseif (beatMaker == 1)
    recObj = audiorecorder(44100, 16, 2);
    disp('Start speaking.')
    recordblocking(recObj, 1);
    disp('End of Recording.');
    for c = 1:7
        play(recObj);
        pause(1);
    end
    y = getaudiodata(recObj);
    
    player = audioplayer(y, Fs);
    play(player);
    
elseif (audioVisualizer == 1)
    recObj = audiorecorder(44100, 16, 2);
    while 1
        recordblocking(recObj, 1);
        y = getaudiodata(recObj);
        plot(y);
        axis([0 2048 -1 1]);
        drawnow;
    end
    
else
    player = audioplayer(in, Fs);
    play(player);
end
