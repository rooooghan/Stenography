function [x r]=blocking(y,xw,yw)
% Design Of Butterworth Low Pass Filter
xmax=size(y,1);
ymax=size(y,2);
imax=xmax/xw;
jmax=ymax/yw;
k=0;
r=zeros(xmax,ymax);
for i=1:imax
    for j=1:jmax
        k=k+1;
        x(k).data=y(((i-1)*xw+1):i*xw,((j-1)*yw+1):j*yw);
        r(((i-1)*xw+1):i*xw,((j-1)*yw+1):j*yw)=x(k).data;
    end
end
return