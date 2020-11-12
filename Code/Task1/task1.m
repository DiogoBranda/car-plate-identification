
close all
imgcell={};
imgcell2={};
for i=1:40
img=imread(strcat(int2str(i),'_plate.png'));

imggray=rgb2gray(img);
imggray=mat2gray(imggray);
imggray(1:230,:)=0; %redução da imagem à parte inferior(zona de interesse)
imggray=imgaussfilt(imggray);%filtro gaussiano para redução do ruído


SE=strel('rectangle',[20,40]);
imgth=imtophat(imggray,SE); %top hat para realçar a parte branca da matrícula

BW = edge(imgth,'canny',0.20,'thinning'); %deteção de orlas para encontrar as bordas da matricula
BW(1:240,:)=0;  %redução da zona de interesse, partindo do pressuposto que a matricula encontra-se
BW(:,1:155)=0;  %aproximadamente centrada na zona inferior
BW(:,640-180:640)=0;


se90 = strel('line',2,90);
se0 = strel('line',2,0);

BW = imdilate(BW,[se90 se0]);%união de pontos da matricula que possam não estar unidos

BW = imfill(BW,'holes');%preenchimento de zonas fechadas

SE = strel('line',170,0);
BW=imopen(BW,SE); %eliminação de objetos horizontais 
SE = strel('line',27,90);
BW=imopen(BW,SE);  %eliminação de objetos verticalmente que sejam menores do que a altura da matricula




imgcell{i}=BW;
%imggray(~BW)=0;      %usado para observação do resultado 
%imgcell2{i}=imggray; %obtido aplicado á imagem original
%figure
%imshow(imgcell2{i});
end
similarity={};

for i=1:40
    img1=im2double(imgcell{i});
    img2=im2double(imread(strcat(int2str(i),'_plate_mask.png')));
    similarity{i} = jaccard(img1,img2); %comparação do resultado com o GT
end
%%
med=0;
min=100000;
max=-8;
imin=-12;
imcell={};
cont=1;
for i=1:40
    if min>similarity{i}
        min=similarity{i};
        imin=i;
    end
    if similarity{i}<0.7
        imcell{cont}=i;
        cont=cont+1;
    end
    if max<similarity{i}
        max=similarity{i};
    end
   med=med+similarity{i};
end 
    med=med/40;
    med
    max
    min
    