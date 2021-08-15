/* Alunos: Yago Jose Araujo dos Santos. Matricula: 14.2.4526 */
/*            Jeferson Patrocínio.            Matrícula: */

/*__________________ Definindo os parametros __________________*/
/*param a integer;                        #Quantidade de bombas;*/
set R := 1..2;                        #Quantidade de tanques;
set B := 1..2;                        #Quantidade de centros consumidores;
set T := 1..1;                        #Quantidade de periodos;
set F := 1..2;                        #Quantidade de faixas de demanda;

param d {k in B, t in T};

param c {j in R, t in T};
set sc {j in R, t in T};
set v {j in R, t in T};
set w {j in R, l in R, t in T};
param hmax := 5;
param hmin := 1;
param h0 := 0;
param S := 1;
param R1 := 1;
param P := 2;
set yota {j in R, l in R, t in T};
set teta {j in R, t in T};
param tgrego := 0;
param dbarramenos := 1;
param dbarra := 2;
set vol {j in R, i in F};
param beta:=1;


/* __________________ Definindo os conjuntos ___________________*/
/*set numBombas = R + R-1;                #Numero de bombas;*/
set j:= 1..R;					#Conjunto de todas as tanques;
set l:= 1..R;					#Conjunto de todas as tanques;
set k:= 1..B;					 #Conjunto de todos os centros consumidores;
set t:= 1..T;					#Conjunto de periodos;
set i:= 1..F;					#Conjunto de faixas de demanda;



/*____________________ Variaveis de decisao ____________________*/
var I{j in R, t in T} >= 0 integer;     #Volume de agua em (m^3) no tanque j no final do periodo t;
var x{j in R, t in T} >= 0 binary;      #1 se a bomba j esta ligada no periodo t, 0 caso contrario;
var alpha{j in R, t in T} >=0 binary;   #1 se a bomba j e acionada no período t, 0 caso contrario;
var z{j in R, l in R, t in T}; binary;  #1 se ha transferencia de agua do tanque j para l no periodo t, 0 caso contrario;
var y{i in R, k in B, t in T}; binary; #se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

#if F[u-1] <= F[u] then y = 1 else y = 0 #1 se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

/*____________________ Funcao objetivo ____________________*/
minimize cost: (sum{t in T}, sum{j in R}, c[j][t] * x[j][t] + sc[j][t] * alpha[j][t] + (sum{t in T}, sum{j in R}, sum{l in R[j]}, yota[j][l][t] * z[j][l][t]);

/*______________________ Restricoes _____________________*/
s.t. balanceamento: I[j][t]==(1-teta[j][t-1])*I[j][t-1]+v[j][t]*x[j][t]+ (sum{l in P[j]},w[l][j][t]*z[l][j][t])- (sum{l in R[j]},w[l][j][t]*z[l][j][t]) - (sum{k in S[j]}, d[k][t]), forall j in R,t in T; # verificar sintaxe do forall
s.t. bombaj: alpha[j][t] => x[j][t] - x[j][t-1], forall j in R, t in T; #3
s.t. volminmax: min(h[j]) <= i[j][t] <= max(h[j]) #4
s.t. mentenligada: alpha[j][t] <= x[j][t] #completar #5
s.t  alpha,z, y; binary

data;
param d :=
		1 10 
		2 20;
set c : 2 1 :=
		5
		4;
set sc : 2 1 :=
		2
		2;
set v : 2 1 :=
		5
		5;
set w : 2 2 1 :=
		1 1
		2 2; #todo matriz tridimensional
set hmax := 5 5;
set hmin := 1 1;
set h0 := 0 0;
set S := 1 2;
set R1 := 1 2;
set P := 2 1;
set yota : 2 2 1 :=
		1 1
		2 2; #todo matriz tridimensional
set teta : 2 1 := 
			0
			5;
