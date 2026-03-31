function mklatextable(tabledata,tableformat,colformat,tablename,tablecaption,tablelbl)
%MKLATEXTABLE
%   TABLEDATA: matlab cell array or table
%   TABLENAME: full path to txt file
%   TABLEFORMAT: {'\\textbf{%s}';'%1.0f';'%1.0f'};
%   TABLECAPTION: '\\itshape Table caption.'
%   TABLELBL: 'tab:err_zpad'
%   COLFORMAT: 'm{0.35\\linewidth} c c'

[nrow,ncol] = size(tabledata);

% Open file for writing
fid = fopen(tablename,'w');

fprintf(fid,'\\begin{table}[!t]\n');

fprintf(fid,'\\centering\n');

fprintf(fid,'\\footnotesize\n');

fprintf(fid,['\\caption{' tablecaption '}\n']);

fprintf(fid,['\\label{' tablelbl '}\n']);

% fprintf(fid,'\\begin{tabular}{m{0.25\\linewidth} c c c c}\n');
fprintf(fid,['\\begin{tabular}{' colformat '}\n']);

fprintf(fid,'\\toprule\n');

for irow = 0:nrow
    
    if irow == 0
        
        for icol = 1:ncol-1
            
            fprintf(fid,'\\textbf{%s} & ',any2char(tabledata.Properties.VariableNames{icol},'%s'));
            
        end
        
        fprintf(fid,'\\textbf{%s} ',any2char(tabledata.Properties.VariableNames{icol},'%s'));
        
    else
        
        for icol = 1:ncol-1
            
            fprintf(fid,'%s & ',any2char(tabledata{irow,icol},tableformat{icol}));
            
        end
        
        fprintf(fid,'%s ',any2char(tabledata{irow,icol},tableformat{ncol}));
        
    end
    
    if irow == nrow
        
        fprintf(fid,'\\\\ \\bottomrule\n');
        
    else
        
        fprintf(fid,'\\\\ \\midrule\n');
        
    end
    
end

fprintf(fid,'\\end{tabular}\n');
fprintf(fid,'\\end{table}\n');

fclose(fid);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOCAL FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% LOCAL FUNCTION TO CONVERT TABLE CELL TO CHAR
function tableCell = any2char(tdata,cellFormat)

if isnumeric(tdata)
    
    tableCell = sprintf(cellFormat,tdata);
    
elseif isstring(tdata) || ischar(tdata)
    
    tableCell = sprintf('%s',tdata);
    
else
    
    tableCell = sprintf('%s',string(tdata));
    
end


end
