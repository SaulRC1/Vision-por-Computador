function imagenBinariaBordes = obtenerImagenBinariaBordes(ModG, umbral)

    % Se binariza la magnitud del vector gradiente utilizando
    % el operador de comparación. Se devuelve una matriz logica
    % donde los valores son true cuando la magnitud es mayor que
    % el umbral, y false en caso contrario.
    imagenBinariaBordes = ModG > umbral;

end