function [CP1, NP1, d2] = condn1(CP,NP,d1)


DB=dec2bin(d1,8);
DB=bitget(uint8(DB),1);
b1=[DB(5) DB(6) DB(7) DB(8)];
CP=bitset(CP,2,b1(1)); CP=bitset(CP,1,b1(2)); %%hide 2 bits in Current Pixel
NP=bitset(NP,2,b1(3)); NP=bitset(NP,1,b1(4)); %%hide 2 bits in Next Pixel
CP1=CP; NP1=NP;

RT=[DB(5),DB(6),DB(7),DB(8),DB(1),DB(2),DB(3),DB(4)];
RT=dec2bin(RT);
RT=RT';
d2=bin2dec(RT);