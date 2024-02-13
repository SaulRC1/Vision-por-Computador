function imagenBordes = aplicarHisteresisDeUmbral(imagenSupresionNoMaxima, ...
    Eo, umbralInferior, umbralSuperior)

    [filas, columnas] = size(imagenSupresionNoMaxima);

    imagenBordes = zeros(filas, columnas, "double");

    % Creamos las direcciones y las convertimos a radianes
    d = [deg2rad(0), deg2rad(45), deg2rad(90), deg2rad(135)];

    for i = 1:filas
        for j = 1:columnas
        
            if imagenSupresionNoMaxima(i, j) > umbralSuperior

                % Marcamos el pixel actual en la imagen de bordes
                imagenBordes(i, j) = imagenSupresionNoMaxima(i, j);
            
                % La normal de borde es la perpendicular al borde, es
                % decir el ángulo del gradiente en ese punto. Por tanto,
                % se deben seguir las direcciones perpendiculares a Eo(i,j)

                % Primero localizamos la dirección más próxima a Eo(i,j)
                % Obtenemos la dirección del ángulo del gradiente
                direccionEo = Eo(i,j);

                % Se restan las direcciones preestablecidas con la dirección
                % del ángulo del gradiente, y se coge su valor absoluto
                diferenciaDirecciones = [abs(d(1) - direccionEo), ...
                    abs(d(2) - direccionEo), abs(d(3) - direccionEo), ...
                    abs(d(4) - direccionEo)];

                % Aquella resta con menor valor indicara en indice de la
                % dirección más aproximada
                indiceDireccionAproximada = find(diferenciaDirecciones == ...
                    min(diferenciaDirecciones));
            
                direccionAproximada = d(indiceDireccionAproximada);

                % Las perpendiculares a las direcciones serán los índices
                % que evaluemos. De 0º será 90º, de 45º será 135º, y así
                % sucesivamente
                if direccionAproximada == d(1)
                    indicesAEvaluar = [(i - 1), j, (i + 1), j];
                elseif direccionAproximada == d(2)
                    indicesAEvaluar = [(i - 1), (j - 1), (i + 1), (j + 1)];
                elseif direccionAproximada == d(3)
                    indicesAEvaluar = [i, (j - 1), i, (j + 1)];
                elseif direccionAproximada == d(4)
                    indicesAEvaluar = [(i + 1), (j - 1), (i - 1), (j + 1)];
                end

                % Si el pixel esta fuera de los límites de la imagen se ignora
                % dejando por defecto el valor 0, evitandose que Em(i,j)
                % pudiese ser menor
                if indicesAEvaluar(1) >= 1 && indicesAEvaluar(1) <= filas ...
                        && indicesAEvaluar(2) >= 1 && indicesAEvaluar(2) <= columnas

                    pixelDireccionNegativa = imagenSupresionNoMaxima(indicesAEvaluar(1), indicesAEvaluar(2));

                    if pixelDireccionNegativa > umbralInferior
                        imagenBordes(indicesAEvaluar(1), indicesAEvaluar(2)) ...
                            = pixelDireccionNegativa;
                    end

                end

                if indicesAEvaluar(3) >= 1 && indicesAEvaluar(3) <= filas ...
                        && indicesAEvaluar(4) >= 1 && indicesAEvaluar(4) <= columnas

                    pixelDireccionPositiva = imagenSupresionNoMaxima(indicesAEvaluar(3), indicesAEvaluar(4));

                     if pixelDireccionPositiva > umbralInferior
                        imagenBordes(indicesAEvaluar(3), indicesAEvaluar(4)) ...
                            = pixelDireccionPositiva;
                     end
                end

            end

        end
    end

end