function DisplayMunichMap
    % Open an interactive online map
    wm = webmap('OpenStreetMap');

    % Set the map center and zoom level
    lat = 48.1351; % Latitude of Munich
    lon = 11.5820; % Longitude of Munich
    zoomLevel = 13; % Zoom level

    % Set the map center to Munich
    wmcenter(lat, lon, zoomLevel);
    %wmmarker(lat, lon, 'Description', 'Munich');

%     % Define a 20 km x 20 km area
%     latRange = [lat - 0.1, lat + 0.1]; % Approx. 20 km latitude range
%     lonRange = [lon - 0.1, lon + 0.1]; % Approx. 20 km longitude range
% 
%     % Create a 1 km x 1 km grid
%     [latGrid, lonGrid] = meshgrid(linspace(latRange(1), latRange(2), 21), linspace(lonRange(1), lonRange(2), 21));
% 
%     % Plot the grid
%     for i = 1:length(latGrid)
%         wmline([latGrid(i, 1), latGrid(i, end)], [lonGrid(i, 1), lonGrid(i, end)], 'Color', 'blue', 'Width', 0.5);
%         wmline([latGrid(1, i), latGrid(end, i)], [lonGrid(1, i), lonGrid(end, i)], 'Color', 'blue', 'Width', 0.5);
%     end
% 
% end

    % Define a 20 km x 20 km area
        kmPerDegLat = 111.134; % Approx. km per degree latitude
        kmPerDegLon = 111.321 * cosd(lat); % Approx. km per degree longitude, adjusted for latitude
    
        latRange = [lat - 10/kmPerDegLat, lat + 10/kmPerDegLat]; % 10 km each side of center
        lonRange = [lon - 10/kmPerDegLon, lon + 10/kmPerDegLon]; % 10 km each side of center
    
        % Create a 1 km x 1 km grid
        latGrid = linspace(latRange(1), latRange(2), 21); % 21 points for 20 intervals
        lonGrid = linspace(lonRange(1), lonRange(2), 21); % 21 points for 20 intervals
    
        % Plot the grid
        for i = 1:length(latGrid)
            wmline([latGrid(i), latGrid(i)], [lonGrid(1), lonGrid(end)], 'Color', 'blue', 'Width', 0.5);
            wmline([latGrid(1), latGrid(end)], [lonGrid(i), lonGrid(i)], 'Color', 'blue', 'Width', 0.5);
        end


        %Plot the concentration map with a suited color

        pollutionValues = evalin('base', 'interpolated_concentration');
        maxPollution = max(pollutionValues(:));
        minPollution = min(pollutionValues(:));
        colorMap = jet(256); % Jet colormap
    
        scaledValues = floor(255 * (pollutionValues - minPollution) / (maxPollution - minPollution)) + 1;
        RGB = ind2rgb(scaledValues, colorMap);
    
        % Plot pollution overlay
        for i = 1:length(latGrid)-1
            for j = 1:length(lonGrid)-1
                color = squeeze(RGB(i, j, :))';
                wmpolygon([latGrid(i), latGrid(i+1), latGrid(i+1), latGrid(i)], [lonGrid(j), lonGrid(j), lonGrid(j+1), lonGrid(j+1)], 'FaceColor', color, 'FaceAlpha', 0.6);
            end
        end


        %Mark Stations
        lat_allach = 48.18165;
        lon_allach = 11.46444;
        wmmarker(lat_allach, lon_allach, 'Description', 'Allach');
        
        lat_johann = 48.17319;
        lon_johann = 11.64804;
        wmmarker(lat_johann, lon_johann, 'Description', 'Johanneskirchen');

        lat_landshuter = 48.14955;
        lon_landshuter = 11.53653;
        wmmarker(lat_landshuter, lon_landshuter, 'Description', 'Landshuter Allee');

        lat_loths = 48.15455;
        lon_loths = 11.55466;
        wmmarker(lat_loths, lon_loths, 'Description', 'Lothstraße');

        lat_stachus = 48.13732;
        lon_stachus = 11.56481;
        wmmarker(lat_stachus, lon_stachus, 'Description', 'Stachus');
    end
