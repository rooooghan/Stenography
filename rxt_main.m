%%% Extracting method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% password for extraction
pw_input1=input('Enter Password for Extracting.....: ','s');
% if strcmp(pw_input,pw_input1)
L1=length(pw_input);
for i=1:L1
    Aw(i)=str2num(pw_input(i));
end
N=(round(L/2));

Sv=0;
for i=1:N
    Sv=i^2*Aw(i)+Sv;
end
Sh=0;
for i=(N+1):L1
    Sh=i*Aw(i)+Sh;
end
k1=(round(size(I1,1)/Sv));
k2=(round(size(I1,2)/Sh));
Row=k1*Sv; Col=k2*Sh;
    I2=imresize(I1,[Row Col]);
R=I2(:,:,1); G=I2(:,:,2); B=I2(:,:,3);
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

ln2=length(P);
P2=zeros(1,ln2);
P2(ln2)=-1;
u=1; v=1; id2=1; rot2=1;
for i=1:(Row/Sv)
    for j=1:(Col/Sh)
        
        mr=MCr((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        mg=MCg((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        mb=MCb((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sr=SCr((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sg=SCg((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        sb=SCb((i-1)*Sv+1:i*Sv,(j-1)*Sh+1:j*Sh);
        
        r=r1(1,u).data; g=g1(1,u).data; b=b1(1,u).data; % take each blocking part for segmentation
        
        [P1,id2,rot2,Bk]=extracting(r,g,b,mr,mg,mb,sr,sg,sb,P2,id2,rot2);    % Extracting process through segmentation
        
%         r1(1,u).data=re; g1(1,u).data=ge; b1(1,u).data=be; % Embedded bits replace the Original bits
        P2=P1; u=u+1;
        
        if (Bk==1)
            break
        end
    end
    if (Bk==1)
        break
    end
end
sr1=P2(1:n);
sr2=P2(n+1:length(P2));

%% password for decryption
[w,pw2_input] = pass2(w,pw1);
if strcmp(pw_input1,pw_input) && strcmp(pw2_input,pw1)

%% Decryption
re_plaintext = inv_cipher(sr1, w, inv_s_box, inv_poly_mat,1);
Sr=[re_plaintext sr2];
ln2=length(Sr)-1;
sz=sqrt(ln2);
Sr=reshape(Sr(1:ln2),[1 ln2]);
Sr=(Sr./100)-1;
sound(Sr,8192) 
k1=(round(size(I1,1)/Sv));
k2=(round(size(I1,2)/Sh));
Row=k1*Sv; Col=k2*Sh;
    I2=imresize(I1,[Row Col]);
R=I2(:,:,1); G=I2(:,:,2); B=I2(:,:,3);
figure,imshow(I2),title('input Image');
else
    errordlg('Wrong password')
    defaultString = 'ACCESS DENIED';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString);
end