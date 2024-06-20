function processMultipleCSVFiles()
    % 让用户选择五个CSV文件
    [files, path] = uigetfile('*.csv', 'Select CSV Files', 'MultiSelect', 'on');
    if isequal(files, 0)
        disp('User selected Cancel');
        return;
    elseif length(files) ~= 5
        disp('Please select exactly five files');
        return;
    end

    % 初始化变量
    num_files = length(files);
    all_time = cell(num_files, 1);
    all_NO2 = cell(num_files, 1);

    % 读取并解析每个CSV文件
    for i = 1:num_files
        filePath = fullfile(path, files{i});
        raw_data = readtable(filePath, 'ReadVariableNames', false, 'Delimiter', ';');
        
        num_rows = height(raw_data);
        time = datetime.empty(num_rows, 0);
        NO2 = zeros(num_rows, 1);
        
        for j = 1:num_rows
            % 从表格中读取日期、时间和浓度
            date_str = char(raw_data{j, 1}); % 第一列是日期
            time_str = char(raw_data{j, 2}); % 第二列是时间
            NO2(j) = raw_data{j, 3}; % 第三列是NO2浓度
            datetime_str = strcat(date_str, {' '}, time_str);
            time(j) = datetime(datetime_str, 'InputFormat', 'dd.MM.yyyy HH:mm');
        end

        % 转置时间向量以匹配NO2向量的方向
        time = time';

        % 保存读取的数据
        all_time{i} = time;
        all_NO2{i} = NO2;
    end

    % 检查所有文件的时间向量是否相同
    for i = 2:num_files
        if ~isequal(all_time{1}, all_time{i})
            error('请选择同一时间段的数据');
        end
    end

    % 创建新的表格
    new_table = table(all_time{1}, all_NO2{1}, all_NO2{2}, all_NO2{3}, all_NO2{4}, all_NO2{5}, ...
                      'VariableNames', {'Time', 'NO2_1', 'NO2_2', 'NO2_3', 'NO2_4', 'NO2_5'});

    % 显示新表格
    disp(new_table);

    % % 让用户选择存储位置和文件名
    % [file, path] = uiputfile('*.mat', 'Save MAT File As');
    % if isequal(file, 0)
    %     disp('User selected Cancel');
    %     return;
    % else
    %     matFilePath = fullfile(path, file);
    %     save(matFilePath, 'new_table');
    %     disp(['Data saved to ', matFilePath]);
    % end
end
