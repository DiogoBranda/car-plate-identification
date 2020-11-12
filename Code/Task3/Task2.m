%% Task 2
fid = fopen('Resultados.txt','wt');
disp("A processar:");
for i=1:10
%%Carregar imagem e converter para gray
f=im2double(imread(strcat(int2str(i),'_plate_detail.png'))); % Carrega Imagem
f=imresize(f,[200 NaN]); %Redimensiona imagem
img_gray=rgb2gray(f); %Comverte para gray
img_gray =mat2gray(histeq(img_gray));%redimensiona a imagem para as mesmas gamas de intensidade
%% Filtra
img_gauss=imgaussfilt(img_gray);%filtro gausseano
%% Converter para binario
thresh = multithresh(img_gauss,4);%Multiplo treshold para nao ficarmos dependentes de apenas uma binarização
seg_I = imquantize(img_gauss,thresh);
BW2=seg_I==1;
BW = imbinarize(img_gauss,0.2); %Convert para binario
%% Tratamento de imagem BW
BW = imclose(BW,strel('rectangle',[4,5]));
BW = ~BW;
BW=imclearborder(BW);
BW = bwareaopen(BW,400);
se90 = strel('line',8,90);
se0 = strel('line',8,0);
BW=imdilate(BW,se90);
BW=imdilate(BW,se0);
BW=imclearborder(BW);
se90 = strel('line',2,90);
se0 = strel('line',2,0);
BW=imdilate(BW,se90);
BW=imdilate(BW,se0);
BW = bwareaopen(BW,400);
se90 = strel('line',3,90);
se0 = strel('line',3,0);

BW= imerode(BW,[se90,se0]);
se90 = strel('line',9,90);
se0 = strel('line',8,0);
BW= imopen(BW,se90);
BW= imopen(BW,se0);

BW = imerode(BW,se90);
BW = imerode(BW,se0);
BW = bwareaopen(BW,1400);
se90 = strel('line',4,90);
se0 = strel('line',4,0);
BW=imdilate(BW,se90);
BW=imdilate(BW,se0);

%% Tratamento da imagem BW2
BW2=imclearborder(BW2);
BW2 = imclose(BW2,strel('rectangle',[4,5]));
BW2 = bwareaopen(BW2,600);
BW2= imdilate(BW2,strel('rectangle',[4,5]));
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BW2= imerode(BW2,[se90,se0]);

%% Finalizar imagem Unindo BW com BW2
img_teste=BW+BW2;
%% Detetar boxs
[L,Ne] = bwlabel(img_teste);
propied = regionprops(L,'BoundingBox');
n1={};
cont=1;
for n=1:size(propied,1)
    [r,c] = find(L==n);
    teste=img_teste(min(r):max(r),min(c):max(c));
    [l,c]=size(teste);
    if((l>95 && l<170)&&(c<120 && c > 15))
        n1{cont}=teste;
        cont=cont+1;
    end
end
    letter='';
    for z=1:cont-1
         holes = abs(bweuler(n1{z})-1);
        if(z<3)
            letter=strcat(letter,readLetterOnly(n1{z},holes));
        end
        if(z>2&&z<6)
            letter=strcat(letter,readNumV2(n1{z},holes));
        end
        if(z>5&&z~=cont-1)
            letter=strcat(letter,readLetterV2(n1{z},holes));
        end
        if(z==cont-1)
            letter=strcat(letter,readLetterOnly(n1{z},holes));
        end
    end
    fprintf(fid, strcat(letter,'\n'));
    res{i}=letter;
    str=sprintf("Imagem %d processada, resultado:%s \n",i,letter);
    disp(str);
end;
disp("Analize concluida");
disp("Resultados guardados em: Resultados.txt ");
fclose(fid);