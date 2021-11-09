% Daniel Mezhiborsky
% ECE-310 DSP - MATLAB #1 Sample Rate Conversion
% srconvert.m

function out_24000hz = srconvert(in_11025hz)
    % L, M = num/denom for 11025/24000 reduced
    L = 320;
    M = 147;
    h = designfilt(...
            'lowpassfir', ...
            'PassbandFrequency', 1/L, ...
            'StopbandFrequency', 1.2/L, ...
            'StopbandAttenuation', 71.2, ... % misses the mark a little so we need to say 71.2
            'PassbandRipple', 0.1, ... % doesn't really seem to matter (we get 0.002dB)
            'DesignMethod', 'kaiserwin' ... % decent
        );
    h_c = L * tf(h);
    
    tic
        out_24000hz = upfirdn(in_11025hz, h_c, L, M); % speedy! this is polyphase.
    toc
end

