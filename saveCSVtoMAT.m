% 创建一个文件选择对话框，让用户选择CSV文件
[file, path] = uigetfile('*.csv', 'Select CSV File');
if isequal(file, 0)
    disp('User selected Cancel');
    return;
else
    filePath = fullfile(path, file);
    disp(['User selected ', filePath]);
end

% 读取CSV文件中的数据
raw_data = readtable(filePath, 'ReadVariableNames', false, 'Delimiter', ';');

% 初始化变量
num_rows = height(raw_data);
time = datetime.empty(num_rows, 0);
NO2 = zeros(num_rows, 1);

% 解析CSV文件中的数据
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

% 创建新的表格
new_table = table(time, NO2);

% 显示新表格
disp(new_table);

% 让用户选择存储位置和文件名
[file, path] = uiputfile('*.mat', 'Save MAT File As');
if isequal(file, 0)
    disp('User selected Cancel');
    return;
else
    matFilePath = fullfile(path, file);
    save(matFilePath, 'new_table');
    disp(['Data saved to ', matFilePath]);
end
