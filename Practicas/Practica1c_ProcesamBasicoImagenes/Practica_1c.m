imagenOriginal = imread("P1b.jpg");

%coordenadasX = [50 100 150 200];
%coordenadasY = [20 40 60 250];

%c = [222 272 300 270 221 194];
%r = [21 21 75 121 121 75];

%mascaraBinaria = roipoly(imagenOriginal, coordenadasX, coordenadasY);

mascaraBinaria = roipoly(imagenOriginal);

figure, imshow(mascaraBinaria);

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

figure, imshow(imagenRecortada);

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

figure, imshow(areaInteres);

