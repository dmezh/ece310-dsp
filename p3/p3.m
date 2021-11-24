% DSP Project 3 - Enhancing Speech by Removing Noise
% Dan Mezhiborsky <daniel.mezhiborsky@cooper.edu>
%
% p3.m - primary project runner

load projIB

%soundsc(noisy, fs)
b = getCheby2();
%clean = b(noisy);
%soundsc(clean, fs)
%h = fvtool(b);

Fpass_edge = 2500;
Fstop_edge = 4000;
Gpb_max = 40;
Gpb_min = 37;
Gsb_max = -55;

Rpb_max = Gpb_max - Gpb_min; % passband ripple
Gsb = Gpb_min - Gsb_max; % actual min stopband attenuation

Fpass = 2500;   % Passband Frequency
Fstop = 4000;   % Stopband Frequency
Apass = 3;      % Passband Ripple (dB)
Astop = 92;     % Stopband Attenuation (dB)
Fs    = 44100;  % Sampling Frequency

%%% p-m / equiripple
[n, fo, ao, w] = ...
    firpmord([Fpass_edge Fstop_edge], [1 0], [0.11, 0.000015], fs);
b = firpm(n, fo, ao, w);
fvtool(b, 1);

%soundsc(filter(b, 1, noisy), fs);

%%% shit
h = fdesign.lowpass('fp,fst,ap,ast', Fpass, Fstop, Apass, Astop, Fs);

f_types = [
    "butter", "cheby1", "cheby2", "ellip", "equiripple", "kaiserwin"];

filters = {};
for i = 1:length(f_types)
    Hd = design(h, f_types(i), 'SystemObject', true);
    filters{end+1} = Hd; % changes size but we only have 6 filters
end

for i = 1:length(filters)
    f = filters{i}
    soundsc(f(noisy), fs)
    pause(3.5)
end
    
