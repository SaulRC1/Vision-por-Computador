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
disp(Imagen1(338,1,1));
[filas, columnas, dimensiones] = size(Imagen1);
for fila = 1:filas
  for columna = 1:columnas
    for dimension = 1:dimensiones
      disp("Imagen1[" + fila + ", " + columna ...
          + ", " + dimension + "] = " + ...
          Imagen1(fila, columna, dimension));
    end
  end
end
%------------------------------------------------------