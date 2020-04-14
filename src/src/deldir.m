function [] = deldir(directory)

    % We check whether or not a given directory exists, and delete it if it
    % exists.
    
    directory = char(string(directory));
    if isdir(directory)
        system(['rm -r ',directory]);
    end
end