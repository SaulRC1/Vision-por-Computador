imagenP5 = imread("P5.tif");

% Conseguir la imagen de intensidad
imagenP5Intensidad = rgb2gray(imagenP5);

% Conseguir imagen de intensidad con filtro gaussiano
filtroGaussiano = fspecial("gaussian", [5, 5], ...
    1.0);
imagenP5IntensidadGauss = imfilter(imagenP5Intensidad, ...
    filtroGaussiano, ...
    "conv", "replicate");

% Ejercicio 7
% -------------------------------------------------------------------------

[imagenP5Sobel, umbralP5] = edge(imagenP5Intensidad,"sobel");
imagenP5Sobel_0_4 = edge(imagenP5Intensidad,"sobel", (0.4 * umbralP5));

[imagenP5GaussSobel, umbralP5Gauss] = edge(imagenP5IntensidadGauss,"sobel");
imagenP5GaussSobel_0_4 = edge(imagenP5IntensidadGauss,"sobel", ...
    (0.4 * umbralP5Gauss));


figure;

subplot(2, 2, 1);
imshow(imagenP5Sobel);
title("Imagen de Intensidad P5 Sobel");

subplot(2, 2, 2);
imshow(imagenP5Sobel_0_4);
title("Imagen de Intensidad P5 Sobel Umbralx0.4");

subplot(2, 2, 3);
imshow(imagenP5GaussSobel);
title("Imagen de Intensidad P5 Sobel Gauss");

subplot(2, 2, 4);
imshow(imagenP5GaussSobel_0_4);
title("Imagen de Intensidad P5 Sobel Gauss Umbralx0.4");


% Ejercicio 8
% -------------------------------------------------------------------------

% Establecemos las máscaras de Sobel
HxSobel = [-1 0 1; -2 0 2; -1 0 1];
HySobel = [-1 -2 -1; 0 0 0; 1 2 1];

[Gx, Gy, Em] = Funcion_Calcula_Gradiente(imagenP5Intensidad, HxSobel, HySobel);

Eo = calcularAnguloGradiente(Gx, Gy);

imagenSupresionNoMaxima = aplicarSupresionNoMaxima(Em, Eo);
imagenBordesCanny = aplicarHisteresisDeUmbral(imagenSupresionNoMaxima, Eo, ...
    umbralP5, (0.4 * umbralP5));

figure;
imshow(mat2gray(imagenBordesCanny));
title("Imagen de Bordes Canny");


% Ejercicio 9
% -------------------------------------------------------------------------

imagenP5LaplacianaGaussiana = ...
    aplicarLaplacianaGaussiana(imagenP5Intensidad, 1.0);

figure;
imshow(mat2gray(imagenP5LaplacianaGaussiana));
title("Bordes detectados por el Laplaciano de la Gaussiana");