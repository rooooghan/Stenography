function [w,pw2_input] = pass2(w,pw2)

pw2_input=input('Enter the password for Decryption.....: ','s');
if (length(pw2_input)==length(pw2))
    if (pw2_input~=pw2)
        w=zeros(44,4);
    end
else    
    w=zeros(44,4);
end 