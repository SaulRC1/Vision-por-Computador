function imagenBinarizadaUmbralLocal = binarizarUmbralLocal(imagen)

    % Tamaño de la ventana. Un tamaño de ventana más grande conlleva una
    % resolución espacial más alta, lo que significa que se pueden capturar
    % mejor las características locales de la imagen.
    %
    % Con un tamaño más grande se reduce la sensibilidad al ruido. A pesar
    % de estar la imagen de entrada previamente filtrada, es buena práctica
    % que el valor sea elevado, ya que al considerarse más pixeles, se
    % reduce el efecto del ruido en la umbralización.
    %
    % Por último una ventana de mayor dimensión captura mejor los detalles
    % y los bordes de los objetos en la imagen.
    dimensionesVentana = 80;

    % Inicializar la imagen binarizada
    [filas, columnas] = size(imagen);
    imagenBinarizadaUmbralLocal = zeros(filas, columnas); 

    for i = 1:filas
        for j = 1:columnas
            % Definir límites de la ventana, para no salir de los límites
            % de la imagen se coge el maximo entre 1 y el valor en el caso
            % de las filas y el minimo entre el maximo de columnas y el 
            % valor calculado, etc.
            filaInicio = max(1, i - floor(dimensionesVentana/2));
            filaFin = min(filas, i + floor(dimensionesVentana/2));
            columnaInicio = max(1, j - floor(dimensionesVentana/2));
            columnaFin = min(columnas, j + floor(dimensionesVentana/2));
        
            % Calcular umbral local
            ventana = double(imagen(filaInicio:filaFin, columnaInicio:columnaFin));
            umbralLocal = mean(ventana(:)); % Por ejemplo, el umbral se puede calcular como el promedio de los valores de la ventana
        
            % Binarizar la región utilizando el umbral local. Se resaltan
            % los objetos con color blanco, coloreando el fondo negro
            if imagen(i, j) >= umbralLocal
                imagenBinarizadaUmbralLocal(i, j) = 0;
            else
                imagenBinarizadaUmbralLocal(i, j) = 255;
            end
        end
    end
end