% Ejercicio 4 (TEST)
% -------------------------------------------------------------------------
imagenP3 = imread("P3.tif");

imhist(imagenP3);

h = calcularHistograma(imagenP3);

%figure, histogram(h);
%title("Histograma P3 funcion propia");

histogramaAcumulado = funcion_HistAcum(h);

%figure, histogram(histogramaAcumulado);
%title("Histograma acumulado P3");

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

% Ejercicio 9
% -------------------------------------------------------------------------
numFilVent = filas/3;
numColVent = columnas/3;

disp("num filas ventana: " + numFilVent);
disp("num columnas ventana: " + numColVent);

tic;
imagenP3EcualizadaLocalSimetrica = funcion_EcualizacionLocal(imagenP3, ...
    numFilVent, numColVent, "symmetric");
tiempoEcualizacionLocal = toc; 

imagenP3EcualizadaLocalReplicada = funcion_EcualizacionLocal(imagenP3, ...
    numFilVent, numColVent, "replicate");
imagenP3EcualizadaLocalCeros = funcion_EcualizacionLocal(imagenP3, ...
    numFilVent, numColVent, "zeros");

figure, 
subplot(2, 2, 1);
imshow(imagenP3);
title("Imagen P3 Original");

subplot(2, 2, 2);
imshow(imagenP3EcualizadaLocalSimetrica);
title("Imagen P3 Ecualización Local Simétrica");

subplot(2, 2, 3);
imshow(imagenP3EcualizadaLocalReplicada);
title("Imagen P3 Ecualización Local Replicada");

subplot(2, 2, 4);
imshow(imagenP3EcualizadaLocalCeros);
title("Imagen P3 Ecualización Local Ceros");

% Ejercicio 11
% -------------------------------------------------------------------------
tic;
imagenP3EcualizadaLocal5x5 = funcion_EcualizacionLocalVentana5x5(imagenP3);
tiempoEcualizacion5x5 = toc;

figure, imshow(imagenP3EcualizadaLocal5x5);
title("Imagen P3 Ecualizada Local 5x5");

disp("Tiempo computacional ecualizacion 5x5: " + ...
    tiempoEcualizacion5x5 + " segundos");

disp("Tiempo computacional ecualizacion local: " + ...
    tiempoEcualizacionLocal + " segundos");

% Ambas eficiencias computacionales son muy distintas,
% la ejecutada en ventanas 5x5 tarda 5 veces menos.

% Ejercicio 12
% -------------------------------------------------------------------------

brilloP3= calcularBrillo(imagenP3);
contrasteP3 = calcularContraste(imagenP3);
disp("Brillo P3: " + brilloP3);
disp("Contraste P3: " + contrasteP3);

brilloP3Ecualizada = calcularBrillo(imagenP3Ecualizada);
contrasteP3Ecualizada = calcularContraste(imagenP3Ecualizada);
disp("Brillo P3 Ecualizada: " + brilloP3Ecualizada);
disp("Contraste P3 Ecualizada: " + contrasteP3Ecualizada);

brilloP3EcualizadaZonal = calcularBrillo(imagenP3EcualizadaZonal);
contrasteP3EcualizadaZonal = calcularContraste(imagenP3EcualizadaZonal);
disp("Brillo P3 Ecualizada Zonal: " + brilloP3EcualizadaZonal);
disp("Contraste P3 Ecualizada Zonal: " + contrasteP3EcualizadaZonal);

brilloP3EcualizadaLocalSimetrica = calcularBrillo(imagenP3EcualizadaLocalSimetrica);
contrasteP3EcualizadaLocalSimetrica = calcularContraste(imagenP3EcualizadaLocalSimetrica);
disp("Brillo P3 Ecualizada Local Simétrica: " + brilloP3EcualizadaLocalSimetrica);
disp("Contraste P3 Ecualizada Local Simétrica: " + contrasteP3EcualizadaLocalSimetrica);

brilloP3EcualizadaLocalReplicada = calcularBrillo(imagenP3EcualizadaLocalReplicada);
contrasteP3EcualizadaLocalReplicada = calcularContraste(imagenP3EcualizadaLocalReplicada);
disp("Brillo P3 Ecualizada Local Replicada: " + brilloP3EcualizadaLocalReplicada);
disp("Contraste P3 Ecualizada Local Replicada: " + contrasteP3EcualizadaLocalReplicada);

brilloP3EcualizadaLocalCeros = calcularBrillo(imagenP3EcualizadaLocalCeros);
contrasteP3EcualizadaLocalCeros = calcularContraste(imagenP3EcualizadaLocalCeros);
disp("Brillo P3 Ecualizada Local Ceros: " + brilloP3EcualizadaLocalCeros);
disp("Contraste P3 Ecualizada Local Ceros: " + contrasteP3EcualizadaLocalCeros);

brilloP3EcualizadaLocal5x5 = calcularBrillo(imagenP3EcualizadaLocal5x5);
contrasteP3EcualizadaLocal5x5 = calcularContraste(imagenP3EcualizadaLocal5x5);
disp("Brillo P3 Ecualizada Local 5x5: " + brilloP3EcualizadaLocal5x5);
disp("Contraste P3 Ecualizada Local 5x5: " + contrasteP3EcualizadaLocal5x5);


figure;

subplot(2, 3, 1);
imhist(imagenP3Ecualizada);
title('Histograma Imagen P3 Ecualizada');

subplot(2, 3, 2);
imhist(imagenP3EcualizadaZonal);
title('Histograma Imagen P3 Ecualizada Zonal');

subplot(2, 3, 3);
imhist(imagenP3EcualizadaLocalSimetrica);
title('Histograma Imagen P3 Ecualizada Local Simétrica');

subplot(2, 3, 4);
imhist(imagenP3EcualizadaLocalReplicada);
title('Histograma Imagen P3 Ecualizada Local Replicada');

subplot(2, 3, 5);
imhist(imagenP3EcualizadaLocalCeros);
title('Histograma Imagen P3 Ecualizada Local Ceros');

subplot(2, 3, 6);
imhist(imagenP3EcualizadaLocal5x5);
title('Histograma Imagen P3 Ecualizada Local 5x5');

% El brillo de todas las imágenes generadas ha aumentado con respecto
% a la original, excepto el de la generada por ventanas 5x5 que ha
% disminuido.

% En cuanto al contraste, el de todas las imágenes generadas ha disminuido
% aunque no de manera significativa.

% Los histogramas de las imágenes generadas son más uniformes entre sí,
% sin tanta separación de valores, excepto por las ecualizadas uniforme y
% zonalmente.

