imagenP5 = imread("P5.tif");

% Conseguir la imagen de intensidad
imagenP5Intensidad = rgb2gray(imagenP5);

% Conseguir imagen de intensidad con filtro gaussiano
filtroGaussiano = fspecial("gaussian", [5, 5], ...
    1.0);
imagenP5IntensidadGauss = imfilter(imagenP5Intensidad, ...
    filtroGaussiano, ...
    "conv", "replicate");

% Ejercicio 4
% -------------------------------------------------------------------------

% Establecemos las máscaras de Sobel
HxSobel = [-1 0 1; -2 0 2; -1 0 1];
HySobel = [-1 -2 -1; 0 0 0; 1 2 1];

[Gx, Gy, ModG] = Funcion_Calcula_Gradiente(imagenP5Intensidad, HxSobel, HySobel);

% Calcular los umbrales, teniendo en cuenta el valor maximo de
% la magnitud
umbral_10 = 0.1 * max(ModG(:));
umbral_25 = 0.25 * max(ModG(:));
umbral_50 = 0.5 * max(ModG(:));
umbral_75 = 0.75 * max(ModG(:));

% Binarizar la magnitud del gradiente con los umbrales
bordes_10 = obtenerImagenBinariaBordes(ModG, umbral_10);
bordes_25 = obtenerImagenBinariaBordes(ModG, umbral_25);
bordes_50 = obtenerImagenBinariaBordes(ModG, umbral_50);
bordes_75 = obtenerImagenBinariaBordes(ModG, umbral_75);

% Visualizar las magnitudes de Gx, Gy y ModG
figure;

subplot(3, 1, 1);
imshow(mat2gray(Gx));
title("Magnitud de Gx");
colorbar;

subplot(3, 1, 2);
imshow(mat2gray(Gy));
title("Magnitud de Gy");
colorbar;

subplot(3, 1, 3);
imshow(mat2gray(ModG));
title("Magnitud de ModG");
colorbar;

% Visualizar las imágenes binarias de bordes
figure;

subplot(2, 2, 1);
imshow(bordes_10);
title("Bordes (Umbral 10%)");

subplot(2, 2, 2);
imshow(bordes_25);
title("Bordes (Umbral 25%)");

subplot(2, 2, 3);
imshow(bordes_50);
title("Bordes (Umbral 50%)");

subplot(2, 2, 4);
imshow(bordes_75);
title("Bordes (Umbral 75%)");

% Ejercicio 5
% -------------------------------------------------------------------------

[GxGauss, GyGauss, ModG_Gauss] = ...
    Funcion_Calcula_Gradiente(imagenP5IntensidadGauss, HxSobel, HySobel);

% Calcular los umbrales, teniendo en cuenta el valor maximo de
% la magnitud
umbral_10_Gauss = 0.1 * max(ModG_Gauss(:));
umbral_25_Gauss = 0.25 * max(ModG_Gauss(:));
umbral_50_Gauss = 0.5 * max(ModG_Gauss(:));
umbral_75_Gauss = 0.75 * max(ModG_Gauss(:));

% Binarizar la magnitud del gradiente con los umbrales
bordes_10_Gauss = obtenerImagenBinariaBordes(ModG_Gauss, umbral_10_Gauss);
bordes_25_Gauss = obtenerImagenBinariaBordes(ModG_Gauss, umbral_25_Gauss);
bordes_50_Gauss = obtenerImagenBinariaBordes(ModG_Gauss, umbral_50_Gauss);
bordes_75_Gauss = obtenerImagenBinariaBordes(ModG_Gauss, umbral_75_Gauss);

% Visualizar las magnitudes de Gx, Gy y ModG
figure;

subplot(3, 1, 1);
imshow(mat2gray(GxGauss));
title("Magnitud de Gx Gauss");
colorbar;

subplot(3, 1, 2);
imshow(mat2gray(GyGauss));
title("Magnitud de Gy Gauss");
colorbar;

subplot(3, 1, 3);
imshow(mat2gray(ModG_Gauss));
title("Magnitud de ModG Gauss");
colorbar;

% Visualizar las imágenes binarias de bordes
figure;

subplot(2, 2, 1);
imshow(bordes_10_Gauss);
title("Bordes (Umbral 10%) Gauss");

subplot(2, 2, 2);
imshow(bordes_25_Gauss);
title("Bordes (Umbral 25%) Gauss");

subplot(2, 2, 3);
imshow(bordes_50_Gauss);
title("Bordes (Umbral 50%) Gauss");

subplot(2, 2, 4);
imshow(bordes_75_Gauss);
title("Bordes (Umbral 75%) Gauss");

% Se observa que la imagen filtrada con Gauss necesita de menos umbral para
% presentar una clara diferenciación de bordes, al estar más limpia de
% ruido.

% Ejercicio 6
% -------------------------------------------------------------------------

% En este caso se utilizaran las máscaras de Roberts ya que presenta buena
% respuesta ante bordes diagonales, precisamente los correspondientes a
% los bordes de la carretera.
HxRoberts = [-1 0 0; 0 1 0; 0 0 0];
HyRoberts = [0 1 0; -1 0 0; 0 0 0];

% Ya que el detector de Roberts es muy sensible al ruido, se suavizará
% la imagen mediante un filtro gaussiano

filtroGaussiano = fspecial("gaussian", [5, 5], ...
    2.0);
imagenP5IntensidadGauss_Roberts = imfilter(imagenP5Intensidad, ...
    filtroGaussiano, ...
    "conv", "replicate");

[GxRoberts, GyRoberts, ModGRoberts] = Funcion_Calcula_Gradiente(imagenP5Intensidad, HxRoberts, HyRoberts);

umbralRoberts = 0.20 * max(ModGRoberts(:));

bordesRoberts = obtenerImagenBinariaBordes(ModGRoberts, umbralRoberts);

figure;
imshow(bordesRoberts);
title("Bordes (Umbral 20%) Roberts");
