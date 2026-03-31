function table2latex_alt(matlabTable,filename)
% Function table2latex(matlabTable, filename) converts a given MATLAB(R) table into %
% a plain .tex file with LaTeX formatting.                                %
%                                                                         %
%   Input parameters:                                                     %
%       - matlabTable: MATLAB(R) table. The table should contain only the %
%                   following data types: numeric, boolean, char or string.
%                   Avoid including structs or cells.                     %
%       - filename: (Optional) Output path, including the name of the file.
%                   If not specified, the table will be stored in a       %
%                   './table.tex' file.                                   %
% ----------------------------------------------------------------------- %
%   Example of use:                                                       %
%       LastName = {'Sanchez';'Johnson';'Li';'Diaz';'Brown'};             %
%       Age = [38;43;38;40;49];                                           %
%       Smoker = logical([1;0;1;0;1]);                                    %
%       Height = [71;69;64;67;64];                                        %
%       Weight = [176;163;131;133;119];                                   %
%       matlabTable = table(Age,Smoker,Height,Weight);                    %
%       matlabTable.Properties.RowNames = LastName;                       %
%       table2latex(matlabTable);                                         %

%   Version: 1.1                                                          %
%   Author:  Victor Martinez Cagigal                                      %
%   Date:    09/10/2018                                                   %
%   E-mail:  vicmarcag (at) gmail (dot) com                               %
% ----------------------------------------------------------------------- %

narginchk(1,2)
nargoutchk(0,0)

% Error detection and default parameters
% if nargin == 1
%     filename = 'table.tex';
%     fprintf('Output path is not defined. The table will be written in %s.\n', filename);
% elseif ~ischar(filename)
%     error('The output file name must be a string.');
% else
%     if ~strcmp(filename(end-3:end), '.tex')
%         filename = [filename '.tex'];
%     end
% end

if nargin == 1
    filename = 'table.txt';
    fprintf('Output path is not defined. The table will be written in %s.\n', filename);
end
% Replace with validateattributes
if ~ischar(filename)
    error('The output file name must be a string.');
end
% Replace with validateattributes
if ~istable(matlabTable)
    error('Input must be a table.');
end

if ~endsWith(filename,'.txt')
    %     filename = [filename '.tex'];
    filename = strcat(filename,'.txt');
end

% Parameters
% ncol = size(matlabTable,2);
[nrow,ncol] = size(matlabTable);

col_spec = [];
for c = 1:ncol, col_spec = [col_spec 'l']; end

col_names = strjoin(matlabTable.Properties.VariableNames, ' & ');
row_names = matlabTable.Properties.RowNames;

if ~isempty(row_names)
    col_spec = ['l' col_spec];
    col_names = ['& ' col_names];
end

% Writing header
fileID = fopen(filename, 'w');
fprintf(fileID, '\\begin{tabular}{%s}\n', col_spec);
fprintf(fileID, '%s \\\\ \n', col_names);
fprintf(fileID, '\\hline \n');

% Writing the data
try
    %     for row = 1:size(matlabTable,1)
    for row = 1:nrow
        temp{1,ncol} = [];
        for col = 1:ncol
            value = matlabTable{row,col};
            if isstruct(value), error('Table must not contain structs.'); end
            while iscell(value), value = value{1,1}; end
            if isinf(value), value = '$\infty$'; end
            temp{1,col} = num2str(value);
        end
        if ~isempty(row_names)
            temp = [row_names{row}, temp];
        end
        fprintf(fileID, '%s \\\\ \n', strjoin(temp, ' & '));
        clear temp;
    end
catch
    error('Unknown error. Make sure that table only contains chars, strings or numeric values.');
end

% Closing the file
fprintf(fileID, '\\hline \n');
fprintf(fileID, '\\end{tabular}');
fclose(fileID);

end
