function latexTable = struct2latextable(inputStruct)
% An easy to use function that generates a LaTeX table from a given MATLAB
% input struct containing numeric values. The LaTeX code is printed in the
% command window for quick copy&paste and given back as a cell array.
%
% Author:       Eli Duenisch
% Contributor:  Pascal E. Fortin
% Date:         April 20, 2016
% License:      This code is licensed using BSD 2 to maximize your freedom of using it :)
% https://www.mathworks.com/matlabcentral/fileexchange/44274-latextable
% ----------------------------------------------------------------------------------
%  Copyright (c) 2016, Eli Duenisch
%  All rights reserved.
%
%  Redistribution and use in source and binary forms, with or without
%  modification, are permitted provided that the following conditions are met:
%
%  * Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
%
%  * Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
%
%  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
%  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
% ----------------------------------------------------------------------------------
%
% Input:
% inputStruct: struct containing your data and optional fields (details described below)
%
% Output:
% latexTable: cell array containing LaTex code
%
% Example and explanation of the input struct fields:
%
% % numeric values you want to tabulate:
% % this field has to be a matrix or MATLAB table datatype
% % missing values have to be NaN
% % in this example we use an array
% input.data = [1.12345 2.12345 3.12345; ...
%               4.12345 5.12345 6.12345; ...
%               7.12345 NaN 9.12345; ...
%               10.12345 11.12345 12.12345];
%
% % Optional fields (if not set default values will be used):
%
% % Set the position of the table in the LaTex document using h, t, p, b, H or !
% input.tablePositioning = 'h';
%
% % Set column labels (use empty string for no label):
% input.tableColLabels = {'col1','col2','col3'};
% % Set row labels (use empty string for no label):
% input.tableRowLabels = {'row1','row2','','row4'};
%
% % Switch transposing/pivoting your table:
% inputStruct.transposeTable = 0;
%
% % Determine whether inputStruct.dataFormat is applied column or row based:
% inputStruct.dataFormatMode = 'column'; % use 'column' or 'row'. if not set 'column' is used
%
% % Formatting-string to set the precision of the table values:
% % For using different formats in different rows use a cell array like
% % {myFormatString1,numberOfValues1,myFormatString2,numberOfValues2, ... }
% % where myFormatString_ are formatting-strings and numberOfValues_ are the
% % number of table columns or rows that the preceding formatting-string applies.
% % Please make sure the sum of numberOfValues_ matches the number of columns or
% % rows in inputStruct.tableData!
% %
% % inputStruct.dataFormat = {'%.3f'}; % uses three digit precision floating point for all data values
% inputStruct.dataFormat = {'%.3f',2,'%.1f',1}; % three digits precision for first two columns, one digit for the last
%
% % Define how NaN values in inputStruct.tableData should be printed in the LaTex table:
% inputStruct.dataNanString = '-';
%
% % Column alignment in Latex table ('l'=left-justified, 'c'=centered,'r'=right-justified):
% inputStruct.tableColumnAlignment = 'c';
%
% % Switch table borders on/off:
% inputStruct.tableBorders = 1;
%
% % Switch table booktabs on/off:
% inputStruct.booktabs = 1;
%
% % LaTex table caption:
% inputStruct.tableCaption = 'MyTableCaption';
%
% % LaTex table label:
% inputStruct.tableLabel = 'MyTableLabel';
%
% % Switch to generate a complete LaTex document or just a table:
% inputStruct.makeCompleteLatexDocument = 1;
%
% % % Now call the function to generate LaTex code:
% latexTable = latexTable(inputStruct);

%%%%%%%%%%%%%%%%%%%%%%%%%% Default settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These settings are used if the corresponding optional inputs are not given.
%
% Placement of the table in LaTex document
% if isfield(inputStruct,'tablePlacement') && (length(inputStruct.tablePlacement)>0)
if isfield(inputStruct,'tablePlacement') && (~isempty(inputStruct.tablePlacement))
    inputStruct.tablePlacement = ['[',inputStruct.tablePlacement,']'];
else
    inputStruct.tablePlacement = '';
end
% Pivoting of the input data switched off per default:
if ~isfield(inputStruct,'transposeTable'),inputStruct.transposeTable = 0;end
% Default mode for applying inputStruct.tableDataFormat:
if ~isfield(inputStruct,'dataFormatMode'),inputStruct.dataFormatMode = 'column';end
% Sets the default display format of numeric values in the LaTeX table to '%.4f'
% (4 digits floating point precision).
if ~isfield(inputStruct,'dataFormat'),inputStruct.dataFormat = {'%.4f'};end
% Define what should happen with NaN values in inputStruct.tableData:
if ~isfield(inputStruct,'dataNanString'),inputStruct.dataNanString = '-';end
% Specify the alignment of the columns:
% 'l' for left-justified, 'c' for centered, 'r' for right-justified
if ~isfield(inputStruct,'tableColumnAlignment'),inputStruct.tableColumnAlignment = 'c';end
% Specify whether the table has borders:
% 0 for no borders, 1 for borders
if ~isfield(inputStruct,'tableBorders'),inputStruct.tableBorders = 1;end
% Specify whether to use booktabs formatting or regular table formatting:
if ~isfield(inputStruct,'booktabs')
    inputStruct.booktabs = 0;
else
    if inputStruct.booktabs
        inputStruct.tableBorders = 0;
    end
end
% Other optional fields:
if ~isfield(inputStruct,'tableCaption'),inputStruct.tableCaption = 'MyTableCaption';end
if ~isfield(inputStruct,'tableLabel'),inputStruct.tableLabel = 'MyTableLabel';end
if ~isfield(inputStruct,'makeCompleteLatexDocument'),inputStruct.makeCompleteLatexDocument = 0;end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% process table datatype
if isa(inputStruct.data,'table')
    if(~isempty(inputStruct.data.Properties.RowNames))
        inputStruct.tableRowLabels = inputStruct.data.Properties.RowNames';
    end
    if(~isempty(inputStruct.data.Properties.VariableNames))
        inputStruct.tableColLabels = inputStruct.data.Properties.VariableNames';
    end
    inputStruct.data = table2array(inputStruct.data);
end

% get size of data
numberDataRows = size(inputStruct.data,1);
numberDataCols = size(inputStruct.data,2);

% obtain cell array for the table data and labels
colLabelsExist = isfield(inputStruct,'tableColLabels');
rowLabelsExist = isfield(inputStruct,'tableRowLabels');
cellSize = [numberDataRows+colLabelsExist,numberDataCols+rowLabelsExist];
C = cell(cellSize);
C(1+colLabelsExist:end,1+rowLabelsExist:end) = num2cell(inputStruct.data);
if rowLabelsExist
    C(1+colLabelsExist:end,1)=inputStruct.tableRowLabels';
end
if colLabelsExist
    C(1,1+rowLabelsExist:end)=inputStruct.tableColLabels;
end

% obtain cell array for the format
lengthDataFormat = length(inputStruct.dataFormat);
if lengthDataFormat==1
    tmp = repmat(inputStruct.dataFormat(1),numberDataRows,numberDataCols);
else
    dataFormatList={};
    for i=1:2:lengthDataFormat
        dataFormatList(end+1:end+inputStruct.dataFormat{i+1},1) = repmat(inputStruct.dataFormat(i),inputStruct.dataFormat{i+1},1);
    end
    if strcmp(inputStruct.dataFormatMode,'column')
        tmp = repmat(dataFormatList',numberDataRows,1);
    end
    if strcmp(inputStruct.dataFormatMode,'row')
        tmp = repmat(dataFormatList,1,numberDataCols);
    end
end
if ~isequal(size(tmp),size(inputStruct.data))
    error(['Please check your values in inputStruct.dataFormat:'...
        'The sum of the numbers of fields must match the number of columns OR rows '...
        '(depending on inputStruct.dataFormatMode)!']);
end
dataFormatArray = cell(cellSize);
dataFormatArray(1+colLabelsExist:end,1+rowLabelsExist:end) = tmp;

% transpose table (if this switched on)
if inputStruct.transposeTable
    C = C';
    dataFormatArray = dataFormatArray';
end

% make table header lines:
hLine = '\hline';
if inputStruct.tableBorders
    header = ['\begin{tabular}','{|',repmat([inputStruct.tableColumnAlignment,'|'],1,size(C,2)),'}'];
else
    header = ['\begin{tabular}','{',repmat(inputStruct.tableColumnAlignment,1,size(C,2)),'}'];
end
latexTable = {['\begin{table}',inputStruct.tablePlacement];'\centering';header};

% generate table
if inputStruct.booktabs
    latexTable(end+1) = {'\toprule'};
end

for i=1:size(C,1)
    if i==2 && inputStruct.booktabs
        latexTable(end+1) = {'\midrule'};
    end
    if inputStruct.tableBorders
        latexTable(end+1) = {hLine};
    end
    rowStr = '';
    for j=1:size(C,2)
        dataValue = C{i,j};
        if iscell(dataValue)
            dataValue = dataValue{:};
        elseif isnan(dataValue)
            dataValue = inputStruct.dataNanString;
        elseif isnumeric(dataValue)
            dataValue = num2str(dataValue,dataFormatArray{i,j});
        end
        if j==1
            rowStr = dataValue;
        else
            rowStr = [rowStr,' & ',dataValue];
        end
    end
    latexTable(end+1) = {[rowStr,' \\']};
end

if inputStruct.booktabs
    latexTable(end+1) = {'\bottomrule'};
end


% make footer lines for table:
tableFooter = {'\end{tabular}';['\caption{',inputStruct.tableCaption,'}']; ...
    ['\label{table:',inputStruct.tableLabel,'}'];'\end{table}'};
if inputStruct.tableBorders
    latexTable = [latexTable;{hLine};tableFooter];
else
    latexTable = [latexTable;tableFooter];
end

% add code if a complete latexTable document should be created:
if inputStruct.makeCompleteLatexDocument
    % document header
    latexHeader = {'\documentclass[a4paper,10pt]{article}'};
    if inputStruct.booktabs
        latexHeader(end+1) = {'\usepackage{booktabs}'};
    end
    latexHeader(end+1) = {'\begin{document}'};
    % document footer
    latexFooter = {'\end{document}'};
    latexTable = [latexHeader';latexTable;latexFooter];
end

% print latexTable code to console:
disp(char(latexTable));

end
