// within RLC;

partial model TwoPin "Generico elemento a due pin di un circuito elettrico"
      PositivePin p;
      NegativePin n;

      Types.Voltage v = p.v - n.v "Tensione ai capi del bipolo";
      Types.Current i = p.i "Corrente che scorre nel bipolo";
equation
      p.i + n.i = 0 "Conservazione della carica";
end TwoPin;
