function bytes_out = sub_bytes (bytes_in, s_box)
%SUB_BYTES  Nonlinear byte substitution using a substitution table.



bytes_out = s_box (bytes_in + 1);
