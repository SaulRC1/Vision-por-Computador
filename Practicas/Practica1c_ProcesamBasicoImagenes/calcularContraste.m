function contraste = calcularContraste(imagen)
    sumatorioContraste = uint64(0);

    [filas, columnas] =  size(imagen);

    brillo = calcularBrillo(imagen);

    for fila=1:filas
        for columna=1:columnas
            sumatorioContraste = sumatorioContraste + ...
            power(uint64(imagen(fila, columna)) - brillo, 2);
        end
    end

    pasoIntermedioContraste = sumatorioContraste / (filas * columnas);
    contraste = sqrt(double(pasoIntermedioContraste));
end