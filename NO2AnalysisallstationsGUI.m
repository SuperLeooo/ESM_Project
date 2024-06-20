function NO2AnalysisGUI
    % 创建主界面窗口
    hFig = figure('Name', 'NO2 Analysis', 'Position', [100, 100, 1000, 700]);

    % 创建一个按钮用于选择文件
    uicontrol('Style', 'pushbutton', 'String', 'Browse MAT Files', ...
        'Position', [20, 650, 120, 30], ...
        'Callback', @browseFiles);

    % 创建一个按钮用于执行分析
    uicontrol('Style', 'pushbutton', 'String', 'Run Analysis', ...
        'Position', [150, 650, 120, 30], ...
        'Callback', @runAnalysis);

    % 创建一个坐标轴用于展示图表
    hAx = axes('Parent', hFig, 'Position', [0.1, 0.1, 0.8, 0.5]);

    % 存储文件路径的单元格数组
    filePaths = {};

    function browseFiles(~, ~)
        [files, path] = uigetfile('*.mat', 'Select MAT Files', 'MultiSelect', 'on');
        if isequal(files, 0)
            return;
        end
        if ischar(files)
            files = {files}; % 确保files是一个单元格数组，即使只选择了一个文件
        end
        filePaths = fullfile(path, files);
        
        % 提示选择的文件数量和文件名
        msgbox(sprintf('Selected %d files:\n%s', length(filePaths), strjoin(files, '\n')), 'File Selection');
    end

    function runAnalysis(~, ~)
        if length(filePaths) ~= 5
            errordlg('Please select exactly 5 files.', 'Error');
            return;
        end
        
        % 读取数据
        data = cell(1, 5);
        for i = 1:5
            matData = load(filePaths{i});
            data{i}.Time = matData.time;
            data{i}.NO2Concentration = matData.NO2;
        end
        
        % 转换NO2浓度
        molar_volume = 24.45; % 标准状况下空气的摩尔体积，单位：L/mol
        molecular_weight = 46; % NO2的分子量，单位：g/mol
        for i = 1:5
            data{i}.NO2Concentration = (data{i}.NO2Concentration * molar_volume) / molecular_weight;
        end
        
        % 绘制时间相关性图
        cla(hAx); % 清除以前的图表
        hold(hAx, 'on');
        for i = 1:5
            plot(hAx, data{i}.Time, data{i}.NO2Concentration, '-o', 'DisplayName', sprintf('Station %d', i));
        end
        hold(hAx, 'off');
        legend(hAx, 'show');
        xlabel(hAx, 'Time');
        ylabel(hAx, 'NO2 Concentration (ppb)');
        title(hAx, '48-hour NO2 Concentration Variation');
        grid(hAx, 'on');
    end
end
