function [Gx, Gy, ModG] = Funcion_Calcula_Gradiente(imagen, Hx, Hy)

    % Obtenemos tamaño de la imagen
    [filas, columnas] = size(imagen);

    % Obtenemos tamaño de las mascaras Hx y Hy que serán
    % de las mismas dimensiones
    [filasMascara, columnasMascara] = size(Hx);

    paddingFilas = floor(filasMascara / 2);
    paddingColumnas = floor(columnasMascara / 2);
    
    % Aplicar relleno simétrico a la imagen. El relleno de borde simétrico 
    % extiende la imagen reflejando los píxeles más cercanos al borde de la
    % imagen original. Esto garantiza que no se introduzcan artefactos no 
    % deseados en los bordes de la imagen resultante después de la convolución.
    imagenRellenada = padarray(imagen, [paddingFilas, paddingColumnas], "symmetric");

    % Inicializamos los gradientes
    Gx = zeros(size(imagenRellenada), "double");
    Gy = zeros(size(imagenRellenada), "double");

    % Se aplica convolución con Gauss para suavizar la imagen
    imagenRellenada = imgaussfilt(imagenRellenada, 1);

    % Iterar sobre cada píxel de la imagen
    for i = 1 + paddingFilas:filas + paddingFilas
        for j = 1 + paddingColumnas:columnas + paddingColumnas
            
            % Inicializar la suma para este píxel
            sumaX = 0;
            sumaY = 0;

            %disp("Posicion Imagen: " + "(" + i + ", " + j + ")");

            for m = 1: filasMascara
                for n = 1:columnasMascara

                    % Obtener las coordenadas del píxel en la imagen 
                    % correspondiente al elemento de la máscara
                    filaImagen = i + m - paddingFilas - 1;
                    columnaImagen = j + n - paddingColumnas - 1;

                    %disp("Posicion Mascara: " + "(" + filaImagen + ", " + columnaImagen + ")");

                    % Verificar si el píxel está dentro de los límites de la imagen
                    if filaImagen >= 1 && filaImagen <= filas && columnaImagen >= 1 && columnaImagen <= columnas
                        % Sumar el producto del píxel en la imagen y el elemento del kernel
                        sumaX = sumaX + double(imagenRellenada(filaImagen, columnaImagen)) * Hx(m, n);
                        sumaY = sumaY + double(imagenRellenada(filaImagen, columnaImagen)) * Hy(m, n);
                    end

                end
            end
            
            Gx(i, j) = sumaX;
            Gy(i, j) = sumaY;

        end
    end

    % Recortar los gradientes al tamaño original
    Gx = Gx(1 + paddingFilas : filas ...
        + paddingFilas, 1 + paddingColumnas : columnas + paddingColumnas);
    Gy = Gy(1 + paddingFilas : filas ...
        + paddingFilas, 1 + paddingColumnas : columnas + paddingColumnas);

    % Se calcula la magnitud elevando cada elemento de los gradientes al
    % cuadrado, sumandolos y aplicando raiz cuadrada
    ModG = sqrt(Gx.^2 + Gy.^2);
end