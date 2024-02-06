function brillo = calcularBrillo(imagen)
    sumatorioBrillo = uint64(0);

    [filas, columnas] = size(imagen);

    for fila=1:filas
        for columna=1:columnas
            sumatorioBrillo = sumatorioBrillo + ...
                uint64(imagen(fila, columna));
        %disp("areaInteres(" + fila + ", " + columna + "): " ...
        %+ areaInteres(fila, columna));
        end
    end

    brillo = sumatorioBrillo / (filas * columnas);
end