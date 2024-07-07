%% read original data from csv files
function new_table = processMultipleCSVFiles()
    % File selection
    prompts = {
        'Please select Data of Landshuter Allee!', ...
        'Please select Data of Stachus!', ...
        'Please select Data of Lothstraße!', ...
        'Please select Data of Allach!', ...
        'Please select Data of Johanneskirchen!'
    };

    % Initialize variables
    num_files = length(prompts);
    all_time = cell(num_files, 1);
    all_NO2 = cell(num_files, 1);
    fileNames = cell(num_files, 1);

    % Open selection windows sequentially
    for i = 1:num_files
        [file, path] = uigetfile('*.csv', prompts{i});
        if isequal(file, 0)
            disp('User selected Cancel');
            return;
        else
            filePath = fullfile(path, file);
            disp(['User selected ', filePath]);
            fileNames{i} = filePath;  % Save file path
        end
    end

    % Read and parse each CSV file
    for i = 1:num_files
        raw_data = readtable(fileNames{i}, 'ReadVariableNames', false, 'Delimiter', ';');
        
        num_rows = height(raw_data);
        time = datetime.empty(num_rows, 0);
        NO2 = zeros(num_rows, 1);
        
        for j = 1:num_rows
            % Read date, time, and concentration from the table
            date_str = char(raw_data{j, 1}); % First column is date
            time_str = char(raw_data{j, 2}); % Second column is time
            NO2(j) = raw_data{j, 3}; % Third column is NO2 concentration
            datetime_str = strcat(date_str, {' '}, time_str);
            time(j) = datetime(datetime_str, 'InputFormat', 'dd.MM.yyyy HH:mm');
        end

        % Transpose the time vector to match the direction of the NO2 vector
        time = time';

        % Save the read data
        all_time{i} = time;
        all_NO2{i} = NO2;
    end

    % Check if all time vectors are the same
    for i = 2:num_files
        if ~isequal(all_time{1}, all_time{i})
            error('Please select data for the same time period');
        end
    end

    % Create a new table
    new_table = table(all_time{1}, all_NO2{1}, all_NO2{2}, all_NO2{3}, all_NO2{4}, all_NO2{5}, ...
                      'VariableNames', {'Time', 'NO2_Landshuter_Allee', 'NO2_Stachus', 'NO2_Lothstrasse', 'NO2_Allach', 'NO2_Johanneskirchen'});

    % Display the new table
    disp(new_table);
end
