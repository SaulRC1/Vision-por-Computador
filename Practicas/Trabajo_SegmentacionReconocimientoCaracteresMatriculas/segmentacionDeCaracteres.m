function caracteres = segmentacionDeCaracteres(imagen)
    % Ya que existe ruido o suciedad presente cerca de los caracteres
    % se utiliza el filtro de la mediana para intentar reducirlo.
    %
    % Al manifestarse el ruido en pequeñas agrupaciones de pixeles, un buen
    % candidato indicado es el filtro de la mediana, ya que es efectivo al
    % eliminar el ruido de sal y pimienta, que aparece como pixeles blancos
    % o negros dispersos en la imagen.
    %
    % Se utiliza una mascara de 9x9 ya que al ser más grande elimina mejor
    % el ruido de sal y pimienta
    dimensionMascara = 9;
    imagenSuavizada = medfilt2(imagen, [dimensionMascara dimensionMascara]);

    %figure;
    %subplot(2, 1, 1);
    %imshow(imagen);
    %title("Imagen");

    %subplot(2, 1, 2);
    %imshow(imagenSuavizada);
    %title("Imagen Suavizada");

    % Binarización de la imagen
    imagenBinarizada = binarizarUmbralLocal(imagenSuavizada);

    %figure;
    %subplot(2, 1, 1);
    %imshow(imagenSuavizada);
    %title("Imagen Suavizada");

    %subplot(2, 1, 2);
    %imshow(imagenBinarizada);
    %title("Imagen Binarizada");

    % Etiquetar las regiones conectadas
    etiquetas = bwlabel(imagenBinarizada);

    % Obtención de las bounding boxes de las regiones de interés
    % etiquetadas
    propiedades = regionprops(etiquetas, 'BoundingBox', 'Area');

    % Definir el rango de áreas deseadas. Las pruebas han demostrado que en
    % este rango se encuentran los caractéres de la matrícula.
    areaMinima = 4000;
    areaMaxima = 11500;

    % Filtrar las propiedades para obtener solo las regiones con un 
    % área en el rango especificado
    propiedadesFiltradas = propiedades([propiedades.Area] > areaMinima ...
        & [propiedades.Area] < areaMaxima);

    % Inicializar caracteres
    caracteres = cell(length(propiedadesFiltradas));

    % Obtener las bounding boxes
    for i = 1:length(propiedadesFiltradas)

        boundingBox = propiedadesFiltradas(i).BoundingBox;

        % Recortar la región de interés de la imagen original
        regionInteres = imcrop(imagenBinarizada, boundingBox);

        % Añadimos la region de interes al vector de regiones de interes
        caracteres{i} = regionInteres;

    end

    % Mostrar las bounding boxes en la imagen original
    %figure;
    %imshow(imagenBinarizada);
    %hold on;
    %for i = 1:length(propiedadesFiltradas)
        %boundingBox = propiedadesFiltradas(i).BoundingBox;
        %Recortar la región de interés de la imagen original
        %regionInteres = imcrop(imagenBinarizada, boundingBox);
        %figure;
        %imshow(regionInteres);
        %rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
    %end
    %hold off;
end