% DSP Project 2 - Testing a Folk Theorem
% Dan Mezhiborsky <daniel.mezhiborsky@cooper.edu>
%
% p2.m - Primary project runner

load projIA

filter_n1 = dfilt.df1(b, a);
plot_info(filter_n1, "N=1", 100);

audio_n1_filtered = filter(filter_n1, speech);
soundsc(audio_n1_filtered, fs)
pause(3.0)
% no audible distortion

filter_n50 = filtercasc(filter_n1, "N=50, df1");

audio_n50_filtered = filter(filter_n50, speech);
soundsc(audio_n50_filtered, fs)
% lots of audible distortion, seems almost like
% an echo or a warbling noise. The primary cause 
% of this is the filter's phase distortion, which is not
% noticable when the filter is applied only once,
% but is way more noticable when the filter is applied
% 50 times.

[sos,g] = tf2sos(b,a);
filtercasc(dfilt.df1sos(sos), "N=50, df1sos");
filtercasc(dfilt.df2sos(sos), "N=50, df2sos");
filtercasc(dfilt.df2tsos(sos), "N=50, df2tsos");

fprintf("Done!\n");

