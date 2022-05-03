% dilution of precision associated with a matrix H.
function DOP = dop(H,i)

    F = inv(H'*H);
    S = F(1:i,1:i);
    DOP = 0;

    for d = 1:i;
        DOP = DOP+S(d,d);
    end
    DOP = sqrt(DOP);

end
