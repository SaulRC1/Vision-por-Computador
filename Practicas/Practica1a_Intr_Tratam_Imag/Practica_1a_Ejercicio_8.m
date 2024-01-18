Imagen1 = imread("P1a.jpg");

histogramaImagen1 = histogramaNivelesDeVerde(Imagen1);

%stem(histogramaImagen1);
%imhist(Imagen1(:, :, 2));

% Creación de la función que calcule el histograma
function h = histogramaNivelesDeVerde(Imagen)
    % El segundo canal es el canal del verde (Green)
    ImagenNivelesDeVerde = Imagen(:, :, 2);

    % https://www.uv.es/gpoei/eng/Pfc_web/realzado/histograma/histo.htm
    [filas, columnas] = size(ImagenNivelesDeVerde);
    
    h = zeros(1, 255);

    for fila = 1:filas
        for columna = 1:columnas
            h(ImagenNivelesDeVerde(fila, columna) + 1) ...
            = h(ImagenNivelesDeVerde(fila, columna) + 1) + 1;
        end
    end

end
