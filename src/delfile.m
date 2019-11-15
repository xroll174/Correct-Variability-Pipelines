function [] = delfile(file)

    % We check whether or not a given filename exists, and delete the file
    % if it exists.
    
    file = char(string(file));
    if isfile(file)
        system(['rm ',file]);
    end
end