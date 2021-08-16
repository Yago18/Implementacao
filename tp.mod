/* Alunos: Yago Jose Araujo dos Santos. Matricula: 14.2.4526 */
/*            Jeferson Patrocínio.            Matrícula: */

/*__________________ Definindo os parametros __________________*/
/*param a integer;                                                      #Quantidade de bombas;*/
param numR integer;                        #Quantidade de tanques;
param numB integer;                        #Quantidade de centros consumidores;
param numT integer;                       #Quantidade de periodos;
param numF integer;                        #Quantidade de faixas de demanda;


/* __________________ Definindo os conjuntos ___________________*/

set R:= 1..numR;                              #Conjunto de todos os tanques
set B:= 1..numB;                              #Conjunto de todos os centros consumidores;
set T:= 1..numT;                              #Conjunto de periodos;
set F:= 1..numF;                              #Conjunto de faixas de demanda;



param d {k in B, t in T};
param c {j in R, t in T};
param sc {j in R, t in T};
param v {j in R, t in T};
param w {j in R, l in R, t in T};
param hmax {j in R};
param hmin {j in R};
param h0 := 0;
param S := 1;
param R1 := 1;
param P := 2;
param yota {j in R, l in R, t in T};
param teta {j in R, t in T};
param tgrego := 0;
param dbarramenos := 1;
param dbarra := 2;
param vol {j in R, i in F};
param beta:=1;







/*____________________ Variaveis de decisao ____________________*/
var I{j in R, t in T} >= 0 integer;     #Volume de agua em (m^3) no tanque j no final do periodo t;
var x{j in R, t in T} >= 0 binary;      #1 se a bomba j esta ligada no periodo t, 0 caso contrario;
var alpha{j in R, t in T} >=0 binary;   #1 se a bomba j e acionada no período t, 0 caso contrario;

var z{j in R, l in R, t in T} binary;  #1 se ha transferencia de agua do tanque j para l no periodo t, 0 caso contrario;
var y{i in R, k in B, t in T} binary; #se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

#if F[u-1] <= F[u] then y = 1 else y = 0 #1 se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

/*____________________ Funcao objetivo ____________________*/
minimize cost: sum{t in T, j in R} ( c[j,t] * x[j,t] + sc[j,t] * alpha[j,t]) + (sum{t in T,j in R, l in R} yota[j,l,t] * z[j,l,t]);

#minimize cost: sum{t in T, j in R} ( c[j,t] * x[j,t] + sc[j,t] * alpha[j,t]) + (sum{t in T,j in R, l in R[j]} yota[j,l,t] * z[j,l,t]);
/*______________________ Restricoes _____________________*/
#s.t. balanceamento {j in R,t in T}: I[j,t]==(1-teta[j,t-1])*I[j,t-1]+v[j,t]*x[j,t]+ (sum{l in P},w[l,j,t]*z[l,j,t])- (sum{l in R[j]},w[l,j,t]*z[l,j,t]) - (sum{k in S}, d[k,t]); # verificar sintaxe do forall
s.t. bombaj {j in R,t in T}: alpha[j,t] >= x[j,t] - x[j,t-1]; #3
s.t. volminmax {j in R,t in T}: hmin[j] <= I[j,t] <= hmax[j];  #4
s.t. mentenligada {j in R,t in T}: alpha[j,t] <= x[j,t]; #completar pois usa um t' n�o explicado #5


data;

param numB = 2;
param numR = 2;
param numT = 1;
param numF = 2;

param hmax = 5 5;
param hmin = 1 1;

param d :=
		1 10 
		2 20;
param c := 
		1 5
		2 4;
param sc :=
		1 2
		2 2;
param v :=
		1 5
		2 5;
param w :=
		1 1 2
		2 2 2; #todo matriz tridimensional
param hmax := 5 5;
param hmin := 1 1;
param h0 := 0 0;
param S := 1 2;
param R1 := 1 2;
param P := 2 1;
param yota :=
		1 1 1
		2 2 2; #todo matriz tridimensional
param teta := 
		1 0
		2 5;
