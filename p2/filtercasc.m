% DSP Project 2 - Testing a Folk Theorem
% Dan Mezhiborsky <daniel.mezhiborsky@cooper.edu>
%
% filtercasc.m - Cascades discrete filter 50 times,
% returns filter, plots using plot_info for 5000 samples.

function filter_n50 = filtercasc(start, name)
    filter_n50 = start;
    % I tried doing this with a for loop and it was really slow
    for i = 1:49
       filter_n50 = dfilt.cascade(start, filter_n50); 
    end
    
    plot_info(filter_n50, name, 5000);
end

