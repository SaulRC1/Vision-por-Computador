function imagenEcualizadaLocal = funcion_EcualizacionLocalVentana5x5(imagen)

    % Numero de filas y columnas de la ventana de vecindad
    numFilVent = 5;
    numColVent = 5;
    
    % Calcular el margen para el relleno
    margenFilas = floor(numFilVent / 2);
    margenColumnas = floor(numColVent / 2);

    % Obtenemos tamaño de la imagen original
    [filas, columnas] = size(imagen);
    
    % Extender la imagen de entrada con el relleno
    imagenRellenada = padarray(imagen, [margenFilas, margenColumnas], "symmetric");
    
    % Inicializar la imagen de salida
    imagenEcualizadaLocal = zeros(size(imagenRellenada), "uint8");
    
    % Ecualizar la imagen de forma local
    for fila = 1 + numFilVent: numFilVent : filas + margenFilas
        for columna = 1 + numColVent: numColVent : columnas + margenColumnas

            indiceInicialFila = fila - numFilVent;
            indiceFinalFila = fila - 1;

            indiceInicialColumna = columna - numColVent;
            indiceFinalColumna = columna - 1;

            %disp("Indice Inicial Fila: " + indiceInicialFila);
            %disp("Indice Final Fila: " + indiceFinalFila);
            %disp("Indice Inicial Columna: " + indiceInicialColumna);
            %disp("Indice Final Columna: " + indiceFinalColumna);

            % Obtener la ventana de vecindad
            ventana = imagenRellenada(indiceInicialFila : indiceFinalFila, ...
                indiceInicialColumna : indiceFinalColumna);
            
            % Ecualizar la ventana
            ventanaEcualizada = funcion_EcualizaImagen(ventana);
            
            % Asignar el valor ecualizado a la ventana correspondiente de
            % la imagen de salida
            imagenEcualizadaLocal(indiceInicialFila : indiceFinalFila, ...
                indiceInicialColumna : indiceFinalColumna) = ...
            ventanaEcualizada;
        end
    end
    
    % Recortar la imagen de salida al tamaño original
    imagenEcualizadaLocal = imagenEcualizadaLocal(1 + margenFilas : filas ...
        + margenFilas, 1 + margenColumnas : columnas + margenColumnas);
end