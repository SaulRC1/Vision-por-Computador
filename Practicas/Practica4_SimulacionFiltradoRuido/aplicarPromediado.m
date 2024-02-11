function imagenPromediada = aplicarPromediado(imagenes)

    numeroDeImagenes = length(imagenes);

    % Dimensiones de las imagenes (todas iguales)
    [filas, columnas] = size(imagenes{1});

    % Creamos la imagen promediada
    imagenPromediada = zeros(filas, columnas, "uint8");

    for fila = 1:filas
        for columna = 1:columnas
        
            sumatorioPixelesImagenesRuidosas = 0;

            for i = 1:numeroDeImagenes

                imagenRuidosa = imagenes{i};

                pixelImagenRuidosa = double(imagenRuidosa(fila, columna));

                sumatorioPixelesImagenesRuidosas = sumatorioPixelesImagenesRuidosas + ...
                    pixelImagenRuidosa;
            end

            pixelPromediado = sumatorioPixelesImagenesRuidosas / numeroDeImagenes;

            imagenPromediada(fila, columna) = uint8(pixelPromediado);
        
        end
    end
    

end