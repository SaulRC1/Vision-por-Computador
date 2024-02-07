function imagenEqualizada = funcion_EcualizaImagen(imagen)

    % Obtenemos dimensiones de la imagen
    [filas, columnas] = size(imagen);

    % Obtenemos el histograma de la imagen
    histograma = calcularHistograma(imagen);

    % Obtenemos el histograma acumulado
    histogramaAcumulado = funcion_HistAcum(histograma);

    % Obtener maximo nivel de gris, se le suma uno ya que se cuenta
    % desde 0 hasta el
    L = double(max(imagen(:)) + 1);

    % Generación de imagen equalizada
    imagenEqualizada = zeros(filas, columnas, "uint8");

    for fila = 1:filas
        for columna = 1:columnas
            g = double(imagen(fila, columna));

            % Se le suma uno ya que para el valor 0 se empieza en
            % el indice 1
            Hg = histogramaAcumulado(g + 1);

            % Se calcula la función de transformación
            Fg = round(((L - 1) / (filas * columnas)) * Hg);
            
            imagenEqualizada(fila, columna) = Fg;
        end
    end

end