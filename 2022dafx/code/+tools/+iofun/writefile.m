function suc = writefile(fdata,fname)
%WRITEFILE Write data to file.
%   SUC = WRITEFILE(FDATA,FNAME) writes FDATA to the file FNAME. SUC is a
%   logical flag that is TRUE is file write operation was successful or
%   FALSE otherwise. FDATA is assumed to be a string scalar with all the
%   data to write and FNAME is assumed to be a valid path to a .txt file.
%
%   WRITEFILE is a shorthand to fopen, fprintf, fclose.
%
%   See also

% 2020 MCaetano SMT 0.3.0

% TODO: CHECK THAT FNAME EXISTS (OR WRITE FOLDERS)
% TODO: ALLOW OTHER DATA TYPES? (Maybe best to create different functions
% for different data types. E.g., writetxt, writemat, etc and

% Open input file
fileID = fopen(fname,'w');

% Write data to file
fprintf(fileID,'%s',fdata);

% Close file
writeflag = fclose(fileID);

% Function output
if writeflag == 0
    
    suc = true;
    
elseif writeflag == -1
    
    suc = false;
    
end

end
