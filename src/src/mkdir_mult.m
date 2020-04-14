function [] = mkdir_mult(dirname)
    C = strsplit(dirname,'/')
    L = []
    for i = 1:length(C)
	      a = C{i}
	      L = fullfile(L,a)
        mkdir(L)
    end
end
