% Ejercicio 1
% -------------------------------------------------------------------------

% Primero leemos la imagen
imagenP3 = imread("P3.tif");

figure, imshow(imagenP3);
title("Imagen P3");

% Obtenemos dimensiones en filas y columnas
[filasP3, columnasP3] = size(imagenP3);

% Al contar la imagen con únicamente el color gris, solo
% presenta una matriz con un canal de color, por lo que no
% será necesario convertirla de RGB a gris, ya que es
% del formato MxNx1

% Amplitud de contraste

% Conseguimos el nivel máximo y mínimo de gris de la imagen 
% original
nivelGrisMaximo = max(imagenP3(:));
nivelGrisMinimo = min(imagenP3(:));

disp("Nivel gris maximo P3: " + nivelGrisMaximo);
disp("Nivel gris minimo P3: " + nivelGrisMinimo);

% Realizamos contracción del histograma

% Convertimos los valores a double para no afectar los calculos
nivelGrisMaximoContraccion = double(nivelGrisMaximo) - 50;
nivelGrisMinimoContraccion = double(nivelGrisMinimo) + 50;

% Creamos imagen con disminución del contraste
imagenP3ContraccionContraste = zeros(filasP3, columnasP3, "uint8");

% Implementamos contraccion
for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos contraccion de contraste
        nuevoPixel = nivelGrisMinimoContraccion + ...
            ((nivelGrisMaximoContraccion - nivelGrisMinimoContraccion) / ...
            (nivelGrisMaximo - nivelGrisMinimo)) * ...
            (pixelOriginal - nivelGrisMinimo); 

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3ContraccionContraste(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3ContraccionContraste);
title("Imagen P3 Contraccion Contraste");

% Realizamos expansión del histograma

nivelGrisMaximoExpansion = 255;
nivelGrisMinimoExpansion = 0;

% Creamos imagen con aumento del contraste
imagenP3ExpansionContraste = zeros(filasP3, columnasP3, "uint8");

% Implementamos expansion
for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos contraccion de contraste
        nuevoPixel = nivelGrisMinimoExpansion + ...
            ((nivelGrisMaximoExpansion - nivelGrisMinimoExpansion) / ...
            (nivelGrisMaximo - nivelGrisMinimo)) * ...
            (pixelOriginal - nivelGrisMinimo); 

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3ExpansionContraste(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3ExpansionContraste);
title("Imagen P3 Expansion Contraste");

% Función cuadrada

% Generamos nueva imagen rellena de ceros y de clase uint8
imagenP3FuncionCuadrada = zeros(filasP3, columnasP3, "uint8");

% Implementamos función cuadrada
for fila=1:filasP3
    for columna=1:columnasP3

        % Debemos convertir los valores de los pixeles de
        % la imagen original a double, ya que al estar en
        % la clase uint8 puede afectar a los resultados del
        % calculo, debido a que en uint8 ningun valor puede ser
        % superior a 255 ni inferior a 0.
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion cuadrada al pixel original
        nuevoPixel = power(pixelOriginal, 2) / 255;

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3FuncionCuadrada(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3FuncionCuadrada);
title("Imagen P3 Función Cuadrada");

% Función cúbica

% Generamos nueva imagen rellena de ceros y de clase uint8
imagenP3FuncionCubica = zeros(filasP3, columnasP3, "uint8");

% Implementamos función cúbica
for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion cúbica al pixel original
        nuevoPixel = power(pixelOriginal, 3) / power(255, 2);

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3FuncionCubica(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3FuncionCubica);
title("Imagen P3 Función Cúbica");

% Función Raíz Cuadrada

imagenP3RaizCuadrada = zeros(filasP3, columnasP3, "uint8");


for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion raíz cuadrada al pixel original
        nuevoPixel = sqrt(pixelOriginal * 255);

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3RaizCuadrada(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3RaizCuadrada);
title("Imagen P3 Función Raiz Cuadrada");

% Función Raíz Cúbica

imagenP3RaizCubica = zeros(filasP3, columnasP3, "uint8");

for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion raíz cubica al pixel original
        nuevoPixel = nthroot(power(255, 2) * pixelOriginal, 3);

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3RaizCubica(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3RaizCubica);
title("Imagen P3 Función Raiz Cubica");

% Función sigmoide dada por q1

alphaSigmoide = 0.85;

imagenP3SigmoideQ1 = zeros(filasP3, columnasP3, "uint8");

for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion sigmoide dada por q1 al pixel original
        nuevoPixel = (255 / 2) * (1 + (1 / sin(alphaSigmoide * pi / 2)) ...
            * sin(alphaSigmoide * pi * ((pixelOriginal / 255) - 1/2)));

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3SigmoideQ1(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3SigmoideQ1);
title("Imagen P3 Función Sigmoide Q1");

% Función Sigmoide dada por q2

imagenP3SigmoideQ2 = zeros(filasP3, columnasP3, "uint8");

for fila=1:filasP3
    for columna=1:columnasP3
        pixelOriginal = double(imagenP3(fila, columna));

        % Aplicamos funcion sigmoide dada por q1 al pixel original
        nuevoPixel = (255 / 2) * (1 + (1 / tan(alphaSigmoide * pi / 2)) ...
            * tan(alphaSigmoide * pi * ((pixelOriginal / 255) - 1/2)));

        % Asignamos el valor del nuevo pixel en la imagen
        % resultante convertido a uint8
        imagenP3SigmoideQ2(fila, columna) = uint8(nuevoPixel);
    end
end

figure, imshow(imagenP3SigmoideQ2);
title("Imagen P3 Función Sigmoide Q2");

% Ejercicio 2
% -------------------------------------------------------------------------

brilloP3 = calcularBrillo(imagenP3);
contrasteP3 = calcularContraste(imagenP3);
disp("Brillo P3: " + brilloP3);
disp("Contraste P3: " + contrasteP3);
figure, imhist(imagenP3);
title("Histograma P3");

brilloP3ContraccionContraste = calcularBrillo(imagenP3ContraccionContraste);
contrasteP3ContraccionContraste = calcularContraste(imagenP3ContraccionContraste);
disp("Brillo P3 Contraccion Contraste: " + brilloP3ContraccionContraste);
disp("Contraste P3 Contraccion Contraste: " + contrasteP3ContraccionContraste);
figure, imhist(imagenP3ContraccionContraste);
title("Histograma P3 Contraccion Contraste");

brilloP3ExpansionContraste = calcularBrillo(imagenP3ExpansionContraste);
contrasteP3ExpansionContraste = calcularContraste(imagenP3ExpansionContraste);
disp("Brillo P3 Expansion Contraste: " + brilloP3ExpansionContraste);
disp("Contraste P3 Expansion Contraste: " + contrasteP3ExpansionContraste);
figure, imhist(imagenP3ExpansionContraste);
title("Histograma P3 Expansion Contraste");

brilloP3 = calcularBrillo(imagenP3);
contrasteP3 = calcularContraste(imagenP3);
disp("Brillo P3: " + brilloP3);
disp("Contraste P3: " + contrasteP3);
figure, imhist(imagenP3);
title("Histograma P3");

brilloP3FuncionCuadrada = calcularBrillo(imagenP3FuncionCuadrada);
contrasteP3FuncionCuadrada = calcularContraste(imagenP3FuncionCuadrada);
disp("Brillo P3 Función Cuadrada: " + brilloP3FuncionCuadrada);
disp("Contraste P3 Función Cuadrada: " + contrasteP3FuncionCuadrada);
figure, imhist(imagenP3FuncionCuadrada);
title("Histograma P3 Función Cuadrada");

brilloP3FuncionCubica = calcularBrillo(imagenP3FuncionCubica);
contrasteP3FuncionCubica = calcularContraste(imagenP3FuncionCubica);
disp("Brillo P3 Función Cúbica: " + brilloP3FuncionCubica);
disp("Contraste P3 Función Cúbica: " + contrasteP3FuncionCubica);
figure, imhist(imagenP3FuncionCubica);
title("Histograma P3 Función Cúbica");

brilloP3RaizCuadrada = calcularBrillo(imagenP3RaizCuadrada);
contrasteP3RaizCuadrada = calcularContraste(imagenP3RaizCuadrada);
disp("Brillo P3 Raíz Cuadrada: " + brilloP3RaizCuadrada);
disp("Contraste P3 Raíz Cuadrada: " + contrasteP3RaizCuadrada);
figure, imhist(imagenP3RaizCuadrada);
title("Histograma P3 Raíz Cuadrada");

brilloP3RaizCubica = calcularBrillo(imagenP3RaizCubica);
contrasteP3RaizCubica = calcularContraste(imagenP3RaizCubica);
disp("Brillo P3 Raíz Cúbica: " + brilloP3RaizCubica);
disp("Contraste P3 Raíz Cúbica: " + contrasteP3RaizCubica);
figure, imhist(imagenP3RaizCubica);
title("Histograma P3 Raíz Cúbica");

brilloP3SigmoideQ1 = calcularBrillo(imagenP3SigmoideQ1);
contrasteP3SigmoideQ1 = calcularContraste(imagenP3SigmoideQ1);
disp("Brillo P3 Sigmoide Q1: " + brilloP3SigmoideQ1);
disp("Contraste P3 Sigmoide Q1: " + contrasteP3SigmoideQ1);
figure, imhist(imagenP3SigmoideQ1);
title("Histograma P3 Sigmoide Q1");

brilloP3SigmoideQ2 = calcularBrillo(imagenP3SigmoideQ2);
contrasteP3SigmoideQ2 = calcularContraste(imagenP3SigmoideQ2);
disp("Brillo P3 Sigmoide Q2: " + brilloP3SigmoideQ2);
disp("Contraste P3 Sigmoide Q2: " + contrasteP3SigmoideQ2);
figure, imhist(imagenP3SigmoideQ2);
title("Histograma P3 Sigmoide Q2");

% Ejercicio 3
% -------------------------------------------------------------------------

h = imhist(imagenP3);

funcion_HistAcum(h);
