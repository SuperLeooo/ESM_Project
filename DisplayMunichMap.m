function DisplayMunichMap
    % Open an interactive online map
    wm = webmap('OpenStreetMap');

    % Set the map center and zoom level
    lat = 48.1351; % Latitude of Munich
    lon = 11.5820; % Longitude of Munich
    zoomLevel = 12; % Zoom level

    % Set the map center to Munich
    wmcenter(lat, lon, zoomLevel);
    wmmarker(lat, lon, 'Description', 'Munich');

    % Define a 20 km x 20 km area
    latRange = [lat - 0.1, lat + 0.1]; % Approx. 20 km latitude range
    lonRange = [lon - 0.1, lon + 0.1]; % Approx. 20 km longitude range

    % Create a 1 km x 1 km grid
    [latGrid, lonGrid] = meshgrid(linspace(latRange(1), latRange(2), 21), linspace(lonRange(1), lonRange(2), 21));

    % Plot the grid
    for i = 1:length(latGrid)
        wmline([latGrid(i, 1), latGrid(i, end)], [lonGrid(i, 1), lonGrid(i, end)], 'Color', 'blue', 'Width', 0.5);
        wmline([latGrid(1, i), latGrid(end, i)], [lonGrid(1, i), lonGrid(end, i)], 'Color', 'blue', 'Width', 0.5);
    end

end
