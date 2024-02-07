% Ejercicio 4 (TEST)
% -------------------------------------------------------------------------
imagenP3 = imread("P3.tif");

imhist(imagenP3);

h = calcularHistograma(imagenP3);

figure, histogram(h);
title("Histograma P3 funcion propia");

histogramaAcumulado = funcion_HistAcum(h);

figure, histogram(histogramaAcumulado);
title("Histograma acumulado P3");

%lengthHistograma = length(histogramaAcumulado);

%for indice = 1:lengthHistograma
%    disp("Histograma Acumulado[" + indice + "]: " + histogramaAcumulado(indice));
%end

% Ejercicio 6
% -------------------------------------------------------------------------
tic;
imagenP3Ecualizada = funcion_EcualizaImagen(imagenP3);
tiempoComputacional = toc;

figure, imshow(imagenP3)
title("Imagen P3");

figure, imshow(imagenP3Ecualizada);
title("Imagen P3 Ecualizada");

disp("Tiempo computacional de funcion_EcualizaImagen: " ...
    + tiempoComputacional + " segundos.");

% Ejercicio 7
% -------------------------------------------------------------------------

% Obtenemos el tamaño de la imagen P3
[filas, columnas] = size(imagenP3);

% La dividimos en 9 subimagenes, esto es el nº de filas
% entre 3 y el nº de columnas entre 3, ya que es como si
% fuese una malla de 3 filas con 3 columnas y 9 partes
% internas

% Se redondea con floor hacia abajo para no sobrepasar los límites de la
% imagen
divisionFilas = floor(double(filas) / 3);
divisionColumnas = floor(double(columnas / 3));

% Se crea la imagen ecualizada de forma zonal
imagenP3EcualizadaZonal = zeros(filas, columnas, "uint8");

% Se ecualizan las 9 subimagenes
for fila = 1:3
    for columna = 1:3
        % Se multiplican las divisiones de las columnas por la columna
        % en la que se está dentro del bucle, para así obtener los límites
        % superiores de cada subimagen. Se le suma 1 para abarcar todos
        % los pixeles de la imagen, ya que anteriormente se uso floor
        maxIndiceColumna = divisionColumnas * columna + 1;

        % Se realiza lo mismo que en las columnas para las filas.
        maxIndiceFila = divisionFilas * fila + 1;

        % Para obtener los límites inferiores (comienzo de cada subimagen)
        % se le resta al límite superior el valor de la division.
        minIndiceFila = maxIndiceFila - divisionFilas;
        minIndiceColumna = maxIndiceColumna - divisionColumnas;

        %disp("SubImagen[" + fila + ", " + columna + "]");
        %disp("----------------------------------------");
        %disp("minimo indice fila: " + minIndiceFila);
        %disp("minimo indice columna: " + minIndiceColumna);
        %disp("maximo indice fila: " + maxIndiceFila);
        %disp("maximo indice columna: " + maxIndiceColumna);

        subimagen = imagenP3(minIndiceFila:maxIndiceFila, ...
            minIndiceColumna:maxIndiceColumna);

        subImagenEcualizada = funcion_EcualizaImagen(subimagen);

        % Se deposita en la imagen ecualizada zonalmente el resultado
        imagenP3EcualizadaZonal(minIndiceFila:maxIndiceFila, ...
            minIndiceColumna:maxIndiceColumna) = subImagenEcualizada;
    end
end

figure, imshow(imagenP3EcualizadaZonal);
title("Imagen P3 Ecualización Zonal");
