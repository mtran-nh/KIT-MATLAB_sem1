function Ua = invertAddierer(Ui, R)
%Funktion VerbraucherLeistung
%Autor              : Nhat Mai Chi Tran
%Erstellungsdatum   : 13/11/2025
%Beschreibung       : Berechnet die Leistung am Verbraucherwiderstand und 
%                     den Wirkungsgrad einer Spannungsquelle mit
%                     Innenwiderstand für verschiedene Lastwiderstände.
%Input              : Matrix Ui (Dimension m, n);
%                     Vektor R (Dimension n + 1, 1);
%Output             : Vektor Ua (Dimension m, 1);

    % Überprüfung der Eingabeparameter
    if ~isvector(R) || size(R, 2) ~= 1
        error("Die Dimensionen stimmen nicht überein!");
    end

    % Überprüfe ob Anzahl der Eingänge mit Anzahl 
    % der Widerstände übereinstimmt
    if size(Ui, 2) +1 ~= size(R, 1)
        error("Die Dimensionen stimmen nicht überein!");
    end
    % Extrahiere den Rückkopplungswiderstand Rf
    R_N = R(end);
    R_input = R(1:end-1);
    % Bestimme Anzahl der Zeitpunkte
    num = size(Ui, 1);
    % Initialisiere Ausgangsspannung mit Nullen
    Ua = zeros(num, 1);
    % Schleife über alle Eingangsspannungen
    for i=1:size(Ui, 2)
        Ri = R_input(i);
        % Berechne Widerstandsverhältnis Rf/Ri
        verhaeltnis = R_N / Ri;
        % Addiere gewichteten Beitrag zur Ausgangsspannung
        Ua = Ua + verhaeltnis * Ui(:,i);
    end
    % Invertiere die Ausgangsspannung (invertierender Addierer)
    Ua = -Ua;
end