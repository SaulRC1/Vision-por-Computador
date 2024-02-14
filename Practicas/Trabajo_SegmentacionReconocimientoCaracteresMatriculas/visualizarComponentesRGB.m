function visualizarComponentesRGB(imagen)

    % Obtener las componentes RGB de la imagen
    imagenR = imagen(:, :, 1);
    imagenG = imagen(:, :, 2);
    imagenB = imagen(:, :, 3);

    % Mostrar las imágenes en una sola figura
    figure;
    
    % Primera imagen en la primera fila
    subplot(2, 3, 1);
    imshow(imagen);
    title('Imagen');

    % Segunda imagen en la segunda fila, columna 1
    subplot(2, 3, 4);
    imshow(imagenR);
    title('Imagen (R)');

    % Tercera imagen en la segunda fila, columna 2
    subplot(2, 3, 5);
    imshow(imagenG);
    title('Imagen (G)');

    % Cuarta imagen en la segunda fila, columna 3
    subplot(2, 3, 6);
    imshow(imagenB);
    title('Imagen (B)');

end