imagenOriginal = imread("P1b.jpg");

%coordenadasX = [50 100 150 200];
%coordenadasY = [20 40 60 250];

%c = [222 272 300 270 221 194];
%r = [21 21 75 121 121 75];

%mascaraBinaria = roipoly(imagenOriginal, coordenadasX, coordenadasY);

mascaraBinaria = roipoly(imagenOriginal);

%figure, imshow(mascaraBinaria);

[filas, columnas] = size(mascaraBinaria);

imagenRecortada = zeros(filas, columnas, 'uint8');

for fila=1:filas
    for columna=1:columnas
        if mascaraBinaria(fila, columna) == 1
            imagenRecortada(fila, columna, :) = ...
                imagenOriginal(fila, columna, :);
        end
    end
end

%figure, imshow(imagenRecortada);

% Mediante multiplicacion de vectores
%imagenRecortada2 = imagenOriginal.*uint8(mascaraBinaria);
%figure, imshow(imagenRecortada2);

% Se recorta el area de interes
[filasAreaInteres, columnasAreaInteres] = find(mascaraBinaria);

minFila = min(filasAreaInteres);
maxFila = max(filasAreaInteres);

minColumna = min(columnasAreaInteres);
maxColumna = max(columnasAreaInteres);

areaInteres = imagenRecortada(minFila:maxFila, minColumna:maxColumna, :);

%figure, imshow(areaInteres);

% Siendo N la altura de la imagen y M la anchura
[N, M] = size(areaInteres);

disp("anchura: " + M + ",altura: " + N);

% Ejercicio 1
% -------------------------------------------------------------------------
sumatorioBrillo = uint64(0);

for fila=1:N
    for columna=1:M
        sumatorioBrillo = sumatorioBrillo + ...
        uint64(areaInteres(fila, columna));
        %disp("areaInteres(" + fila + ", " + columna + "): " ...
            %+ areaInteres(fila, columna));
    end
end

brillo = sumatorioBrillo / (M * N);

disp("Brillo: " + brillo);

sumatorioContraste = uint64(0);

for fila=1:N
    for columna=1:M
        sumatorioContraste = sumatorioContraste + ...
        power(uint64(areaInteres(fila, columna)) - brillo, 2);
    end
end

pasoIntermedioContraste = sumatorioContraste / (M * N);
contraste = sqrt(double(pasoIntermedioContraste));

disp("Contraste: " + contraste);

% Ejercicio 2
% -------------------------------------------------------------------------

% Imagen de mayor brillo
imagenMayorBrillo = zeros(N, M, "uint8");

% Imagen de menor brillo
imagenMenorBrillo = zeros(N, M, "uint8");

% Utilizamos un valor de desplazamiento del
% histograma de 50 y del mismo tipo uint8
desplazamiento = uint8(50);

% Construimos ambas imagenes
for fila=1:N
    for columna=1:M
        pixelMayorBrillo = areaInteres(fila, columna) ...
            + desplazamiento;

        % Ya que se utiliza la clase uint8 no será necesario comprobar que
        % el valor del pixel con mayor brillo supere 255, esto es debido a
        % que uint8 tiene como valor máximo 255
        imagenMayorBrillo(fila, columna) = pixelMayorBrillo;

        pixelMenorBrillo = areaInteres(fila, columna) ...
            - desplazamiento;

        % Ya que se utiliza la clase uint8 no será necesario comprobar que
        % el valor del pixel con menor brillo sea menor que 0, ya que uint8
        % son enteros sin signo, por lo que el nº mínimo es 0.
        imagenMenorBrillo(fila, columna) = pixelMenorBrillo;
    end
end

%figure, imshow(areaInteres);
%title("Imagen Normal");
disp("Brillo imagen normal: " + calcularBrillo(areaInteres));

%figure, imshow(imagenMayorBrillo);
%title("Imagen Mayor Brillo");
disp("Brillo imagen mayor brillo: " + calcularBrillo(imagenMayorBrillo));

%figure, imshow(imagenMenorBrillo);
%title("Imagen Menor Brillo");
disp("Brillo imagen menor brillo: " + calcularBrillo(imagenMenorBrillo));

% Ejercicio 3
% -------------------------------------------------------------------------

imagenMayorContraste = zeros(N, M, "uint8");
imagenMenorContraste = zeros(N, M, "uint8");

valorGrisMaximo = max(areaInteres(:));
valorGrisMinimo = min(areaInteres(:));

disp("Nivel gris maximo: " + valorGrisMaximo);
disp("Nivel gris minimo: " + valorGrisMinimo);

valorGrisMaximoMayorContraste = 255;
valorGrisMinimoMayorContraste = 0;

valorGrisMaximoMenorContraste = double(valorGrisMaximo) - 50;
valorGrisMinimoMenorContraste = double(valorGrisMinimo) + 50;

for fila=1:N
    for columna=1:M
        pixelMayorContraste = valorGrisMinimoMayorContraste ...
            + ((valorGrisMaximoMayorContraste - valorGrisMinimoMayorContraste) ...
            / (double(valorGrisMaximo) - double(valorGrisMinimo))) * ...
            (double(areaInteres(fila, columna)) - double(valorGrisMinimo));

        imagenMayorContraste(fila, columna) = uint8(pixelMayorContraste);

        pixelMenorContraste = valorGrisMinimoMenorContraste ...
            + ((valorGrisMaximoMenorContraste - valorGrisMinimoMenorContraste) ...
            / (double(valorGrisMaximo) - double(valorGrisMinimo))) * ...
            (double(areaInteres(fila, columna)) - double(valorGrisMinimo));

        imagenMenorContraste(fila, columna) = uint8(pixelMenorContraste);
    end
end

%figure, imshow(areaInteres);
%title("Imagen Normal");
disp("Contraste imagen normal: " + calcularContraste(areaInteres));

%figure, imshow(imagenMayorContraste);
%title("Imagen Mayor Contraste");
disp("Contraste imagen mayor contraste: " + calcularContraste(imagenMayorContraste));

%figure, imshow(imagenMenorContraste);
%title("Imagen Menor Contraste");
disp("Contraste imagen menor contraste: " + calcularContraste(imagenMenorContraste));

% Ejercicio 4
% -------------------------------------------------------------------------

help imfilter;

% Ejercicio 5
% -------------------------------------------------------------------------

HP = ones(5,5)/25;
HL = [-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];

imagenNormalFiltroHP = imfilter(areaInteres, HP);
imagenNormalFiltroHL = imfilter(areaInteres, HL);

figure, imshow(areaInteres);
title("Imagen Normal");

figure, imshow(imagenNormalFiltroHP);
title("Imagen con filtro HP");

figure, imshow(imagenNormalFiltroHL);
title("Imagen con filtro HL");

HP_Alternativa = ones(9,9)/81;

imagenNormalFiltroHPAlternativo = imfilter(areaInteres, HP_Alternativa);

figure, imshow(imagenNormalFiltroHPAlternativo);
title("Imagen con filtro HP Alternativo");
