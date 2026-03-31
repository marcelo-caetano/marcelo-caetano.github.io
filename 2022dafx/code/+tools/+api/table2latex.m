function table2latex(tabledata,options)
%TABLE2LATEX Write Matlab table as latex table.
%   TABLE2LATEX(TABLEDATA,OPTIONS)
%   TABLEDATA: Matlab table size NROW x NCOL
%   OPTIONS.TABLEFORMAT: "%2.4f %2.4f %2.4f...%2.4f" size 1 x NCOL
%   OPTIONS.COLFORMAT: "c c c...c" size 1 x NCOL
%   OPTIONS.TABLENAME: full path to txt file
%   OPTIONS.TABLECAPTION: "\\itshape Gereric caption."
%   OPTIONS.TABLELABEL: "tab:generic_label"
%
%   See also CELL2LATEX

% TODO: REPLACE ANY2CHAR WITH WRITETABLECELL
% TODO: ADD FIELD OPTIONS.ISFOOTNOTESIZE
% TODO: ADD FIELD OPTIONS.TOPRULE
% TODO: ADD FIELD OPTIONS.MIDRULE
% TODO: ADD FIELD OPTIONS.BOTTOMRULE
% TODO: ADD FIELD OPTIONS.CAPTIONPOS (TOP or BOTTOM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

narginchk(1,2)
nargoutchk(0,0)

[nrow,ncol] = size(tabledata);

if nargin == 1
    
    options = struct('tableformat',repmat("%2.4f",1,ncol),...
        'colformat',string([repmat('c ',1,ncol-1) 'c']),...
        'tablename',"table.txt",...
        'tablecaption',"\\itshape Gereric caption.",...
        'tablelabel',"tab:generic_label");
    
end

if ~isfield(options,'tableformat')
    options.tableformat = repmat("%2.4f",1,ncol);
end

if ~isfield(options,'colformat')
    options.colformat = string([repmat('c ',1,ncol-1) 'c']);
end

if ~isfield(options,'tablename')
    options.tablename = "table.txt";
end

if ~isfield(options,'tablecaption')
    options.tablecaption = "Gereric caption";
end

if ~isfield(options,'tablelabel')
    options.tablelabel = "tab:generic_label";
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Open file for writing
fid = fopen(options.tablename,'w');

fprintf(fid,"\\begin{table}[!t]\n");

fprintf(fid,"\\centering\n");

fprintf(fid,"\\footnotesize\n");

fprintf(fid,"\\caption{" + string(options.tablecaption) + "}\n");

fprintf(fid,"\\label{" + string(options.tablelabel) + "}\n");

fprintf(fid,"\\begin{tabular}{" + string(options.colformat) + "}\n");

fprintf(fid,"\\toprule\n");

for irow = 0:nrow
    
    % Table header
    if irow == 0
        
        for icol = 1:ncol-1
            
            fprintf(fid,"\\textbf{%s} & ",any2char(tabledata.Properties.VariableNames{icol},"%s"));
            
        end
        
        fprintf(fid,"\\textbf{%s} ",any2char(tabledata.Properties.VariableNames{ncol},"%s"));
        
    else
        
        for icol = 1:ncol-1
            
            fprintf(fid,"%s & ",any2char(tabledata{irow,icol},options.tableformat{icol}));
            
        end
        
        fprintf(fid,"%s ",any2char(tabledata{irow,ncol},options.tableformat{ncol}));
        
    end
    
    if irow == nrow
        
        fprintf(fid,"\\\\ \\bottomrule\n");
        
    else
        
        fprintf(fid,"\\\\ \\midrule\n");
        
    end
    
end

fprintf(fid,"\\end{tabular}\n");
fprintf(fid,"\\end{table}\n");

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
    
    tableCell = sprintf("%s",tdata);
    
else
    
    tableCell = sprintf("%s",string(tdata));
    
end


end
