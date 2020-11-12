function letter=readLetterV2(Bloco,holes)
load NewTemplates %%Carrega os templates
Bloco=imresize(Bloco,[42 24]); %%Normaliza a imagem
% figure
% imshow(Bloco);
comp=zeros(length(NewTemplates),2);
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},Bloco); %Correlaçao da imagem com os templates
    comp(n,1)=n; %index
    comp(n,2)=abs(sem); %correlaçao
end
for n=1:length(NewTemplates)-1%ordena vetor
    max=comp(n,2);
    pos=comp(n,1);
    for k=n+1:length(NewTemplates)
        if(max<comp(k,2))
            max=comp(k,2);
            pos=comp(k,1);
            temp=comp(n,2);
            indextemp=comp(n,1);
            comp(n,2)=max;
            comp(n,1)=pos;
            comp(k,1)=indextemp;
            comp(k,2)=temp;
        end
    end
end

for i=1:50
   vd=comp(i,1);
%    disp("vd");
%    disp(vd);
   if (vd==1 || vd==2) && holes==1
    letter='A';
    break;
elseif (vd==3 || vd==4) && holes==2
    letter='B';
    break;
elseif vd==5 && holes==0
    letter='C';
    break;
elseif (vd==6 || vd==7) && holes==1
    letter='D';
    break;
elseif vd==8 && holes==0
    letter='E';
    break;
elseif vd==9 && holes==0
    letter='F';
    break;
elseif vd==10 && holes==0
    letter='G';
    break;
elseif vd==11 && holes==0
    letter='H';
    break;
elseif vd==12 && holes==0
    letter='I';
    break;
elseif vd==13 && holes==0
    letter='J';
    break;
elseif vd==14 && holes==0
    letter='K';
    break;
elseif vd==15 && holes==0
    letter='L';
    break;
elseif vd==16 && holes==0
    letter='M';
    break;
elseif vd==17 && holes==0
    letter='N';
    break;
elseif (vd==18 || vd==19) && (holes==1 )
    letter='O';
    break;
elseif (vd==20 || vd==21) && holes==1
    letter='P';
    break;
elseif (vd==22 || vd==23) && holes==1
    letter='Q';
    break;
elseif (vd==24 || vd==25)   && holes==1
    letter='R';
    break;
elseif vd==26 && holes==0
    letter='S';
    break;
elseif vd==27 && holes==0
    letter='T';
    break;
elseif vd==28 && holes==0
    letter='U';
    break;
elseif vd==29 && holes==0
    letter='V';
    break;
elseif vd==30 && holes==0
    letter='W';
    break;
elseif vd==31 && holes==0
    letter='X';
    break;
elseif vd==32 && holes==0
    letter='Y';
    break;
elseif vd==33 && holes==0
    letter='Z';
    break;
    %*-*-*-*-*
% Numerals listings.
elseif vd==34 && holes==0
    letter='1';
    break;
elseif vd==35 && holes==0
    letter='2';
    break;
elseif vd==36 && holes==0
    letter='3';
    break;
elseif (vd==37 || vd==38) && holes==1
    letter='4';
    break;
elseif vd==39 && holes==0
    letter='5';
    break;
elseif (vd==40 || vd==41 || vd==42 ) && holes==1
    letter='6';
    break;
elseif vd==43 && holes==0
    letter='7';
    break;
elseif (vd==44 || vd==45) && holes==2
    letter='8';
    break;
elseif (vd==46 || vd==47 || vd==48) && holes==1
    letter='9';
    break;
   elseif (vd == 50 || vd == 49)&& holes ==1 
    letter='0';
    break;
   end 
end
end
