function [R,G,B,plaintext,ind,rot,Break] = embedding(R,G,B,MCr,MCg,MCb,SCr,SCg,SCb,plaintext,ind,rot)

[sz1 sz2]=size(R);

em_bits=0; Break=0;
for i=1:sz1
    for j=1:sz2
        if (plaintext(ind)~=-1)
            m=[MCr(i,j) MCg(i,j) MCb(i,j)];
            s=[SCr(i,j) SCg(i,j) SCb(i,j)];
            Cmc=min(m);
            sel=find(Cmc==m);
            sel_color=m(sel);
            SC=s(sel);
            %% First method
            if (Cmc>=2 && SC(1)==1)
               if (sel(1)==1)           % represents the color of red                                     
                    CP=R(i,j); NP=R(i,j+1);         % CP=Current Pixel, NP=Next Pixel
                    if (CP==NP)
                        [CPr, NPr, d2] = condn1(CP,NP,plaintext(ind)); % Embedding
                        R(i,j)=CPr; R(i,j+1)=NPr;   % Embedded bits replace the original bits
                        plaintext(ind)=d2;
                        em_bits=em_bits+1
                        if (mod(rot,2)~=0)      % Check the rotation of plaintext
                            rot=rot+1;          
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
                elseif (sel(1)==2)      % represents the color of green
                    CP=G(i,j); NP=G(i,j+1);
                    if (CP==NP)
                        [CPg, NPg, d2] = condn1(CP,NP,plaintext(ind));
                        G(i,j)=CPg; G(i,j+1)=NPg;
                        plaintext(ind)=d2;
                        em_bits=em_bits+1
                        if (mod(rot,2)~=0)
                            rot=rot+1;
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
               elseif (sel(1)==3)           % represents the color of blue
                    CP=B(i,j); NP=B(i,j+1);
                    if (CP==NP)
                        [CPb, NPb, d2] = condn1(CP,NP,plaintext(ind));
                        B(i,j)=CPb; B(i,j+1)=NPb;
                        plaintext(ind)=d2;
                        em_bits=em_bits+1
                        if (mod(rot,2)~=0)
                            rot=rot+1;
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
               end
               disp('Embedding the 4 bits in the Image');
               
            %% Second method
            elseif (Cmc>=1 && Cmc<=16 && SC(1)==3)
                d1=plaintext(ind);
                DB=dec2bin(d1,8);
                DB=bitget(uint8(DB),1);
                b1=[DB(5) DB(6) DB(7) DB(8)];
                R(i,j)=bitset(R(i,j),1,b1(1));
                G(i,j)=bitset(G(i,j),1,b1(2));
                B(i,j)=bitset(B(i,j),2,b1(3));
                B(i,j)=bitset(B(i,j),1,b1(4));
                
                RT=[DB(5),DB(6),DB(7),DB(8),DB(1),DB(2),DB(3),DB(4)];
                RT=dec2bin(RT);
                RT=RT';
                d2=bin2dec(RT);
                em_bits=em_bits+1
                plaintext(ind)=d2;
                disp('Embedding the 4 bits in the Image');
                if (mod(rot,2)~=0)
                    rot=rot+1;
                else
                    ind=ind+1;
                    rot=rot+1;
                end
                
            %% Third method
            elseif (Cmc>1 && Cmc<15 && SC(1)==5)
                if (sel(1)==1) 
                    CP=R(i,j); RC1=G(i,j); RC2=B(i,j);
                    if RC1>RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        R(i,j)=CP1; G(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        R(i,j)=CP1; B(i,j)=NP1;
                    end
                    em_bits=em_bits+1
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                elseif (sel(1)==2)
                    CP=G(i,j); RC1=B(i,j); RC2=R(i,j);
                    if RC1>RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        G(i,j)=CP1; B(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        G(i,j)=CP1; R(i,j)=NP1;
                    end
                    em_bits=em_bits+1
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                elseif (sel(1)==3)
                    CP=B(i,j); RC1=R(i,j); RC2=G(i,j);
                    if RC1>RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        B(i,j)=CP1; R(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        B(i,j)=CP1; G(i,j)=NP1;
                    end
                    em_bits=em_bits+1
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                end
                disp('Embedding the 4 bits in the Image');
                
            %% fourth method
            elseif (Cmc>1 && Cmc<15 && SC(1)==6)
                if (sel(1)==1) 
                    CP=R(i,j); RC1=G(i,j); RC2=B(i,j);
                    if RC1<RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        R(i,j)=CP1; G(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        R(i,j)=CP1; B(i,j)=NP1;
                    end
                    em_bits=em_bits+1;
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                elseif (sel(1)==2)
                    CP=G(i,j); RC1=B(i,j); RC2=R(i,j);
                    if RC1<RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        G(i,j)=CP1; B(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        G(i,j)=CP1; R(i,j)=NP1;
                    end
                    em_bits=em_bits+1;
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                elseif (sel(1)==3)
                    CP=B(i,j); RC1=R(i,j); RC2=G(i,j);
                    if RC1<RC2
                        NP=RC1;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        B(i,j)=CP1; R(i,j)=NP1;
                    else
                        NP=RC2;
                        [CP1, NP1, d2] = condn1(CP,NP,plaintext(ind));
                        B(i,j)=CP1; G(i,j)=NP1;
                    end
                    em_bits=em_bits+1;
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                end 
%                 fprintf('Embedding the 4 bits in the Image %d \n',em_bits);
            end
        else
            em_bits
            Break=1;
            break
        end
    end
end
em_bits