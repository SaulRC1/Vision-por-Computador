function imagenFiltrada = Funcion_FiltroMediana(imagen, ...
    matrizVecindad, opcionPadding)

    % Obtenemos tamaño de la imagen
    [filas, columnas] = size(imagen);

    % Obtenemos tamaño de la matriz de vecindad
    [filasVecindad, columnasVecindad] = size(matrizVecindad);

    % Redondeamos el numero de filas y de columnas de la ventana
    numFilVent = floor(filasVecindad);
    numColVent = floor(columnasVecindad);
    
    % Calcular el margen para el relleno
    margenFilas = floor(numFilVent / 2);
    margenColumnas = floor(numColVent / 2);

    if opcionPadding == "zeros"
        % En el caso de zeros como la opcion no existe, no se utiliza
        % ninguna opción de relleno en padarray
        imagenRellenada = padarray(imagen, [margenFilas, margenColumnas]);
    else
        imagenRellenada = padarray(imagen, [margenFilas, margenColumnas], ...
            opcionPadding);
    end

    for fila = 1 + margenFilas : filas + margenFilas
        for columna = 1 + margenColumnas : columnas + margenColumnas
            % Obtener la ventana de vecindad
            ventana = imagenRellenada(fila - margenFilas : fila ...
                + margenFilas, columna - margenColumnas : columna ...
                + margenColumnas);
            
            % Calcular la mediana
            [filasVentana, columnasVentana] = size(ventana);

            % Pixeles sobre los que calcular la mediana
            pixelesOperacion = [];

            for filaVentana = 1:filasVentana
                for columnaVentana = 1:columnasVentana  
                    if matrizVecindad(filaVentana, columnaVentana) == 1
                        pixelesOperacion = [pixelesOperacion, ...
                            double(ventana(filaVentana, columnaVentana))];
                    end
                end
            end

            pixelNuevo = median(pixelesOperacion);

            imagenFiltrada(fila, columna) = uint8(pixelNuevo);
        end
    end

    % Recortar la imagen de salida al tamaño original
    imagenFiltrada = imagenFiltrada(1 + margenFilas : filas ...
        + margenFilas, 1 + margenColumnas : columnas + margenColumnas);

end