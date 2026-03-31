function mkhtmltable(tabledata,tablename,tableformat,tablecaption)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[nrow,ncol] = size(tabledata);

% Open file for writing
fid = fopen(tablename,'w');

fprintf(fid,'<table>\n');

% fprintf(fid,'\\centering\n');

% fprintf(fid,'\\footnotesize\n');

fprintf(fid,['<caption> ' tablecaption ' </caption>\n']);

% fprintf(fid,['\\label{' tablelbl '}\n']);

% fprintf(fid,'\\begin{tabular}{m{0.25\\linewidth} c c c c}\n');
% fprintf(fid,['\\begin{tabular}{' colformat '}\n']);

% fprintf(fid,'\\toprule\n');

for irow = 1:nrow
    
    if irow == 1
        
        fprintf(fid,'<thead>\n');
        fprintf(fid,'<tr>\n');
        
        for icol = 1:ncol-1
            
            fprintf(fid,'<th scope="col"> %s </th> ',num2str(tabledata{irow,icol}));
            
        end
        
        fprintf(fid,'<th scope="col"> %s </th>',num2str(tabledata{irow,ncol}));
        fprintf(fid,'</tr>\n');
        fprintf(fid,'</thead>\n');
        fprintf(fid,'<tbody>\n');
        
    else
        
        fprintf(fid,'<tr>\n');
        
        for icol = 1:ncol-1
            
            if icol == 1
                
                fprintf(fid,['<th scope="row"> ' tableformat{icol} ' </th> '],num2str(tabledata{irow,icol}));
                
            else
                
                fprintf(fid,['<td> ' tableformat{icol} ' </td> '],tabledata{irow,icol});
                
            end
            
        end
        
        fprintf(fid,['<td> ' tableformat{ncol} ' </td> '],tabledata{irow,ncol});
        fprintf(fid,'</tr>\n');
        
    end
    
    if irow == nrow
        
        fprintf(fid,'</tbody>\n');
        
    end
    
end

fprintf(fid,'</table>\n');

fclose(fid);

end
