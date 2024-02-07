function histograma = calcularHistograma(imagen)
    [filas, columnas] = size(imagen);

    valores = zeros(1, 256);

    for columna=1:columnas
        for fila=1:filas
            % Obtener nivel de gris
            nivelDeGris = imagen(fila, columna);

            % Se suma 1 ya que para el nivel de gris 0, se utiliza
            % el indice 1
            valores(nivelDeGris + 1) = valores(nivelDeGris + 1) + 1;
        end
    end

    histograma = valores;
end