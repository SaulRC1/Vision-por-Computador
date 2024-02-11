% Ejercicio 1
% -------------------------------------------------------------------------

imagenP4 = imread("P4.tif");

% Primero obtenemos la distribución gaussiana de media nula y
% varianza 1
distribucionGaussiana0_1 = randn(size(imagenP4), "double");

% Ruido gaussiano de media nula y desviación típica 10

% La desviación típica es la raíz cuadrada positiva de la
% varianza
distribucionGaussiana0_100 = 0 + 10 * distribucionGaussiana0_1;

% Para el ruido gaussiano el valor del pixel con ruido será
% el del ideal más una cantidad correspondiente al error, es
% decir, cada pixel (x,y) sumado a su correspondiente elemento
% en la distribución gaussiana
imagenP4RuidoGaussiano0_100 = uint8(double(imagenP4) + ...
distribucionGaussiana0_100);

% Ruido gaussiano de media nula y desviación típica 5

distribucionGaussiana0_25 = 0 + 5 * distribucionGaussiana0_1;
imagenP4RuidoGaussiano0_25 = uint8(double(imagenP4) + ...
distribucionGaussiana0_25);

% Ruido gaussiano de media nula y desviación típica 5

distribucionGaussiana0_1225 = 0 + 35 * distribucionGaussiana0_1;
imagenP4RuidoGaussiano0_1225 = uint8(double(imagenP4) + ...
distribucionGaussiana0_1225);

% Ejercicio 2
% -------------------------------------------------------------------------

% Filtramos la imagen con ruido gaussiano (0,25)

% Filtros 3x3
imagenP4_0_25_FiltroMediana3x3 = medfilt2(imagenP4RuidoGaussiano0_25, ...
    [3, 3], "symmetric");

filtroGaussiano3x3 = fspecial("gaussian", [3, 3], 1);
imagenP4_0_25_FiltroGaussiano3x3 = imfilter(imagenP4RuidoGaussiano0_25, ...
    filtroGaussiano3x3, "conv", "replicate");

matrizVecindad3x3 = randi([0, 1], 3, 3);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_25(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_25_FiltroAdaptativo3x3 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_25, ...
    matrizVecindad3x3, varianzaRuido, "symmetric");

% Filtros 7x7
imagenP4_0_25_FiltroMediana7x7 = medfilt2(imagenP4RuidoGaussiano0_25, ...
    [7, 7], "symmetric");

filtroGaussiano7x7 = fspecial("gaussian", [7, 7], 1);
imagenP4_0_25_FiltroGaussiano7x7 = imfilter(imagenP4RuidoGaussiano0_25, ...
    filtroGaussiano7x7, "conv", "replicate");

matrizVecindad7x7 = randi([0, 1], 7, 7);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_25(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_25_FiltroAdaptativo7x7 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_25, ...
    matrizVecindad7x7, varianzaRuido, "symmetric");

figure;
subplot(3, 3, 2);
imshow(imagenP4_0_25_FiltroGaussiano3x3);
title("Imagen P4 R.Gaussiano(0,25) F.Gaussiano 3x3");

subplot(3, 3, 4);
imshow(imagenP4_0_25_FiltroGaussiano7x7);
title("Imagen P4 R.Gaussiano(0,25) F.Gaussiano 7x7");

subplot(3, 3, 6);
imshow(imagenP4_0_25_FiltroAdaptativo3x3);
title("Imagen P4 R.Gaussiano(0,25) F.Adaptativo 3x3");

subplot(3, 3, 8);
imshow(imagenP4_0_25_FiltroAdaptativo7x7);
title("Imagen P4 R.Gaussiano(0,25) F.Adaptativo 7x7");

subplot(3, 3, 5);
imshow(imagenP4RuidoGaussiano0_25);
title("Imagen P4 R.Gaussiano(0,25)");

subplot(3, 3, 3);
imshow(imagenP4_0_25_FiltroMediana3x3);
title("Imagen P4 R.Gaussiano(0,25) F.Mediana 3x3");

subplot(3, 3, 1);
imshow(imagenP4_0_25_FiltroMediana7x7);
title("Imagen P4 R.Gaussiano(0,25) F.Mediana 7x7");

% Filtramos la imagen con ruido gaussiano (0, 100)

% Filtros 3x3
imagenP4_0_100_FiltroMediana3x3 = medfilt2(imagenP4RuidoGaussiano0_100, ...
    [3, 3], "symmetric");

filtroGaussiano3x3 = fspecial("gaussian", [3, 3], 1);
imagenP4_0_100_FiltroGaussiano3x3 = imfilter(imagenP4RuidoGaussiano0_100, ...
    filtroGaussiano3x3, "conv", "replicate");

matrizVecindad3x3 = randi([0, 1], 3, 3);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_100(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_100_FiltroAdaptativo3x3 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_100, ...
    matrizVecindad3x3, varianzaRuido, "symmetric");

% Filtros 7x7
imagenP4_0_100_FiltroMediana7x7 = medfilt2(imagenP4RuidoGaussiano0_100, ...
    [7, 7], "symmetric");

filtroGaussiano7x7 = fspecial("gaussian", [7, 7], 1);
imagenP4_0_100_FiltroGaussiano7x7 = imfilter(imagenP4RuidoGaussiano0_100, ...
    filtroGaussiano7x7, "conv", "replicate");

matrizVecindad7x7 = randi([0, 1], 7, 7);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_100(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_100_FiltroAdaptativo7x7 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_100, ...
    matrizVecindad7x7, varianzaRuido, "symmetric");

figure;
subplot(3, 3, 2);
imshow(imagenP4_0_100_FiltroGaussiano3x3);
title("Imagen P4 R.Gaussiano(0,100) F.Gaussiano 3x3");

subplot(3, 3, 4);
imshow(imagenP4_0_100_FiltroGaussiano7x7);
title("Imagen P4 R.Gaussiano(0,100) F.Gaussiano 7x7");

subplot(3, 3, 6);
imshow(imagenP4_0_100_FiltroAdaptativo3x3);
title("Imagen P4 R.Gaussiano(0,100) F.Adaptativo 3x3");

subplot(3, 3, 8);
imshow(imagenP4_0_100_FiltroAdaptativo7x7);
title("Imagen P4 R.Gaussiano(0,100) F.Adaptativo 7x7");

subplot(3, 3, 5);
imshow(imagenP4RuidoGaussiano0_100);
title("Imagen P4 R.Gaussiano(0,100)");

subplot(3, 3, 3);
imshow(imagenP4_0_100_FiltroMediana3x3);
title("Imagen P4 R.Gaussiano(0,100) F.Mediana 3x3");

subplot(3, 3, 1);
imshow(imagenP4_0_100_FiltroMediana7x7);
title("Imagen P4 R.Gaussiano(0,100) F.Mediana 7x7");

% Filtramos la imagen con ruido gaussiano (0,25)

% Filtros 3x3
imagenP4_0_1225_FiltroMediana3x3 = medfilt2(imagenP4RuidoGaussiano0_1225, ...
    [3, 3], "symmetric");

filtroGaussiano3x3 = fspecial("gaussian", [3, 3], 1);
imagenP4_0_1225_FiltroGaussiano3x3 = imfilter(imagenP4RuidoGaussiano0_1225, ...
    filtroGaussiano3x3, "conv", "replicate");

matrizVecindad3x3 = randi([0, 1], 3, 3);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_1225(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_1225_FiltroAdaptativo3x3 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_1225, ...
    matrizVecindad3x3, varianzaRuido, "symmetric");

% Filtros 7x7
imagenP4_0_1225_FiltroMediana7x7 = medfilt2(imagenP4RuidoGaussiano0_1225, ...
    [7, 7], "symmetric");

filtroGaussiano7x7 = fspecial("gaussian", [7, 7], 1);
imagenP4_0_1225_FiltroGaussiano7x7 = imfilter(imagenP4RuidoGaussiano0_1225, ...
    filtroGaussiano7x7, "conv", "replicate");

matrizVecindad7x7 = randi([0, 1], 7, 7);
[filas, columnas] = size(imagenP4);
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4RuidoGaussiano0_1225(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);
imagenP4_0_1225_FiltroAdaptativo7x7 = Funcion_FiltAdaptMatricial(imagenP4RuidoGaussiano0_1225, ...
    matrizVecindad7x7, varianzaRuido, "symmetric");

figure;
subplot(3, 3, 2);
imshow(imagenP4_0_1225_FiltroGaussiano3x3);
title("Imagen P4 R.Gaussiano(0,1225) F.Gaussiano 3x3");

subplot(3, 3, 4);
imshow(imagenP4_0_1225_FiltroGaussiano7x7);
title("Imagen P4 R.Gaussiano(0,1225) F.Gaussiano 7x7");

subplot(3, 3, 6);
imshow(imagenP4_0_1225_FiltroAdaptativo3x3);
title("Imagen P4 R.Gaussiano(0,1225) F.Adaptativo 3x3");

subplot(3, 3, 8);
imshow(imagenP4_0_1225_FiltroAdaptativo7x7);
title("Imagen P4 R.Gaussiano(0,1225) F.Adaptativo 7x7");

subplot(3, 3, 5);
imshow(imagenP4RuidoGaussiano0_1225);
title("Imagen P4 R.Gaussiano(0,1225)");

subplot(3, 3, 3);
imshow(imagenP4_0_1225_FiltroMediana3x3);
title("Imagen P4 R.Gaussiano(0,1225) F.Mediana 3x3");

subplot(3, 3, 1);
imshow(imagenP4_0_1225_FiltroMediana7x7);
title("Imagen P4 R.Gaussiano(0,1225) F.Mediana 7x7");

% Ejercicio 3
% -------------------------------------------------------------------------

% Ruido Gaussiano(0,25)
% -------------------------------------------------------------------------
isnrGauss0_25_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroGaussiano3x3);

isnrGauss0_25_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroGaussiano7x7);

isnrMediana0_25_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroMediana3x3);

isnrMediana0_25_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroMediana7x7);

isnrAdaptativo0_25_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroAdaptativo3x3);

isnrAdaptativo0_25_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_25, ...
    imagenP4_0_25_FiltroAdaptativo7x7);

% Ruido Gaussiano(0,100)
% -------------------------------------------------------------------------

isnrGauss0_100_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroGaussiano3x3);

isnrGauss0_100_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroGaussiano7x7);

isnrMediana0_100_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroMediana3x3);

isnrMediana0_100_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroMediana7x7);

isnrAdaptativo0_100_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroAdaptativo3x3);

isnrAdaptativo0_100_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_100, ...
    imagenP4_0_100_FiltroAdaptativo7x7);

% Ruido Gaussiano(0,1225)
% -------------------------------------------------------------------------
isnrGauss0_1225_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroGaussiano3x3);

isnrGauss0_1225_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroGaussiano7x7);

isnrMediana0_1225_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroMediana3x3);

isnrMediana0_1225_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroMediana7x7);

isnrAdaptativo0_1225_3x3 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroAdaptativo3x3);

isnrAdaptativo0_1225_7x7 = calcularISNR(imagenP4, imagenP4RuidoGaussiano0_1225, ...
    imagenP4_0_1225_FiltroAdaptativo7x7);

% Ejercicio 4
% -------------------------------------------------------------------------

% Crear datos de ejemplo para la tabla
datos = ["5", "3", isnrGauss0_25_3x3, isnrMediana0_25_3x3, isnrAdaptativo0_25_3x3;
    "5", "7", isnrGauss0_25_7x7, isnrMediana0_25_7x7, isnrAdaptativo0_25_7x7;
    "10", "3", isnrGauss0_100_3x3, isnrMediana0_100_3x3, isnrAdaptativo0_100_3x3;
    "10", "7", isnrGauss0_100_7x7, isnrMediana0_100_7x7, isnrAdaptativo0_100_7x7;
    "35", "3", isnrGauss0_1225_3x3, isnrMediana0_1225_3x3, isnrAdaptativo0_1225_3x3;
    "35", "7", isnrGauss0_1225_7x7, isnrMediana0_1225_7x7, isnrAdaptativo0_1225_7x7;];

% Crear nombres de columna
nombresColumnas = {"Sigma Ruido", "Tamaño Ventana", "Filtro Gauss", ...
    "Filtro Mediana", "Filtro Adaptativo"};

% Crear una figura y una tabla
figura = uifigure('Position', [100 100 400 300]);
tabla = uitable(figura, 'Data', datos, 'ColumnName', nombres_columnas);

% Ajustar el tamaño de las columnas para que se ajusten automáticamente
tabla.ColumnWidth = {80};

% Ajustar el tamaño de la tabla para que se ajuste automáticamente al contenido
tabla.Position(3:4) = tabla.Extent(3:4);

% Ejercicio 5
% -------------------------------------------------------------------------

% En términos generales cuanto mayor es la ISNR, más calidad presenta la
% imagen, por lo que teniendolo en cuenta, el filtro que ha presentado
% mejores resultados es el filtro de Gauss.

% También se observa como los filtros tienden a equilibrar su rendimiento
% cuanto más desviación típica se ha aplicado al ruido con Gauss.

% Ejercicio 6
% -------------------------------------------------------------------------

desviacionTipica = 35;

% Generar 10 imágenes ruidosas, utilizamos imnoise por comodidad y cambiar
% el método empleado
numImagenes = 10;

% Vector de 10 elementos
imagenesRuidoGaussiano = cell(1, numImagenes);

for i = 1:num_imagenes

    % imnoise espera valores normalizados para la varianza, es decir, entre
    % 0 y 1, por lo que se divide entre 255 posibles valores de gris
    imagenesRuidoGaussiano{i} = imnoise(imagenP4, 'gaussian', 0, ...
        (desviacionTipica/255)^2);

end

imagenRuido = imagenesRuidoGaussiano{i};
figure;
imshow(imagenRuido);
title("Imagen Ruido Blanco Gaussiano");

% Ejercicio 7
% -------------------------------------------------------------------------

imagenPromediada = aplicarPromediado(imagenesRuidoGaussiano);

figure;
imshow(imagenPromediada);
title("Imagen Promediada");


