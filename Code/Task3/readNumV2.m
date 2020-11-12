function letter=readNumV2(Bloco,holes)
load NewTemplates %%Carrega os templates
Bloco=imresize(Bloco,[42 24]); %%Normaliza a imagem
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
   %disp("vd");
   %disp(vd);
    %*-*-*-*-*
% Numerals listings.
if vd==34 && holes==0
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
elseif (vd==40 || vd==41 || vd==42) && holes==1
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
