function fullList = recurslistdir(dirPath,niter)

for iter = 1:niter
    
    if iter == 1
        
        dirlist = listdir(dirPath);
        
    else
        
        mocklist = {};
        
        ndir = size(dirlist,1);
        
        for ind = 1:ndir
            
            partial = listdir(dirlist{ind,:});
            mocklist = [mocklist;partial];
            
        end
        
        dirlist = mocklist;
        
    end
    
end

fullList = dirlist;
% End of main function
end

function list = listdir(dirPath)

dirlist = dir(dirPath);

[ndir,~] = size(dirlist);

list = cell(ndir,1);

for idir = 1:ndir
    
    % If DIRLIST(idir) is dir and not '.' nor '..'
    if dirlist(idir).isdir && ~any(strcmp(dirlist(idir).name,["." ".."]))
        
        % Add to list
        list{idir} = fullfile(dirPath,dirlist(idir).name);
        
    end
    
end

bool = ~isempty(list);

list = list(bool);

%End of private function
end
