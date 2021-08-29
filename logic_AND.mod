# Parameter
param numberValues;
param numberAttributes;
param numberLayers; 

set m := {1..numberValues};
set V := {1..numberAttributes};
set K := {1..numberLayers};

# Input
param x{m, V};
param y{m};
param d{0..numberLayers};

# Variablen 
var t{m};
var u{m, k in K, {1..d[k]}} binary;

var W{k in K, {1..d[k-1]}, {1..d[k]}} >= -1 <= 1;
var lambda{K} >= -1 <= 1;
var s{m, k in K, {1..d[k-1]}, {1..d[k]} : k != 1} >= -1 <= 1;

var min_value = 0.001;

# Modell
minimize obj: sum{i in m} (t[i]);

# Nebenbedingungen für die Zielfunktion 
s.t. firstBound{i in m}: t[i] >= y[i] - u[i, numberLayers, 1];
s.t. secondBound{i in m}: t[i] >= u[i, numberLayers, 1] - y[i];

s.t. first{i in m, z in {1..d[1]}} : sum{v in V}(W[1, v, z] * x[i, v]) <= ((sum{v in V}(x[i, v]) + 1) * u[i, 1, z] + lambda[1]) - min_value;
s.t. second{i in m, z in {1..d[1]}} : sum{v in V}(W[1, v, z] * x[i, v]) >= (sum{v in V}(x[i, v]) + 1)  * (u[i, 1, z] - 1) + lambda[1];

s.t. third{i in m, k in K, z in {1..d[k]} : k != 1}: sum{l in {1..d[k-1]}} (s[i, k, l, z]) <= ((d[k-1] + 1) * u[i, k, z] + lambda[k]) - min_value;
s.t. fourth{i in m, k in K, z in {1..d[k]} : k != 1}: sum{l in {1..d[k-1]}} (s[i, k, l, z]) >= (d[k-1] + 1) * (u[i, k, z] - 1) + lambda[k];

s.t. fifth{i in m, k in K, l in {1..d[k-1]}, j in {1..d[k]} : k != 1}: s[i, k, l, j] <= u[i, k-1, l];
s.t. sixth{i in m, k in K, l in {1..d[k-1]}, j in {1..d[k]} : k != 1}: s[i, k, l, j] >= -u[i, k-1, l];
s.t. seventh{i in m, k in K, l in {1..d[k-1]}, j in {1..d[k]} : k != 1}: s[i, k, l, j] <= W[k, l, j] + (1 - u[i, k-1, l]);
s.t. eigth{i in m, k in K, l in {1..d[k-1]}, j in {1..d[k]} : k != 1}: s[i, k, l, j] >= W[k, l, j] - (1 - u[i, k-1, l]);

# Lösung und Anzeige der Lösung
solve;

display W;
display lambda;
display obj;
display u;
display s;

# Daten, um die Parameter zu definieren
data;
param numberValues := 5;
param numberAttributes := 2;
param numberLayers := 2;    

# d[0] und muss gleich numberAttributes sein
# d[numberLayers] muss 1 sein
param d :=
0 2
1 4
2 1;

param x : 1 2 := 
1 0 0
2 1 0
3 0 1
4 1 1
5 1 1;

param y :=
1 0
2 0
3 0
4 1
5 0;

end;
