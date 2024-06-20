function DisplayMunichMap
    % 打开一个交互式的在线地图（默认使用OpenStreetMap）
    wm = webmap('OpenStreetMap');

    % 设置地图中心和缩放级别
    lat = 48.1351; % 慕尼黑的纬度
    lon = 11.5820; % 慕尼黑的经度
    zoomLevel = 12; % 缩放级别

    % 将地图中心设置为慕尼黑
    wmcenter(lat, lon, zoomLevel);
    wmmarker(lat, lon, 'Description', 'Munich');

    % 设置 20 km × 20 km 区域的范围
    latRange = [lat - 0.1, lat + 0.1]; % 大约对应于 20 km 的纬度范围
    lonRange = [lon - 0.1, lon + 0.1]; % 大约对应于 20 km 的经度范围

    % 创建 1 km × 1 km 分辨率的网格
    [latGrid, lonGrid] = meshgrid(linspace(latRange(1), latRange(2), 21), linspace(lonRange(1), lonRange(2), 21));

    % 在地图上绘制网格
    for i = 1:length(latGrid)
        for j = 1:length(lonGrid)
            wmline([latGrid(i,j) latGrid(i,j)], [lonGrid(i,j) lonGrid(i,j)+0.01], 'Color', 'blue');
            wmline([latGrid(i,j) latGrid(i,j)+0.01], [lonGrid(i,j) lonGrid(i,j)], 'Color', 'blue');
        end
    end

    % 添加标题
    title('Munich with 1 km × 1 km Grid');
end
