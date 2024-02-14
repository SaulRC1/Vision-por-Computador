function Funcion_Reconoce_Matricula(RutaImagen)

    % Leer la imagen
    imagen = imread(RutaImagen);

    % Nos quedamos con la componente azul de la imagen, ya que es en
    % la que mejor se diferencian los caracteres
    imagenR = imagen(:, :, 1);

    % Obtenemos los caracteres producto de la segmentación
    caracteres = segmentacionDeCaracteres(imagenR);

    % Se reconocen los caracteres que forman parte de la matricula
    cadenaMatricula = reconocimientoDeCaracteres(caracteres);

    %disp("Cadena Matricula: " + cadenaMatricula);

    figure;
    imshow(imagen);
    title(cadenaMatricula);
end