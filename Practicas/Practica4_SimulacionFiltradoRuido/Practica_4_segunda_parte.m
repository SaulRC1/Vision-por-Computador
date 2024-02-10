imagenP4 = imread("P4.tif");

% Sal y pimienta con p = 0.9 y q = 0.95
p = 0.9;
q = 0.95;
% Porcentaje de pixeles con ruido sal y pimienta
porcentajePimienta = q - p;
porcentajeSal = 1 - q;

% Generar la matriz x, uniforme de rango (0, 1)
x = rand(size(imagenP4));

% Primera condición, pixeles originales
x(x < p) = imagenP4(x < p);

% Segunda condición
x(p <= x & x < q) = 0;

% Tercera condición
x(q <= x & x < 1) = 255;

imagenP4SalYPimienta = uint8(x);

% Apartado a
% -------------------------------------------------------------------------

% Definimos una desviación estandar de 1, ya que W = 5
desviacionEstandar = 1;

% Se calcula el tamaño del filtro
W = 5 * desviacionEstandar;

% Creamos la máscara en codigo Matlab
mascaraCodigoMatlab = mascaraFiltroGaussiano(W, desviacionEstandar);

imagenP4FiltradaCodigoMatlab = imfilter(imagenP4SalYPimienta, ...
    mascaraCodigoMatlab, "conv", "replicate");

% Se crea la máscara del filtro gaussiano utilizando fspecial
% con las dimensiones designadas por W
filtroGaussiano = fspecial("gaussian", [W, W], ...
    desviacionEstandar);

% Se aplica la convolución con imfilter
imagenFiltradaFspecial = imfilter(imagenP4SalYPimienta, ...
    filtroGaussiano, ...
    "conv", "replicate");

% Mostrar las imágenes original y filtrada
subplot(3, 1, 1);
imshow(imagenP4SalYPimienta);
title("Imagen P4 Sal y Pimienta");

subplot(3, 1, 2);
imshow(imagenFiltradaFspecial);
title("Imagen Filtrada con Filtro Gaussiano fspecial");

subplot(3, 1, 3);
imshow(imagenP4FiltradaCodigoMatlab);
title("Imagen Filtrada con Codigo Matlab");

if isequal(imagenFiltradaFspecial, imagenP4FiltradaCodigoMatlab)
    disp("Ambas imagenes [imagenFiltradaFspecial, imagenP4FiltradaCodigoMatlab " ...
    + "son idénticas");
end

% Apartado b
% -------------------------------------------------------------------------
matrizVecindad = randi([0, 1], 5, 5);
imagenP4FiltroMediana = Funcion_FiltroMediana(imagenP4SalYPimienta, ...
    matrizVecindad, "symmetric");

imagenP4FiltroMedianaConMedfilt2 = medfilt2(imagenP4SalYPimienta, ...
    [5, 5], "symmetric");

figure;

subplot(1, 2, 1);
imshow(imagenP4FiltroMediana);
title("Imagen P4 Con Ruido Filtro Mediana");

subplot(1, 2, 2);
imshow(imagenP4FiltroMedianaConMedfilt2);
title("Imagen P4 Con Ruido medfilt2");

if isequal(imagenP4FiltroMediana, imagenP4FiltroMedianaConMedfilt2)
    disp("Ambas imagenes [imagenP4FiltroMediana, imagenP4FiltroMedianaConMedfilt2] " ...
    + "son idénticas");
end

% Apartado c
% -------------------------------------------------------------------------
matrizVecindad7x7 = randi([0, 1], 7, 7);

% Calculamos la varianza del ruido presente en la imagen

% Para ello primero hemos de calcular el ruido presente en
% la imagen con ruido sal y pimienta, mediante la formula
% G(x,y) = I(x,y) + e(x,y), si aislamos el error e nos queda
% la formula e(x,y) = I(x,y) - G(x,y)

[filas, columnas] = size(imagenP4);

% Creamos la matriz con el valor del error de cada pixel
matrizError = zeros(filas, columnas, "uint8");

for fila = 1:filas
    for columna = 1:columnas
        matrizError(fila, columna) = imagenP4(fila, columna) ...
            - imagenP4SalYPimienta(fila, columna);
    end
end

% Calculamos varianza
varianzaRuido = power(std(double(matrizError), 0, "all"), 2);

imagenP4FiltroAdaptativo = Funcion_FiltAdapt(imagenP4SalYPimienta, ...
    matrizVecindad7x7, varianzaRuido, "symmetric");


% Utilizamos la función con filtro adaptativo matricial

imagenP4FiltroAdaptativoMatricial = Funcion_FiltAdaptMatricial(imagenP4SalYPimienta, ...
    matrizVecindad7x7, varianzaRuido, "symmetric");

figure;

subplot(1, 2, 1);
imshow(imagenP4FiltroAdaptativo);
title("Imagen P4 Con Ruido Filtro Adaptativo");

subplot(1, 2, 2);
imshow(imagenP4FiltroAdaptativoMatricial);
title("Imagen P4 Con Ruido Filtro Adaptativo Matricial");


