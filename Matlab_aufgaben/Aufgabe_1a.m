function [PL, eff] = VerbraucherLeistung(Ri, Rl, U0)
%Funktion VerbraucherLeistung
%Autor              : Nhat Mai Chi Tran
%Erstellungsdatum   : 13/11/2025
%Beschreibung       : Die Leistung im Verbraucher PL und 
%                     den Wirkungsgrad in Abhängigkeit von
%                     dem Lastwiderstand RL zu berechnen
%Input              : Skalar Ri (Dimension 1, 1); 
%                     Vektor Rl (Dimension n, 1);
%                     Skalar U0 (Dimension 1, 1);
%Output             : Vektor Pl (Dimension n, 1);
%                   : Vektor eff (Dimension n, 1);
    % Eingabedimensionen prüfen
    if ~isscalar(Ri) || ~isscalar(U0)
        error("Die Dimensionen stimmen nicht überein!");
    end
    if ~isvector(Rl) || size(Rl, 2) ~= 1
        error("Die Dimensionen stimmen nicht überein!");
    end
    % Leistung und Wirkungsgrad berechnen
    PL = (U0.^2 ./ (Ri + Rl) .^2) .*Rl;
    eff = (Rl ./ (Ri + Rl)) * 100;
    % Maximale Leistung und Index bestimmen
    [M, I] = max(PL);
    % Ergebnisse ausgeben
    fprintf("Die maximale Leistung beträgt: %.3f W.\n", M);
    fprintf("Der Wirkungsgrad an diesem Punkt beträgt: %.3f %%.\n", eff(I));
end