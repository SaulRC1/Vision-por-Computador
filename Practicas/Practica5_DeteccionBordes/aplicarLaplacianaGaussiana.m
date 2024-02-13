function imagenLaplacianaGaussiana = aplicarLaplacianaGaussiana(imagen, ...
    desviacionTipica)

    % Calculamos máscara laplaciana-gaussiana

    % Calculamos el tamaño del operador W
    W = ceil(3 * 2 * sqrt(2) * desviacionTipica);

    % Centro de la máscara WxW
    center = (W-1)/2;

    % Inicializar la máscara del filtro Gaussiano
    filtroGaussiano = zeros(W);

    % Calcular la máscara del filtro Gaussiano manualmente
    for i = 1:W
        for j = 1:W
            % Distancias desde el centro de la máscara
            x = i - center - 1;
            y = j - center - 1;
        
            % Calcular el valor del filtro Gaussiano en (i,j)
            filtroGaussiano(i, j) = (1/(pi*desviacionTipica^4)) * ...
                ((x^2 + y^2) / (2 * desviacionTipica^2) - 1) * ...
                exp(-1/2 * (x^2 + y^2) / desviacionTipica^2);
        end
    end

    % Normalizar la máscara del filtro Gaussiano, la normalización de
    % la máscara del filtro gaussiano se realiza para garantizar que 
    % la suma de todos los elementos de la máscara sea igual a 1. 
    % Esto es crucial para que la convolución con la máscara no altere
    % la intensidad global de la imagen.
    H = filtroGaussiano / sum(filtroGaussiano(:));

    H_LoG = H - mean(H, "all");

    % Aplicamos convolución con la máscara de la laplaciana gaussiana a la
    % imagen

    % Obtenemos tamaño de la imagen
    [filas, columnas] = size(imagen);

    % Obtenemos tamaño de la mascara
    [filasMascara, columnasMascara] = size(H_LoG);

    paddingFilas = floor(filasMascara / 2);
    paddingColumnas = floor(columnasMascara / 2);
    
    % Aplicar relleno simétrico a la imagen. El relleno de borde simétrico 
    % extiende la imagen reflejando los píxeles más cercanos al borde de la
    % imagen original. Esto garantiza que no se introduzcan artefactos no 
    % deseados en los bordes de la imagen resultante después de la convolución.
    imagenRellenada = padarray(imagen, [paddingFilas, paddingColumnas], "symmetric");

    % Inicializamos la imagen filtrada
    imagenLaplacianaGaussiana = zeros(size(imagenRellenada), "double");

    % Iterar sobre cada píxel de la imagen
    for i = 1 + paddingFilas:filas + paddingFilas
        for j = 1 + paddingColumnas:columnas + paddingColumnas
            
            % Inicializar la suma para este píxel
            suma = 0;

            for m = 1: filasMascara
                for n = 1:columnasMascara

                    % Obtener las coordenadas del píxel en la imagen 
                    % correspondiente al elemento de la máscara
                    filaImagen = i + m - paddingFilas - 1;
                    columnaImagen = j + n - paddingColumnas - 1;

                    % Verificar si el píxel está dentro de los límites de 
                    % la imagen
                    if filaImagen >= 1 && filaImagen <= filas && columnaImagen >= 1 && columnaImagen <= columnas
                        % Sumar el producto del píxel en la imagen y el
                        % elemento de la máscara
                        suma = suma + double(imagenRellenada(filaImagen, columnaImagen)) * H_LoG(m, n);
                    end

                end
            end
            
            imagenLaplacianaGaussiana(i, j) = suma;

        end
    end

    % Recortar los gradientes al tamaño original
    imagenLaplacianaGaussiana = imagenLaplacianaGaussiana(1 + paddingFilas : filas ...
        + paddingFilas, 1 + paddingColumnas : columnas + paddingColumnas);

    % Se invierten los niveles de gris para resaltar en negro los bordes
    imagenLaplacianaGaussiana = 255 - imagenLaplacianaGaussiana;

end