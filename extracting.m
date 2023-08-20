function [plaintext,ind,rot,Break] = extracting(R,G,B,MCr,MCg,MCb,SCr,SCg,SCb,plaintext,ind,rot)

[sz1 sz2]=size(R);

Break=0;
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
               if (sel(1)==1)           %% Red colour 
                    CP=R(i,j); NP=R(i,j+1); 
                    if (CP==NP)
                        [d2] = condn2(CP,NP,plaintext(ind));
                        plaintext(ind)=d2;
                        if (mod(rot,2)~=0)
                            rot=rot+1;
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
                elseif (sel(1)==2)          %% Green colour
                    CP=G(i,j); NP=G(i,j+1);
                    if (CP==NP)
                        [d2] = condn2(CP,NP,plaintext(ind));
                        plaintext(ind)=d2;
                        if (mod(rot,2)~=0)
                            rot=rot+1;
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
               elseif (sel(1)==3)           %% Blue colour
                    CP=B(i,j); NP=B(i,j+1);
                    if (CP==NP)
                        [d2] = condn2(CP,NP,plaintext(ind));
                         plaintext(ind)=d2;
                        if (mod(rot,2)~=0)
                            rot=rot+1;
                        else
                            ind=ind+1;
                            rot=rot+1;
                        end
                    end
               end
                      
            %% Second method
            elseif (Cmc>=1 && Cmc<=16 && SC(1)==3)
                d1=plaintext(ind);
                DB=dec2bin(d1,8);
                DB=bitget(uint8(DB),1);         
                DB(5)=bitget(R(i,j),1);
                DB(6)=bitget(G(i,j),1);
                DB(7)=bitget(B(i,j),2);
                DB(8)=bitget(B(i,j),1);
                
                RT=[DB(5),DB(6),DB(7),DB(8),DB(1),DB(2),DB(3),DB(4)];
                RT=dec2bin(RT);
                RT=RT';
                d2=bin2dec(RT);
                
                plaintext(ind)=d2;
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
                        [d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    end
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
                        [ d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [ d2] = condn2(CP,NP,plaintext(ind));
                    end
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
                        [d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    end
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                end
                
            %% fourth method
            elseif (Cmc>1 && Cmc<15 && SC(1)==6)
                if (sel(1)==1) 
                    CP=R(i,j); RC1=G(i,j); RC2=B(i,j);
                    if RC1<RC2
                        NP=RC1;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    end
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
                        [d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    end
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
                        [d2] = condn2(CP,NP,plaintext(ind));
                    else
                        NP=RC2;
                        [d2] = condn2(CP,NP,plaintext(ind));
                    end
                    plaintext(ind)=d2;
                    if (mod(rot,2)~=0) 
                        rot=rot+1;
                    else
                        ind=ind+1;
                        rot=rot+1;
                    end
                end 
            
            end
        else
            Break=1;
            break
        end
    end
end
