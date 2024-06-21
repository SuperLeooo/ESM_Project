function DisplayMunichMap
    % 打开一个交互式的在线地图
    wm = webmap('OpenStreetMap');

    % 设置地图中心和缩放级别
    lat = 48.1351; % 慕尼黑的纬度
    lon = 11.5820; % 慕尼黑的经度
    zoomLevel = 12; % 缩放级别

    % 将地图中心设置为慕尼黑
    wmcenter(lat, lon, zoomLevel);
    wmmarker(lat, lon, 'Description', 'Munich');

    % 20 km x 20 km 
    latRange = [lat - 0.1, lat + 0.1]; % Approx. 20 km latitude range
    lonRange = [lon - 0.1, lon + 0.1]; % Approx. 20 km longitude range

    % 建一个1 km x 1 km 的网格
    [latGrid, lonGrid] = meshgrid(linspace(latRange(1), latRange(2), 21), linspace(lonRange(1), lonRange(2), 21));

    % Plot
    for i = 1:length(latGrid)
        wmline([latGrid(i, 1), latGrid(i, end)], [lonGrid(i, 1), lonGrid(i, end)], 'Color', 'blue', 'Width', 0.5);
        wmline([latGrid(1, i), latGrid(end, i)], [lonGrid(1, i), lonGrid(end, i)], 'Color', 'blue', 'Width', 0.5);
    end

end
