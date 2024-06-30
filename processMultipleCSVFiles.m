%% 读取原始.csv文件的数据
function new_table = processMultipleCSVFiles()
    % 文件选择
    prompts = {
        'Please select Data of Landshuter Allee!', ...
        'Please select Data of Stachus!', ...
        'Please select Data of Lothstraße!', ...
        'Please select Data of Allach!', ...
        'Please select Data of Johanneskirchen!'
    };

    % 初始化变量
    num_files = length(prompts);
    all_time = cell(num_files, 1);
    all_NO2 = cell(num_files, 1);
    fileNames = cell(num_files, 1);

    % 依次弹出选择窗口
    for i = 1:num_files
        [file, path] = uigetfile('*.csv', prompts{i});
        if isequal(file, 0)
            disp('User selected Cancel');
            return;
        else
            filePath = fullfile(path, file);
            disp(['User selected ', filePath]);
            fileNames{i} = filePath;  % 保存文件路径
        end
    end

    % 读取并解析每个CSV文件
    for i = 1:num_files
        raw_data = readtable(fileNames{i}, 'ReadVariableNames', false, 'Delimiter', ';');
        
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
                      'VariableNames', {'Time', 'NO2_Landshuter_Allee', 'NO2_Stachus', 'NO2_Lothstrasse', 'NO2_Allach', 'NO2_Johanneskirchen'});

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
