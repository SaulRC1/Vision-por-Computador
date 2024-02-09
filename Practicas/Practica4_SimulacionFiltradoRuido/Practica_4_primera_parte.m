% Ejercicio 1
% -------------------------------------------------------------------------

imagenP4 = imread("P4.tif");

% Ejercicio 2
% -------------------------------------------------------------------------

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

% Gaussiano de media nula y desviación típica 10

% Primero obtenemos la distribución gaussiana de media nula y
% varianza 1
distribucionGaussiana0_1 = randn(size(imagenP4), "double");

% La desviación típica es la raíz cuadrada positiva de la
% varianza
distribucionGaussiana0_100 = 0 + 10 * distribucionGaussiana0_1;

% Para el ruido gaussiano el valor del pixel con ruido será
% el del ideal más una cantidad correspondiente al error, es
% decir, cada pixel (x,y) sumado a su correspondiente elemento
% en la distribución gaussiana
imagenP4RuidoGaussiano0_100 = uint8(double(imagenP4) + ...
distribucionGaussiana0_100);

% Ejercicio 3
% -------------------------------------------------------------------------

figure;

subplot(1, 3, 1);
imshow(imagenP4);
title("Imagen P4 original");

subplot(1, 3, 2);
imshow(imagenP4RuidoGaussiano0_100);
title("Imagen P4 Ruido Gaussiano");

subplot(1, 3, 3);
imshow(imagenP4SalYPimienta);
title("Imagen P4 Sal y Pimienta");

% Obtener la línea horizontal central de las imágenes
filaCentral = round(size(imagenP4, 1) / 2);

% Obtener los valores de intensidad a lo largo de la línea horizontal central
intensidadOriginal = imagenP4(filaCentral, :);
intensidadSalYPimienta = imagenP4SalYPimienta(filaCentral, :);
intensidadGaussiano = imagenP4RuidoGaussiano0_100(filaCentral, :);

figure;
plot(intensidadOriginal, 'b', 'LineWidth', 1.5);
hold on;
plot(intensidadSalYPimienta, 'r', 'LineWidth', 1.5);
plot(intensidadGaussiano, 'g', 'LineWidth', 1.5);
hold off;

title('Variación de niveles de gris a lo largo de la línea horizontal central');
xlabel('Posición en la imagen');
ylabel('Intensidad de gris');
legend('Original', 'Ruido sal y pimienta', 'Ruido gaussiano');