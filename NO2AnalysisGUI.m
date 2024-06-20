function NO2AnalysisWithSlider
    % 创建主界面窗口
    hFig = figure('Name', 'NO2 Analysis with Time Slider', 'Position', [100, 100, 1000, 700]);

    % 创建一个按钮用于选择文件
    uicontrol('Style', 'pushbutton', 'String', 'Browse Files', ...
        'Position', [20, 650, 120, 30], ...
        'Callback', @browseFiles);

    % 创建一个滑块用于选择时间
    hSlider = uicontrol('Style', 'slider', 'Position', [200, 650, 300, 30], ...
        'Min', 0, 'Max', 47, 'Value', 0, 'SliderStep', [1/48 1/48], ...
        'Callback', @updateMap);

    % 创建一个标签显示当前选择的时间
    hSliderLabel = uicontrol('Style', 'text', 'Position', [510, 650, 100, 30], ...
        'String', 'Hour: 0');

    % 创建两个坐标轴用于展示图表
    hAx1 = axes('Parent', hFig, 'Position', [0.35, 0.55, 0.6, 0.4]);
    hAx2 = axes('Parent', hFig, 'Position', [0.35, 0.1, 0.6, 0.4]);

    % 存储文件路径的单元格数组
    filePaths = {};
    data = {};

    function browseFiles(~, ~)
        [files, path] = uigetfile('*.csv', 'Select CSV Files', 'MultiSelect', 'on');
        if isequal(files, 0)
            return;
        end
        if ischar(files)
            files = {files}; % 确保files是一个单元格数组，即使只选择了一个文件
        end
        filePaths = fullfile(path, files);
        
        % 提示选择的文件数量和文件名
        msgbox(sprintf('Selected %d files:\n%s', length(filePaths), strjoin(files, '\n')), 'File Selection');
        
        % 读取数据
        data = cell(1, 5);
        for i = 1:5
            raw_data = readtable(filePaths{i}, 'ReadVariableNames', false);
            parsed_data = parseData(raw_data);
            data{i} = parsed_data;
        end
        
        % 转换NO2浓度
        molar_volume = 24.45; % 标准状况下空气的摩尔体积，单位：L/mol
        molecular_weight = 46; % NO2的分子量，单位：g/mol
        for i = 1:5
            data{i}.NO2Concentration = (data{i}.NO2Concentration * molar_volume) / molecular_weight;
        end
        
        % 初始化地图
        initializeMap();
    end

    function parsed_data = parseData(raw_data)
        % 解析日期、时间和浓度
        num_rows = height(raw_data);
        time = datetime.empty(num_rows, 0);
        no2_concentration = zeros(num_rows, 1);
        for j = 1:num_rows
            parts = split(raw_data{j, 1}{1}, ';');
            dt = datetime([parts{1}, ' ', parts{2}], 'InputFormat', 'dd.MM.yyyy HH:mm');
            time(j, 1) = dt;
            no2_concentration(j) = str2double(parts{3});
        end
        parsed_data = table(time, no2_concentration, 'VariableNames', {'Time', 'NO2Concentration'});
    end

    function initializeMap()
        % 打开并显示慕尼黑地图
        axes(hAx2);
        worldmap([48.1 48.3], [11.4 11.7]);
        load coastlines;
        geoshow(coastlat, coastlon, 'DisplayType', 'polygon', 'FaceColor', [0.5 0.7 0.5]);
        
        % 更新初始数据
        updateMap();
    end

    function updateMap(~, ~)
        % 获取当前滑块值
        hour = round(get(hSlider, 'Value'));
        set(hSliderLabel, 'String', ['Hour: ', num2str(hour)]);
        
        % 计算并绘制空间分布图
        stations = [
            struct('name', 'Station 1', 'lat', 48.150, 'lon', 11.550, 'no2_ppb', data{1}.NO2Concentration(hour + 1)),
            struct('name', 'Station 2', 'lat', 48.137, 'lon', 11.575, 'no2_ppb', data{2}.NO2Concentration(hour + 1)),
            struct('name', 'Station 3', 'lat', 48.144, 'lon', 11.565, 'no2_ppb', data{3}.NO2Concentration(hour + 1)),
            struct('name', 'Station 4', 'lat', 48.210, 'lon', 11.480, 'no2_ppb', data{4}.NO2Concentration(hour + 1)),
            struct('name', 'Station 5', 'lat', 48.170, 'lon', 11.630, 'no2_ppb', data{5}.NO2Concentration(hour + 1))
        ];
        
        lat_range = linspace(48.1, 48.3, 100);
        lon_range = linspace(11.4, 11.7, 100);
        [lon_grid, lat_grid] = meshgrid(lon_range, lat_range);
        no2_grid = griddata([stations.lon], [stations.lat], [stations.no2_ppb], lon_grid, lat_grid, 'v4');
        
        % 在地图上绘制NO2浓度
        axes(hAx2);
        contourfm(lat_grid, lon_grid, no2_grid, 'LineStyle', 'none');
        colorbar;
        xlabel('Longitude');
        ylabel('Latitude');
        title(['NO2 Concentration Map (ppb) - Hour: ', num2str(hour)]);
    end
end
