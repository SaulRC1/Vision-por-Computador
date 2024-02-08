% Ejercicio 13
% -------------------------------------------------------------------------
color1 = imread('Color1.bmp');
color2 = imread('Color2.bmp');
color3 = imread('Color3.bmp');
color4 = imread('Color4.bmp');
colorPatron = imread('ColorPatron.bmp');

% Extraer componentes RGB de la imagen ColorPatron
patronR = colorPatron(:,:,1);
patronG = colorPatron(:,:,2);
patronB = colorPatron(:,:,3);

histogramaPatronR = imhist(patronR);
histogramaPatronG = imhist(patronG);
histogramaPatronB = imhist(patronB);

%figure, imhist(patronR);
%title("patron R");

%figure, imhist(patronG);
%title("patron G");

%figure, imhist(patronB);
%title("patron B");

% Si nos fijamos en los histogramas de cada color de la imagen
% ColorPatron.bmp observamos que para cada uno, donde existe
% una mayor concentracion de valores es donde se encuentran
% los pixeles correspondientes a la retina, ya que ocupan
% la mayor parte de la imagen, además observandose que están
% alejados del 0 que es el negro absoluto, esa parte del
% histograma es la que se debe eliminar para solo utilizar
% la información de la retina, ya que corresponde a los bordes.

% Para el color rojo solo se tendran en cuenta los valores más
% allá del 100
histogamaRecortadoPatronR = zeros(256, 1);
histogamaRecortadoPatronR(100:256) = histogramaPatronR(100:256);
%figure, plot(histrogamaRecortadoPatronR);

% Para el color verde aquellos más allá del 50
histogamaRecortadoPatronG = zeros(256, 1);
histogamaRecortadoPatronG(50:256) = histogramaPatronG(50:256);

% Para el color azul aquellos más allá del 20
histogamaRecortadoPatronB = zeros(256, 1);
histogamaRecortadoPatronB(20:256) = histogramaPatronB(20:256);

% Aplicar la ecualización de histograma a cada 
% componente de las imágenes Color1, Color2, Color3
% y Color4
[filasC1, columnasC1, dimensionesC1] = size(color1);
color1Equalizado = zeros(filasC1, columnasC1, dimensionesC1, "uint8");

color1EqualizadoR = histeq(color1(:, :, 1), histogamaRecortadoPatronR);
color1EqualizadoG = histeq(color1(:, :, 2), histogamaRecortadoPatronG);
color1EqualizadoB = histeq(color1(:, :, 3), histogamaRecortadoPatronB);

color1Equalizado(:, :, 1) = color1EqualizadoR;
color1Equalizado(:, :, 2) = color1EqualizadoG;
color1Equalizado(:, :, 3) = color1EqualizadoB;

[filasC2, columnasC2, dimensionesC2] = size(color2);
color2Equalizado = zeros(filasC2, columnasC2, dimensionesC2, "uint8");

color2EqualizadoR = histeq(color2(:, :, 1), histogamaRecortadoPatronR);
color2EqualizadoG = histeq(color2(:, :, 2), histogamaRecortadoPatronG);
color2EqualizadoB = histeq(color2(:, :, 3), histogamaRecortadoPatronB);

color2Equalizado(:, :, 1) = color2EqualizadoR;
color2Equalizado(:, :, 2) = color2EqualizadoG;
color2Equalizado(:, :, 3) = color2EqualizadoB;

[filasC3, columnasC3, dimensionesC3] = size(color3);
color3Equalizado = zeros(filasC3, columnasC3, dimensionesC3, "uint8");

color3EqualizadoR = histeq(color3(:, :, 1), histogamaRecortadoPatronR);
color3EqualizadoG = histeq(color3(:, :, 2), histogamaRecortadoPatronG);
color3EqualizadoB = histeq(color3(:, :, 3), histogamaRecortadoPatronB);

color3Equalizado(:, :, 1) = color3EqualizadoR;
color3Equalizado(:, :, 2) = color3EqualizadoG;
color3Equalizado(:, :, 3) = color3EqualizadoB;

[filasC4, columnasC4, dimensionesC4] = size(color4);
color4Equalizado = zeros(filasC4, columnasC4, dimensionesC4, "uint8");

color4EqualizadoR = histeq(color4(:, :, 1), histogamaRecortadoPatronR);
color4EqualizadoG = histeq(color4(:, :, 2), histogamaRecortadoPatronG);
color4EqualizadoB = histeq(color4(:, :, 3), histogamaRecortadoPatronB);

color4Equalizado(:, :, 1) = color4EqualizadoR;
color4Equalizado(:, :, 2) = color4EqualizadoG;
color4Equalizado(:, :, 3) = color4EqualizadoB;

% Mostrar las imágenes resultantes
figure;
subplot(2, 2, 1); imshow(color1Equalizado); title('Color1 ecualizado');
subplot(2, 2, 2); imshow(color2Equalizado); title('Color2 ecualizado');
subplot(2, 2, 3); imshow(color3Equalizado); title('Color3 ecualizado');
subplot(2, 2, 4); imshow(color4Equalizado); title('Color4 ecualizado');

% Ejercicio 14
% -------------------------------------------------------------------------

figure;
subplot(3, 1, 1);
plot(histogramaPatronR, 'r'); hold on;
plot(histogramaPatronG, 'g');
plot(histogramaPatronB, 'b');
title('Histogramas de la imagen patrón');
legend('Rojo', 'Verde', 'Azul');

subplot(3, 2, 3);
plot(imhist(color1(:, :, 1)), 'r'); hold on;
plot(imhist(color1(:, :, 2)), 'g');
plot(imhist(color1(:, :, 3)), 'b');
title('Histogramas de la imagen color 1');
legend('Rojo', 'Verde', 'Azul');

subplot(3, 2, 4);
plot(imhist(color2(:, :, 1)), 'r'); hold on;
plot(imhist(color2(:, :, 2)), 'g');
plot(imhist(color2(:, :, 3)), 'b');
title('Histogramas de la imagen color 2');
legend('Rojo', 'Verde', 'Azul');

subplot(3, 2, 5);
plot(imhist(color3(:, :, 1)), 'r'); hold on;
plot(imhist(color3(:, :, 2)), 'g');
plot(imhist(color3(:, :, 3)), 'b');
title('Histogramas de la imagen color 3');
legend('Rojo', 'Verde', 'Azul');

subplot(3, 2, 6);
plot(imhist(color4(:, :, 1)), 'r'); hold on;
plot(imhist(color4(:, :, 2)), 'g');
plot(imhist(color4(:, :, 3)), 'b');
title('Histogramas de la imagen color 4');
legend('Rojo', 'Verde', 'Azul');

% Ejercicio 15
% -------------------------------------------------------------------------
% Se observa como efectivamente todos los histogramas
% de las imágenes resultantes tras la especificación de 
% sus histogramas originales se asemejan al de la imagen
% utilizada como patrón.

% Esto ha ayudado a mejorar la uniformidad de los histogramas,
% facilmente observable al visualizarlos.

