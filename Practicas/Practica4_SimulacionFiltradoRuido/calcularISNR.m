function isnr = calcularISNR(imagenOriginal, imagenRuido, imagenFiltrada)

    % Obtenemos dimensiones de la imagen original, que serán
    % las mismas que el del resto de imagenes
    [filas, columnas] = size(imagenOriginal);

    sumatorioOriginalRuido = 0;
    sumatorioOriginalFiltrada = 0;

    for fila = 1:filas
        for columna = 1:columnas
        
            pixelOriginal = double(imagenOriginal(fila, columna));
            pixelRuido = double(imagenRuido(fila, columna));
            pixelFiltrada = double(imagenFiltrada(fila, columna));

            sumatorioOriginalRuido = sumatorioOriginalRuido + ...
                power((pixelOriginal - pixelRuido), 2);

            sumatorioOriginalFiltrada = sumatorioOriginalFiltrada + ...
                power((pixelOriginal - pixelFiltrada), 2);
        
        end
    end

    isnr = 10 * log10((sumatorioOriginalRuido / sumatorioOriginalFiltrada));

end