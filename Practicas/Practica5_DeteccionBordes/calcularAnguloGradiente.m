function anguloGradiente = calcularAnguloGradiente(Gx, Gy)

    % Gx y Gy tienen ambos el mismo tamaño
    [filas, columnas] = size(Gx);

    anguloGradiente = zeros(filas, columnas, "double");

    for i = 1:filas
        for j = 1:columnas
            anguloGradiente(i, j) = atan((Gy(i, j)/Gx(i, j)));
        end
    end
    
    % Algunos valores contienen NaN, esto indica que no existe
    % cambio de intensidad en ninguna direccion, por lo que se
    % sustituye su valor por 0
    indicesNaN = isnan(anguloGradiente);

    anguloGradiente(indicesNaN) = 0;
end