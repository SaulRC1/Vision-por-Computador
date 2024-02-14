function valorCorrelacion = Funcion_CorrelacionEntreMatrices(Matriz1, Matriz2)

    % Obtenemos el tamaño de las matrices, el cual debe ser el mismo
    [filas, columnas] = size(Matriz1);

    % Inicializamos los componentes de la formula
    sumaNumerador = 0;
    sumaDenominador = 0;

    % Calculamos las medias de antemano, por cuestión de optimización
    mediaMatriz1 = mean(Matriz1, "all");
    mediaMatriz2 = mean(Matriz2, "all");
    
    for i = 1:filas
        for j = 1:columnas
        
            sumaNumerador = sumaNumerador + (double(Matriz1(i,j)) - mediaMatriz1) ...
                * (double(Matriz2(i,j)) - mediaMatriz2);

            sumaDenominador = sumaDenominador + ...
                power((double(Matriz1(i,j)) - mediaMatriz1), 2) * ...
                power((double(Matriz2(i,j)) - mediaMatriz2), 2);

        end
    end

    valorCorrelacion = sumaNumerador / sumaDenominador;

end