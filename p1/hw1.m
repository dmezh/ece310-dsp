% Daniel Mezhiborsky
% ECE-310 DSP - MATLAB #1 Sample Rate Conversion
% hw1.m

% In this assignment, we were asked to write a sample rate conversion
% function capable of converting a 11025Hz sample rate audio file
% into a 24000Hz one.

% First, I tried to use a single-stage upsample -> LPF -> downsample.
% This was really slow (>1 minute on my computer). I switched to a multi-
% stage implementation where I first upsampled and LPF'd to an intermediate
% sample rate before upsampling and LPF'ing and downsampling again to the
% 24000Hz rate (2 stage). This was a lot faster and the audio file sounded
% like the original in both cases.

% I started looking into the polyphase implementation to try and gain some
% additional speed, and at that point I found upfirdn(), which sped up my
% calculations a lot. I tried different filter design methods, and
% ultimately, 'kaiserwin' with upfirdn() was very fast and met the
% requirements. I switched to single-stage again and this is the result -
% We upsample by L=320, LPF, and downsample by M=147. The computation is
% really fast and meets the spec (and the audio file sounds right).

in_11025 = audioread('Wagner.wav');
fprintf('Time to process Wagner.wav:\n');
out_24000 = srconvert(in_11025);
audiowrite('Wagner_24000.wav', out_24000, 24000);

fprintf('Time to process unit impulse:\n');
y = srconvert([1 zeros(1,3000)]);

if (verify(y))
    fprintf("srconvert passed verification :)\n");
else
    fprintf("srconvert failed verification :(\n");
end

