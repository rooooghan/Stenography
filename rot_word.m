function w_out = rot_word (w_in)
%ROT_WORD  Rotate the elements of a four element vector.
%
%   W_OUT = ROT_WORD (W_IN) 
%   performs a cyclic shift of the elements 

% Do the shift...
w_out = w_in([2 3 4 1]);