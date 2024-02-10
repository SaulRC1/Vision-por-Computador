function imagenFiltroAdaptativo = Funcion_FiltAdaptMatricial(imagen, ...
    matrizVecindad, varianzaRuido, opcionPadding)

    % Creamos un filtro promediador de tamaño 7x7 con fspecial
    filtroPromediador = fspecial('average', [7 7]);

    % Obtenemos la varianza local de la ventana bajo consideración
    varianzaLocal = power(stdfilt(imagen, matrizVecindad), 2);

    % Variable para la convolucion mediante varianza
    % ya que se quiere hacer de forma matricial, se calcula
    % a modo de matriz y se multiplicara por todos los pixeles
    % de la imagen sin filtrar
    h = varianzaRuido ./ (varianzaRuido + varianzaLocal);
    
    imagenFiltradaMatricial = h .* double(imagen) + (1 - h) .* ...
    double(imfilter(imagen, filtroPromediador, opcionPadding));

    imagenFiltroAdaptativo = uint8(imagenFiltradaMatricial);

end