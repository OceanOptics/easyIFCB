function [data] = importSCI(path_to_sci_dir)
% IMPORTSCI read data from folder craeted with IFCBDataExtractor
% author: Nils
% created: Nov 12, 2019

% path_to_sci_dir = '/Users/nils/Data/NAAMES/IFCB/Products';

% Read Metadata
data = readtable([path_to_sci_dir filesep 'metadata.csv']);
data.DateTime = datenum(data.DateTime, 'yyyy/mm/dd HH:MM:SS');
data.Type = categorical(data.Type);
if ismember('Reference', data.Properties.VariableNames)
  data.Reference = categorical(strrep(data.Reference, 'NaN', ''));
end
if ismember('Station', data.Properties.VariableNames)
  data.Station = categorical(strrep(data.Station, 'NaN', ''));
end
if ismember('Epoch', data.Properties.VariableNames)
  data.Epoch = categorical(strrep(data.Epoch, 'NaN', ''));
end
if ismember('Source', data.Properties.VariableNames)
  data.Source = categorical(strrep(data.Source, 'NaN', ''));
end
if ismember('Validated', data.Properties.VariableNames)
  data.Properties.VariableNames{'Validated'} = 'AnnotationValidated';
end

n = height(data);
for i=progress(1:n, 'Title', 'Reading SCI')
  bin_name = data.BinId{i};
  % Skip missing files
  if ~isfile([path_to_sci_dir filesep bin_name '_sci.csv'])
    fprintf('Skipped %s\n', bin_name);
    continue;
  end
  % Read bin data
  d = readtable([path_to_sci_dir filesep bin_name '_sci.csv']);
  if ismember('Status', d.Properties.VariableNames)
    d.Properties.VariableNames{'Status'} = 'AnnotationStatus';
  end
  d.AnnotationStatus = categorical(d.AnnotationStatus);
  d.Taxon = categorical(d.Taxon);
  d.Group = categorical(d.Group);
  if ismember('Var1', data.Properties.VariableNames)
    error(['Unlabelled variable: ' data.BinId{i-1}]);
  end
  % Add variable names to table
  if ~ismember(d.Properties.VariableNames, data.Properties.VariableNames)
    for f=d.Properties.VariableNames
      data.(f{1}) = cell(n,1);
    end
  end
  % Add variable values to table
  for f=d.Properties.VariableNames
    data.(f{1}){i} = d.(f{1});
  end
end

end