function [] = deldir(dossier)
    dossier = char(string(dossier));
    if isdir(dossier)
        system(['rm -r ',dossier]);
    end
end