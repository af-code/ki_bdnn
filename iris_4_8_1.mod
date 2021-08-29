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
param numberValues := 80;
param numberAttributes := 4;
param numberLayers := 2;    

# d[0] und muss gleich numberAttributes sein
# d[numberLayers] muss 1 sein
param d :=
0 4
1 8
2 1;

param x : 1 2 3 4 := 
1	5.1 3.3 1.7 0.5 
2	6.1 2.8 4.0 1.3 
3	5.2 4.1 1.5 0.1 
4	6.6 3.0 4.4 1.4 
5	5.8 2.7 3.9 1.2 
6	4.9 3.0 1.4 0.2 
7	6.0 2.9 4.5 1.5 
8	5.2 2.7 3.9 1.4 
9	5.7 2.6 3.5 1.0 
10	5.4 3.0 4.5 1.5 
11	5.1 3.5 1.4 0.2 
12	6.3 3.3 4.7 1.6 
13	4.6 3.1 1.5 0.2 
14	4.6 3.4 1.4 0.3 
15	5.8 4.0 1.2 0.2 
16	5.9 3.0 4.2 1.5 
17	4.3 3.0 1.1 0.1 
18	5.5 4.2 1.4 0.2 
19	6.6 2.9 4.6 1.3 
20	4.7 3.2 1.6 0.2 
21	6.3 2.5 4.9 1.5 
22	6.4 3.2 4.5 1.5 
23	4.8 3.1 1.6 0.2 
24	6.1 2.9 4.7 1.4 
25	4.9 3.1 1.5 0.1 
26	6.3 2.3 4.4 1.3 
27	5.2 3.5 1.5 0.2 
28	5.7 2.8 4.5 1.3 
29	5.0 3.4 1.6 0.4 
30	5.6 2.5 3.9 1.1 
31	5.5 2.5 4.0 1.3 
32	5.6 3.0 4.5 1.5 
33	5.9 3.2 4.8 1.8 
34	4.4 3.0 1.3 0.2 
35	5.1 3.8 1.5 0.3 
36	5.4 3.4 1.7 0.2 
37	6.7 3.0 5.0 1.7 
38	5.0 3.2 1.2 0.2 
39	6.2 2.2 4.5 1.5 
40	5.6 3.0 4.1 1.3 
41	6.7 3.1 4.7 1.5 
42	4.7 3.2 1.3 0.2 
43	5.0 3.0 1.6 0.2 
44	5.0 3.6 1.4 0.2 
45	4.9 3.1 1.5 0.1 
46	5.6 2.9 3.6 1.3 
47	5.0 2.0 3.5 1.0 
48	5.8 2.7 4.1 1.0 
49	4.9 3.1 1.5 0.1 
50	6.0 2.2 4.0 1.0 
51	7.0 3.2 4.7 1.4 
52	5.5 2.4 3.8 1.1 
53	5.4 3.4 1.5 0.4 
54	5.2 3.4 1.4 0.2 
55	5.5 2.4 3.7 1.0 
56	5.4 3.9 1.7 0.4 
57	4.9 2.4 3.3 1.0 
58	6.0 3.4 4.5 1.6 
59	5.7 3.8 1.7 0.3 
60	5.1 3.5 1.4 0.3 
61	6.1 2.8 4.7 1.2 
62	5.7 4.4 1.5 0.4 
63	5.1 3.7 1.5 0.4 
64	5.1 3.4 1.5 0.2 
65	6.5 2.8 4.6 1.5 
66	4.8 3.0 1.4 0.1 
67	5.0 3.4 1.5 0.2 
68	4.6 3.6 1.0 0.2 
69	6.9 3.1 4.9 1.5 
70	4.8 3.4 1.9 0.2 
71	5.5 2.3 4.0 1.3 
72	6.0 2.7 5.1 1.6 
73	6.8 2.8 4.8 1.4 
74	5.4 3.7 1.5 0.2 
75	6.7 3.1 4.4 1.4 
76	4.4 2.9 1.4 0.2 
77	5.4 3.9 1.3 0.4 
78	6.4 2.9 4.3 1.3 
79	5.5 3.5 1.3 0.2 
80	4.8 3.4 1.6 0.2;


param y := 
1	0
2	1
3	0
4	1
5	1
6	0
7	1
8	1
9	1
10	1
11	0
12	1
13	0
14	0
15	0
16	1
17	0
18	0
19	1
20	0
21	1
22	1
23	0
24	1
25	0
26	1
27	0
28	1
29	0
30	1
31	1
32	1
33	1
34	0
35	0
36	0
37	1
38	0
39	1
40	1
41	1
42	0
43	0
44	0
45	0
46	1
47	1
48	1
49	0
50	1
51	1
52	1
53	0
54	0
55	1
56	0
57	1
58	1
59	0
60	0
61	1
62	0
63	0
64	0
65	1
66	0
67	0
68	0
69	1
70	0
71	1
72	1
73	1
74	0
75	1
76	0
77	0
78	1
79	0
80	0;

end;
