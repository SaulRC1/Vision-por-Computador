% Ejercicio 1
% -------------------------------------------------------------------------
imagenP5 = imread("P5.tif");

% Conseguir la imagen de intensidad
imagenP5Intensidad = rgb2gray(imagenP5);

% Conseguir imagen de intensidad con filtro gaussiano
filtroGaussiano = fspecial("gaussian", [5, 5], ...
    1.0);
imagenP5IntensidadGauss = imfilter(imagenP5Intensidad, ...
    filtroGaussiano, ...
    "conv", "replicate");

% Mostrar ambas imágenes
figure;
subplot(1, 2, 1);
imshow(imagenP5Intensidad);
title("Imagen de intensidad");
subplot(1, 2, 2);
imshow(imagenP5IntensidadGauss);
title("Imagen intensidad con filtro gaussiano 5x5");

% Ejercicio 2
% -------------------------------------------------------------------------

% Calcular el número de filas de la imagen
N = size(imagenP5Intensidad, 1);

% Calcular las posiciones de las líneas horizontales
posicionesLineas = round([0.25*N, 0.5*N, 0.75*N]);

% Calcular los perfiles de intensidad para cada línea horizontal
perfil_25 = imagenP5Intensidad(posicionesLineas(1), :);
perfil_50 = imagenP5Intensidad(posicionesLineas(2), :);
perfil_75 = imagenP5Intensidad(posicionesLineas(3), :);

% Crear el gráfico para los perfiles de intensidad
figure;
plot(perfil_25, "r", "LineWidth", 1.5);
hold on;
plot(perfil_50, "g", "LineWidth", 1.5);
plot(perfil_75, "b", "LineWidth", 1.5);
hold off;

xlabel("Posición en la imagen");
ylabel("Intensidad");
axis("equal");
title("Perfiles de intensidad en líneas horizontales");
legend("25% de la altura", "50% de la altura", "75% de la altura");

% Se puede observar como hay un gran variación en los niveles de gris
% sobre todo en el 75% de la altura donde la separación de bordes es
% clara.