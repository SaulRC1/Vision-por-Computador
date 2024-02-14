function cadenaMatricula = reconocimientoDeCaracteres(caracteresImagen)

    % Definimos los caracteres a reconocer
    caracteres = "0123456789ABCDFGHKLNRSTXYZ";

    % Cargamos las plantillas
    load("Material_Imagenes_Plantillas\00_Plantillas\Plantillas.mat");

    % Inicializamos cadena de matricula
    cadenaMatricula = "";

    % Iterar sobre los caracteres de la imagen
    for indiceCaracterImagen = 1:length(caracteresImagen)
        %figure;
        %imshow(caracteresImagen{indiceCaracterImagen});

        caracterImagen = caracteresImagen{indiceCaracterImagen};

        % Se inicializa la matriz de correlaciones, 26 filas (1 por cada
        % caracter), 7 columnas (1 por angulo)
        correlacionesCaracter = zeros(26, 7);

        % Se itera sobre los caracteres para obtener las plantillas
        for i = 1:strlength(caracteres)
            for j = 1:7 % Ángulos de cada plantilla

                % Construimos nombre de la plantilla
                if i < 10
                    nombrePlantilla = "Objeto0" + i + "Angulo0" + j;
                else
                    nombrePlantilla = "Objeto" + i + "Angulo0" + j;
                end

                %disp("Nombre Plantilla: " + nombrePlantilla);

                % Obtenemos valor de la plantilla
                plantilla = eval(nombrePlantilla);

                % Redimensionamos el caracter en imagen al tamaño de la
                % plantilla
                caracterRedimensionado = imresize(caracterImagen, size(plantilla));

                %figure;
                %imshow(caracterRedimensionado);
                %imshow(plantilla);

                % Se calcula el valor de correlacion
                valorCorrelacion = Funcion_CorrelacionEntreMatrices(caracterRedimensionado, plantilla);

                % Se asigna el valor de correlacion en la posición
                % correspondiente
                correlacionesCaracter(i,j) = valorCorrelacion;
            end
        end

        [maximoValorCorrelacion, indice] = max(correlacionesCaracter, [], "all");

        [objeto angulo] = ind2sub(size(correlacionesCaracter), indice);

        caracterChar = caracteres.char();

        caracterReconocido = caracterChar(objeto);

        cadenaMatricula = cadenaMatricula + caracterReconocido;
    end
end