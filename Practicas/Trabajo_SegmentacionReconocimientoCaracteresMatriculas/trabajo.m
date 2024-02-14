%imagen1 = imread("Material_Imagenes_Plantillas\01_Training\Training_01.jpg");
%visualizarComponentesRGB(imagen);
%Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\01_Training\Training_01.jpg");

%imagen2 = imread("Material_Imagenes_Plantillas\01_Training\Training_02.jpg");
%visualizarComponentesRGB(imagen2);
%Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\01_Training\Training_02.jpg");

%imagen3 = imread("Material_Imagenes_Plantillas\01_Training\Training_03.jpg");
%visualizarComponentesRGB(imagen3);
%Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\01_Training\Training_03.jpg");

%imagen4 = imread("Material_Imagenes_Plantillas\01_Training\Training_04.jpg");
%visualizarComponentesRGB(imagen4);
%Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\01_Training\Training_04.jpg");

imagenesTest = 20;

for i = 1:imagenesTest   
    if i < 10
        Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\02_Test\Test_0" + i + ".jpg");
    else
        Funcion_Reconoce_Matricula("Material_Imagenes_Plantillas\02_Test\Test_" + i  + ".jpg");
    end
end

%figure;
%imhist(imagen1(:, :, 1));