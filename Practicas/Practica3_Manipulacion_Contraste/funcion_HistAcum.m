function histogramaAcumulado = funcion_HistAcum(histograma)
    
    histogramaAcumulado = zeros(1, 256);

    lengthHistograma = length(histograma);

    % Hacemos el primer paso fuera del bucle para luego poder iterar
    % de forma adecuada
    valorEnHistograma = histograma(1);

    % Valor acumulado hasta el momento, al principio solo tendra
    % el correspondiente al nivel gris 0.
    valorAcumulado = valorEnHistograma;

    % Se inserta en el primer lugar el valor acumulado hasta
    % el momento para el nivel de gris 0
    histogramaAcumulado(1) = valorAcumulado;

    for indice = 2:lengthHistograma
        valorEnHistograma = histograma(indice);

        valorAcumulado = valorEnHistograma + valorAcumulado;

        histogramaAcumulado(indice) = valorAcumulado;
    end

end