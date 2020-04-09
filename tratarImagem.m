%funcao para fazer o tratamento da imagem para o reconhecimento do objeto,
%o parametro 'corRGB' eh informado a cor do objeto q queremos detectar:
%'red' - vermelho,'green' - verde, 'blue'- azul.

function [bw,dt] = tratarImagem(vid,corRGB)
% tira um snapshot do frame atual
    dt = getsnapshot(vid);
    
    %objeto vermelho = componente R - imagem em escala de cinza
    componente = Componente(corRGB);
    
    diff_im = imsubtract(dt(:,:,componente), rgb2gray(dt));
 
    diff_im = medfilt2(diff_im, [4 4]);
    
    diff_im = im2bw(diff_im, 0.12);
    
    % remove os pixels menores que 300
    diff_im = bwareaopen(diff_im,300);
    
    % rotula os componentes da imagem
    bw = bwlabel(diff_im, 8);

end
function componente = Componente(corRGB)
        switch corRGB;
            case 'red'
                componente = 1;
            case 'green'
                componente = 2;
            case 'blue'
                componente = 3;
            otherwise
                componente = 1;
        end
end