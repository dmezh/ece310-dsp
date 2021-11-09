% DSP Project 2 - Testing a Folk Theorem
% Dan Mezhiborsky <daniel.mezhiborsky@cooper.edu>
%
% plot_info.m - plots impulse, magnitude of frequency
% responses and group delay for given number of samples.

function plot_info(f, name, samples)
    figure

    subplot(3, 1, 1)
    [h, t] = impz(f, samples);
    stem(t, h)
    title("Impulse response")

    subplot(3, 1, 2)
    [h, w] = freqz(f, samples);
    plot(w/pi, 20*log10(abs(h)))
    title("Magnitude of frequency response")

    subplot(3, 1, 3)
    gd = grpdelay(f, samples);
    plot(w/pi, gd)
    title("Group delay")
    
    sgtitle("Plots for " + name)
    
    zplane(f)
    grid
    title("Poles and Zeros for " + name)
end

