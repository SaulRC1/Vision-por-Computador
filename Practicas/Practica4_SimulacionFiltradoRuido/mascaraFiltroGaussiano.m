function mascara = mascaraFiltroGaussiano(W, desviacionTipica)

% Centro de la máscara WxW
center = (W-1)/2;

% Inicializar la máscara del filtro Gaussiano
filtroGaussiano = zeros(W);

% Calcular la máscara del filtro Gaussiano manualmente
for i = 1:W
    for j = 1:W
        % Distancias desde el centro de la máscara
        x = i - center - 1;
        y = j - center - 1;
        
        % Calcular el valor del filtro Gaussiano en (i,j)
        filtroGaussiano(i, j) = (1/(2*pi*desviacionTipica^2)) * ...
        exp(-(x^2 + y^2)/(2*desviacionTipica^2));
    end
end

% Normalizar la máscara del filtro Gaussiano, la normalización de
% la máscara del filtro gaussiano se realiza para garantizar que 
% la suma de todos los elementos de la máscara sea igual a 1. 
% Esto es crucial para que la convolución con la máscara no altere
% la intensidad global de la imagen.
mascara = filtroGaussiano / sum(filtroGaussiano(:));

end