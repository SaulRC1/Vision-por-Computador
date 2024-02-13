function imagenSupresion = aplicarSupresionNoMaxima(Em, Eo)

    % Creamos las direcciones y las convertimos a radianes
    d = [deg2rad(0), deg2rad(45), deg2rad(90), deg2rad(135)];

    % Obtenemos el tamaño de la magnitud y el angulo, que son idénticos
    [filas, columnas] = size(Em);

    % Inicializamos la imagen de supresión no máxima
    imagenSupresion = zeros(filas, columnas, "double");

    for i = 1:filas
        for j = 1:columnas
        
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

            if direccionAproximada == d(1)
                indicesAEvaluar = [i, (j - 1), i, (j + 1)];
            elseif direccionAproximada == d(2)
                indicesAEvaluar = [(i + 1), (j - 1), (i - 1), (j + 1)];
            elseif direccionAproximada == d(3)
                indicesAEvaluar = [(i - 1), j, (i + 1), j];
            elseif direccionAproximada == d(4)
                indicesAEvaluar = [(i - 1), (j - 1), (i + 1), (j + 1)];
            end

            pixelDireccionNegativa = 0;
            pixelDireccionPositiva = 0;

            % Si el pixel esta fuera de los límites de la imagen se ignora
            % dejando por defecto el valor 0, evitandose que Em(i,j)
            % pudiese ser menor
            if indicesAEvaluar(1) >= 1 && indicesAEvaluar(1) <= filas ...
                    && indicesAEvaluar(2) >= 1 && indicesAEvaluar(2) <= columnas

                pixelDireccionNegativa = Em(indicesAEvaluar(1), indicesAEvaluar(2));

            end

            if indicesAEvaluar(3) >= 1 && indicesAEvaluar(3) <= filas ...
                    && indicesAEvaluar(4) >= 1 && indicesAEvaluar(4) <= columnas

                pixelDireccionPositiva = Em(indicesAEvaluar(3), indicesAEvaluar(4));

            end

            pixelAExaminar = Em(i, j);

            if pixelAExaminar < pixelDireccionNegativa || ...
                    pixelAExaminar < pixelDireccionPositiva

                imagenSupresion(i, j) = 0;

            else
                imagenSupresion(i, j) = pixelAExaminar;
            end

        
        end
    end

end