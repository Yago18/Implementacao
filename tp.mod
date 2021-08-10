/* Alunos: Yago Jose Araujo dos Santos. Matricula: 14.2.4526 */
/*            Jefferson Patrocínio.            Matrícula: */

/*__________________ Definindo os parametros __________________*/
param a integer;                        #Quantidade de bombas;
param r integer;                        #Quantidade de tanques;
param b integer;                        #Quantidade de centros consumidores;
param t integer;                        #Quantidade de periodos;
param f integer;                        #Quantidade de faixas de demanda;
/* __________________ Definindo os conjuntos ___________________*/
set A:= 1..a;                           #Conjunto de todas as bombas;
set R:= 1..r;                           #Conjunto de todos os tanques
set B:= 1..b;                           #Conjunto de todos os centros consumidores;
set T:= 1..t;                           #Conjunto de periodos;
set F:= 1..f;                           #Conjunto de faixas de demanda;
/*____________________ Variaveis de decisao ____________________*/
var x{j in A, t in T} >= 0 binary;      #1 se a bomba j esta ligada no periodo t, 0 caso contrario;