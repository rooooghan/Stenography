function sc = sub_case(C,X,Y);

[R2 C2]=size(C);
for i=1:R2
    for j=1:C2
        if (X(i,j)<C(i,j) && Y(i,j)<C(i,j))
            sc(i,j)=1;
        elseif (X(i,j)==C(i,j) && Y(i,j)<C(i,j)) || (X(i,j)<C(i,j) && Y(i,j)==C(i,j))
            sc(i,j)=2;
        elseif (X(i,j)==C(i,j) && Y(i,j)==C(i,j))
            sc(i,j)=3;
        elseif (X(i,j)>C(i,j) && Y(i,j)<C(i,j)) || (X(i,j)<C(i,j) && Y(i,j)>C(i,j))
            sc(i,j)=4;
        elseif (X(i,j)>C(i,j) && Y(i,j)==C(i,j)) || (X(i,j)==C(i,j) && Y(i,j)>C(i,j))
            sc(i,j)=5;
        elseif (X(i,j)>C(i,j) && Y(i,j)>C(i,j))
            sc(i,j)=6;
        end
    end
end
        