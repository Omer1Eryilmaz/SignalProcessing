function [t,X,Y,Z,Combined] = AccDataParam(data)
    Acc = data.Acceleration(1:3000,:);
    t = Acc.Timestamp;
    X = Acc.X;
    Y = Acc.Y;    
    Z = Acc.Z;
    Combined = sqrt(X.^2+Y.^2+Z.^2);
    Combined = Combined-mean(Combined);
end