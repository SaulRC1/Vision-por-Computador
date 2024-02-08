function imagenEcualizadaLocal = funcion_EcualizacionLocal(imagen, ...
    numFilVent, numColVent, opcionRelleno)

    % Comprobar que el tamaño de la ventana es impar
    if mod(numFilVent, 2) == 0 || mod(numColVent, 2) == 0
        error('El número de filas y columnas de la ventana debe ser impar');
    end

    % Comprobar que la opción de relleno es válida
    if opcionRelleno ~= "symmetric" && opcionRelleno ~= "replicate" ...
        && opcionRelleno ~= "zeros"
        error("El valor de opcion de relleno introducido no es válido");
    end

    % Redondeamos el numero de filas y de columnas de la ventana
    numFilVent = floor(numFilVent);
    numColVent = floor(numColVent);
    
    % Calcular el margen para el relleno
    margenFilas = floor(numFilVent / 2);
    margenColumnas = floor(numColVent / 2);

    % Obtenemos tamaño de la imagen original
    [filas, columnas] = size(imagen);
    
    % Extender la imagen de entrada según la opción de relleno.
    % Los pixeles de los bordes de la imagen de entrada, al ser situados
    % en el centro de la ventana, necesitan de que la imagen se extienda
    % para poder elaborar dicha ventana de vecindad. 
    % 
    % Ya que esos pixeles no existen realmente, se rellena la imagen de 
    % entrada con la opción específicada y con el nº de filas y columnas 
    % determinado por los margenes, que no son mas que la mitad del nº de 
    % filas y columnas, ya que los pixeles de los bordes siempre estaran
    % situados en el centro de la ventana de vecindad.
    if opcionRelleno == "zeros"
        % En el caso de zeros como la opcion no existe, no se utiliza
        % ninguna opción de relleno en padarray
        imagenRellenada = padarray(imagen, [margenFilas, margenColumnas]);
    else
        imagenRellenada = padarray(imagen, [margenFilas, margenColumnas], opcionRelleno);
    end
    
    % Inicializar la imagen de salida
    imagenEcualizadaLocal = zeros(size(imagenRellenada), "uint8");
    
    % Ecualizar la imagen de forma local
    for fila = 1 + margenFilas : filas + margenFilas
        for columna = 1 + margenColumnas : columnas + margenColumnas
            % Obtener la ventana de vecindad
            ventana = imagenRellenada(fila - margenFilas : fila ...
                + margenFilas, columna - margenColumnas : columna ...
                + margenColumnas);
            
            % Ecualizar la ventana
            ventanaEcualizada = funcion_EcualizaImagen(ventana);
            
            % Asignar el valor ecualizado al píxel correspondiente en la 
            % imagen de salida. Se utiliza siempre los margenes como
            % indices ya que se ha de buscar el centro de la ventana
            imagenEcualizadaLocal(fila, columna) = ...
            ventanaEcualizada(margenFilas + 1, margenColumnas + 1);
        end
    end
    
    % Recortar la imagen de salida al tamaño original
    imagenEcualizadaLocal = imagenEcualizadaLocal(1 + margenFilas : filas ...
        + margenFilas, 1 + margenColumnas : columnas + margenColumnas);
end