% Ejercicio 1
%------------------------------------------------------
info = imfinfo("P1a.jpg");

disp("Anchura en pixeles: " + info.Width);
disp("Altura en pixeles: " + info.Height);
disp("Profundidad de bit: " + info.BitDepth);
%------------------------------------------------------
% Ejercicio 2
%------------------------------------------------------
Imagen1 = imread("P1a.jpg");
%------------------------------------------------------
% Ejercicio 3
%------------------------------------------------------
whos Imagen1;
%------------------------------------------------------
% Ejercicio 4
%------------------------------------------------------
mayorElementoImagen1 = max(Imagen1, [], "all");

disp("Mayor elemento: " + mayorElementoImagen1);
%------------------------------------------------------
% Ejercicio 5
%------------------------------------------------------
%disp(Imagen1(338,1,1));
[filas, columnas, dimensiones] = size(Imagen1);
%Imagen2 = zeros(filas, columnas, dimensiones);

%for fila = 1:filas
%  for columna = 1:columnas
%    for dimension = 1:dimensiones
      %disp("Imagen1[" + fila + ", " + columna ...
      %    + ", " + dimension + "] = " + ...
      %    Imagen1(fila, columna, dimension));
%      Imagen2(fila, columna, dimension) = 255 ...
%        - Imagen1(fila, columna, dimension);

%      disp("Imagen2[" + fila + ", " + columna ...
%          + ", " + dimension + "] = " + ...
%          Imagen2(fila, columna, dimension));
%    end
%  end
%end

Imagen2 = 255 - Imagen1;

%imshow(Imagen2);

%Se observa el mismo resultado que con imcomplement
%imshow(imcomplement(Imagen1));

%------------------------------------------------------
% Ejercicio 6
%------------------------------------------------------
% La imagen es RGB, cada dimension representa uno de
% esos canales, por lo cual los niveles de rojo estan
% en el canal 1 (Red), siendo los canales 2 y 3 Green
% y Blue respectivamente
Imagen3 = Imagen1(:, :, 1);
%imshow(Imagen3);
%imhist(Imagen3);

Imagen4 = imadjust(Imagen3, [], [], 0.5);
%imshow(Imagen4);
%imhist(Imagen4);

Imagen5 = imadjust(Imagen3, [], [], 1.5);
%imshow(Imagen5);
%imhist(Imagen5);
%------------------------------------------------------
% Ejercicio 7
%------------------------------------------------------
Imagen6 = imabsdiff(Imagen4, Imagen5);
%imshow(Imagen6);

% La diferencia absoluta no es más que la resta de las
% matrices de ambas imágenes
Imagen6Manual = Imagen4 - Imagen5;
imshow(Imagen6Manual);
%------------------------------------------------------