clc;clear all;close all;
warning off;

%% Password for Segmentation
pw_input=input('Enter Password for Segmentation.....: ','s');
L=length(pw_input);
for i=1:L
    Aw(i)=str2num(pw_input(i));
end
N=(round(L/2));

Sv=0;
for i=1:N
    Sv=i^2*Aw(i)+Sv;
end
Sh=0;
for i=(N+1):L
    Sh=i*Aw(i)+Sh;
end

%% Original image
I=imread('Winter-Tiger-Wild-Cat-Images.jpg');
% I=imresize(I,[256 256]);
figure,imshow(I),title('Original Image');
ad_nos=imnoise(I,'salt & pepper');
figure,imshow(ad_nos)
k1=(round(size(I,1)/Sv));
k2=(round(size(I,2)/Sh));
Row=k1*Sv; Col=k2*Sh;/*9+2ww9+/*29+/*2w2w2w/
I1=imresize(I,[Row Col]);
figure,imshow(I1),title('Cover Image');

% Colour combination
R=I1(:,:,1); G=I1(:,:,2); B=I1(:,:,3);


%%% Embedding method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Case
for i=1:Row
    for j=1:Col
        MCr(i,j)=round(R(i,j)/16)+1;
        MCg(i,j)=round(G(i,j)/16)+1;
        MCb(i,j)=round(B(i,j)/16)+1;
    end
end

% Sub-Case
SCr = sub_case(MCr,MCg,MCb);
SCg = sub_case(MCg,MCb,MCr);
SCb = sub_case(MCb,MCr,MCg);

[r1]=blocking(R,Sv,Sh);
[g1]=blocking(G,Sv,Sh);
[b1]=blocking(B,Sv,Sh);

%% message image
% img=double(imread('test2.jpg'));
img=double(audioread('zombie.wav'));
%audioplay(img);
sound(img)
img=round((img+1).*100);
% img=rgb2gray(img);
% rd1=img(:,:,1);gd1=img(:,:,2);bd1=img(:,:,3);
% img=[rd1(:)' gd1(:)' bd1(:)'];
P=[img(:)' -1];
ln1=length(P);
n=16;
sp1=P(1:n);
sp2=P(n+1:ln1);

%% password for encryption
pw1=input('Enter Password for Encryption.....: ','s');

%% key generation for encryption
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;

%% key encription
ciphertext = cipher (sp1, w, s_box, poly_mat,1);

P=[ciphertext sp2];

u=1; v=1; id1=1; rot1=1;
for i=1:(Row/Sv)
    for j=1:(Col/Sh)
        
        mr=MCr((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        mg=MCg((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        mb=MCb((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sr=SCr((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sg=SCg((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sb=SCb((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        
        r=r1(1,u).data; g=g1(1,u).data; b=b1(1,u).data; % take each blocking part for segmentation
        
        [re,ge,be,P1,id1,rot1,Bk]=embedding(r,g,b,mr,mg,mb,sr,sg,sb,P,id1,rot1);    % Embedding process through segmentation
        
        r1(1,u).data=re; g1(1,u).data=ge; b1(1,u).data=be; % Embedded bits replace the Original bits
        P=P1; u=u+1;
        
        if (Bk==1)
            break
        end
    end
    if (Bk==1)
        break
    end
end
%% replace the original image
k=0;
for i=1:(Row/Sv)
    for j=1:(Col/Sh)
        k=k+1;
        R(((i-1)*Sv+1):i*Sv,((j-1)*Sh+1):j*Sh)=r1(k).data;
        G(((i-1)*Sv+1):i*Sv,((j-1)*Sh+1):j*Sh)=g1(k).data;
        B(((i-1)*Sv+1):i*Sv,((j-1)*Sh+1):j*Sh)=b1(k).data;
    end
end
I1(:,:,1)=R; I1(:,:,2)=G; I1(:,:,3)=B;
 figure,imshow(I1,[]);                %% Embedded image

%% Send to the Client via UDP Protocol