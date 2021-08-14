/* Alunos: Yago Jose Araujo dos Santos. Matricula: 14.2.4526 */
/*            Jeferson Patrocínio.            Matrícula: */

/*__________________ Definindo os parametros __________________*/
param a integer;                        #Quantidade de bombas;
param r integer;                        #Quantidade de tanques;
param b integer;                        #Quantidade de centros consumidores;
param t integer;                        #Quantidade de periodos;
param f integer;                        #Quantidade de faixas de demanda;

param u integer;                        #Demanda do centro consumidor;
param v integer;                        #Vazao da bomba;

/* __________________ Definindo os conjuntos ___________________*/
set numBombas = r + r-1;                #Numero de bombas;
set A:= 1..numBombas;                   #Conjunto de todas as bombas;
set R:= 1..r;                           #Conjunto de todos os tanques
set B:= 1..b;                           #Conjunto de todos os centros consumidores;
set T:= 1..t;                           #Conjunto de periodos;
set F:= 1..f;                           #Conjunto de faixas de demanda;

/*____________________ Variaveis de decisao ____________________*/
var i{j in A, t in T} >= 0 integer;     #Volume de agua em (m^3) no tanque j no final do periodo t;
var x{j in A, t in T} >= 0 binary;      #1 se a bomba j esta ligada no periodo t, 0 caso contrario;
var alpha{j in A, t in T} >=0 binary;   #1 se a bomba j e acionada no período t, 0 caso contrario;
var z{j in A, l in A, t in T}; binary;  #1 se ha transferencia de agua do tanque j para l no periodo t, 0 caso contrario;
if F[u-1] <= F[u] then y = 1 else y = 0 #1 se o limite inferior for menor ou igual ao limite superior da faixa de demanda i, 0 caso contrario;

/*____________________ Funcao objetivo ____________________*/
minimize cost: (sum{t in T} t=1, sum{j in R} j=1, c[j][t] * x[j][t] * alpha[j][t]) + (sum{t in T} t=1, sum{j in R} j=1, sum{l in R, j in R}, yota[j][l][t] * z[j][l][t])

/*______________________ Restricoes _____________________*/
s.t. balanceamento: (1 - theta[j][t-1]) * i[j][t-1] + v[j][t]*x[j][t] + sum{j in R}(w[l][j][t] * z[l][j][t]), - (sum{l in R}w[j][l][t] * z[j][j][t]) - (sum{k in s[j]} d[k][j]);
