function [] = delfile(fichier)
    fichier = char(string(fichier));
    if isfile(fichier)
        system(['rm ',fichier]);
    end
end