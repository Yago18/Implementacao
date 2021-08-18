# Implementação

 Nota: O trabalho apresentado é uma replicação do trabalho desenvolvido por: Letícia  Maria Miquelin; Edilaine Martins Soler; Maristela Oliveira dos Santos. Modelo de otimização para minimização dos custos com energia elétrica em sistemas de abastecimento de água com restrições de pressão para atendimento da demanda. In: ANAIS DO LII SIMPóSIO BRASILEIRO DE PESQUISA OPERACIONAL, 2020, João Pessoa. Anais eletrônicos... Campinas, Galoá, 2020. Disponível em: <https://proceedings.science/sbpo-2020/papers/modelo-de-otimizacao-para-minimizacao-dos-custos-com-energia-eletrica-em-sistemas-de-abastecimento-de-agua-com-restricoe> Acesso em: 18 ago. 2021.


* A função objetivo (1) representa os custos com energia elétrica relacionados ao funcionamento e ao acionamento das bombas de captaçõa e transferência de água;
* As restrições (2) representam o balanceamento do volume (estoque) de água em cada um dos períodos, para cada um dos tanques;
* As restrições (3) asseguram que caso a bomba "j" seja ligada durante o período "t-1", ela poderá ser utilizada no período "t" sem o custo de acioná-la.
* As restrições (4) definem os volumes máximos e mínimos de água em cada um dos tanques a cada período;
* As restrições (5) garantem que, se uma bomba de captação for acionada, ela ficará ligada por no mínimo "T" períodos.

 Essas restrições garantem que no abastecimento feito por gravidade, haverá pressão suficiente para que a água seja transportada do tanque até os nós de demanda.
 
