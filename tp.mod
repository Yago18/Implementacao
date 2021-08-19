/* Alunos: Yago Jose Araujo dos Santos.    Matricula: 14.2.4526 */
/*            Jeferson Afonso do Patrocinio.  Matricula: 19.1.4125  */

/*__________________________________________________ Definindo os parametros __________________________________________________*/

/*param a integer;                                                                #Quantidade de bombas;*/
param numR integer;                           #Quantidade de tanques;
param numB integer;                           #Quantidade de centros consumidores;
param numT integer;                           #Quantidade de periodos;
param numF integer;                           #Quantidade de faixas de demanda;

param numTanques integer;                     #Quantidade de tanques que podem enviar para outros;
param t1 integer;                         #modifiquei aqui

/* __________________________________________________ Definindo os conjuntos ___________________________________________________*/

set R:= 1..numR;                              #Conjunto de todos os tanques
set B:= 1..numB;                              #Conjunto de todos os centros consumidores;
set T:= 1..numT;                              #Conjunto de periodos;
set F:= 1..numF;                              #Conjunto de faixas de demanda;
set P:= 1..numTanques;                        #Conjunto de tanques que podem receber de outro;
set S:= 1..numB;                              #Centro consumidor abastecido poelo tanque j;

param d {k in B, t in T};
param c {j in R, t in T};
param sc {j in R, t in T};
param v {j in R, t in T};
param w {j in R, l in R, t in T};
param hmax {j in R};
param hmin {j in R};
param h0 {i in R};
#param S := 1;
param R1 := 1;
#param P {j in NP};
param yota {j in R, l in R, t in T};
param teta {j in R, t in T};
param tgrego := 0;
param dbarramenos := 1;
param dbarra {i in F};
param vol {j in R, i in F};
param beta:=1;

/*____________________________________________________ Variaveis de decisao ____________________________________________________*/

var I{j in R, t in T} >= 0 integer;     #Volume de agua em (m^3) no tanque j no final do periodo t;
var x{j in R, t in T} >= 0 binary;      #1 se a bomba j esta ligada no periodo t, 0 caso contrario;
var alpha{j in R, t in T} >=0 binary;   #1 se a bomba j e acionada no perÃ­odo t, 0 caso contrario;

var z{j in R, l in R, t in T} binary;  #1 se ha transferencia de agua do tanque j para l no periodo t, 0 caso contrario;
var y{i in R, k in B, t in T} binary;  #se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

#if F[u-1] <= F[u] then y = 1 else y = 0 #1 se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

/*______________________________________________________ Funcao objetivo ______________________________________________________*/

minimize cost: sum{t in T, j in R} ( c[j,t] * x[j,t] + sc[j,t] * alpha[j,t]) + (sum{t in T,j in R, l in R} yota[j,l,t] * z[j,l,t]);

#minimize cost: sum{t in T, j in R} ( c[j,t] * x[j,t] + sc[j,t] * alpha[j,t]) + (sum{t in T,j in R, l in R[j]} yota[j,l,t] * z[j,l,t]);

/*________________________________________________________________________________________________________________________*/

/*_________________________________________________________ Restricoes _______________________________________________________*/

s.t. balanceamento {j in R,t in T}: I[j,t] = (if t>= 2 then 1-teta[j,t-1] else 0) * (if t>= 2 then I[j,t-1] + v[j,t] * x[j,t] else 1) + (sum{l in P} w[l,j,t] * z[l,j,t]) - (sum{l in R} w[l,j,t] * z[l,j,t]) - (sum{k in S} d[k,t]); #2

s.t. bombaj {j in R,t in T}: alpha[j,t] >= if t>=2 then x[j,t] - x[j,t-1] else 0; #3
s.t. volminmax {j in R,t in T}: hmin[j] <= I[j,t] <= hmax[j];  #4
s.t. mantemligada {j in R,t in T:t1 >=t and t1 <= t+tgrego }: alpha[j,t] <= x[j,t1];#5


#s.t. pressao1 {k in B, t in T}: d[k,t] > sum{i in F} (if i<=2 then (dbarra[i] * y[i+1,k,t]) else y[i-1,k,t]) and d[k,t] <= (sum{i in F} dbarra[i] * y[i,k,t]); #6


s.t. pressao2 {k in B, t in T}: sum{i in F} y[i,k,t] <= 1; #7
s.t. pressao3 {j in R, k in B, t in T}: I[j,t] >= sum{i in F} y[i,k,t]* vol[j,i]; #8

s.t. desligamento {j in R}: x[j,1] = 0; #10
s.t. volinicial {j in R}: I[j,1] == h0[j]; #11

/*__________________________________________________________ Dataset ________________________________________________________*/
solve;
data;

param numB := 3;
param numR := 3;
param numT := 3;
param numF := 3;
param numTanques := 3;

param t1 := 2;                         #modifiquei aqui

param hmax := 
		1 5
		2 5
		3 5;
param hmin := 
		1 1
		2 1
		3 1;

param d :=
[1, 1] := 1
[1, 2] := 2
[1, 3] := 2
[2, 1] := 2
[2, 2] := 1
[2, 3] := 1
[3, 1] := 2
[3, 2] := 2
[3, 3] := 2;

param dbarra :=
		1 4
		2 4
		3 4;

param c := 
[1, 1] := 1
[1, 2] := 2
[1, 3] := 2
[2, 1] := 2
[2, 2] := 1
[2, 3] := 1
[3, 1] := 2
[3, 2] := 2
[3, 3] := 2;

param sc :=
[1, 1] := 1
[1, 2] := 2
[1, 3] := 2
[2, 1] := 2
[2, 2] := 1
[2, 3] := 1
[3, 1] := 2
[3, 2] := 2
[3, 3] := 2;

param v :=
[1, 1] := 1
[1, 2] := 2
[1, 3] := 2
[2, 1] := 2
[2, 2] := 1
[2, 3] := 1
[3, 1] := 2
[3, 2] := 2
[3, 3] := 2;

param w:= 
[1, 1, 1] := 1
[1, 1, 2] := 1
[1, 1, 3] := 1
[1, 2, 1] := 2
[1, 2, 2] := 2
[1, 2, 3] := 2
[1, 3, 1] := 3
[1, 3, 2] := 3
[1, 3, 3] := 3

[2, 1, 1] := 1
[2, 1, 2] := 1
[2, 1, 3] := 1
[2, 2, 1] := 2
[2, 2, 2] := 2
[2, 2, 3] := 2
[2, 3, 1] := 3
[2, 3, 2] := 3
[2, 3, 3] := 3

[3, 1, 1] := 1
[3, 1, 2] := 1
[3, 1, 3] := 1
[3, 2, 1] := 2
[3, 2, 2] := 2
[3, 2, 3] := 2
[3, 3, 1] := 3
[3, 3, 2] := 3
[3, 3, 3] := 3;

param yota:= 
[1, 1, 1] := 10
[1, 1, 2] := 10
[1, 1, 3] := 10
[1, 2, 1] := 20
[1, 2, 2] := 20
[1, 2, 3] := 20
[1, 3, 1] := 30
[1, 3, 2] := 30
[1, 3, 3] := 30

[2, 1, 1] := 10
[2, 1, 2] := 10
[2, 1, 3] := 10
[2, 2, 1] := 20
[2, 2, 2] := 20
[2, 2, 3] := 20
[2, 3, 1] := 30
[2, 3, 2] := 30
[2, 3, 3] := 30

[3, 1, 1] := 10
[3, 1, 2] := 10
[3, 1, 3] := 10
[3, 2, 1] := 20
[3, 2, 2] := 20
[3, 2, 3] := 20
[3, 3, 1] := 30
[3, 3, 2] := 30
[3, 3, 3] := 30;

param teta:= 
[1, 1] := 1
[1, 2] := 2
[1, 3] := 2
[2, 1] := 2
[2, 2] := 1
[2, 3] := 1
[3, 1] := 2
[3, 2] := 2
[3, 3] := 2;

param vol: 1 2 3 :=
		1 3 3 3
		2 3 3 3
		3 3 3 3;

param h0:=
		1 3
		2 3
		3 3;

end;
