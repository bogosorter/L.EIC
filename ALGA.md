# ALGA

## Matrizes

Uma matriz $A$ é uma tabela bidimensional de $m$ linhas e $n$ colunas, denotando-se a entrada na linha $i$ e na coluna $j$ por $a_{ij}$. $A$ diz-se uma matriz $m\times n$, o que pode ser representado por $A_{mn}$.

$$
A = \begin{bmatrix}
1 & 2 & 3\\
\sqrt{2} & -1 & i
\end{bmatrix}
$$

$$
a_{23} = i
$$

Duas matrizes dizem-se iguais se tiverem as mesmas dimensões e as entradas equivalente forem iguais. Operações como a soma e a multiplicação por um escalar são aplicadas entrada a entrada.

**Definições**

- Matriz quadrada - matriz de tamanho $n\times n$.

- Diagonal principal - conjunto das entradas $a_{ii}, i \in \{ 1, 2, ..., n\}$ de uma matriz quadrada.

- Traço - soma das entradas da diagonal principal. Representa-se por $tr(A)$.

- Matriz nula - matriz cujas entradas são todas nulas. Pode-se representar uma matriz nula $m\times n$ por $0_{mn}$.

- Matriz diagonal - matriz em que todas as entradas fora da diagonal principal são nulas.

- Matriz triangular superior - matriz em que todas as entradas abaixo da diagonal principal são nulas.

- Matriz triangular inferior - matriz em que todas as entradas acima da diagonal principal são nulas.

- Matriz identidade - matriz diagonal em que as entradas não nulas são todas 1. Se o seu tamanho for $n$ denota-se por $Id_n$.

- Matriz transposta - se $A$ for uma matriz $m\times n$, $A^t$ é uma matriz $n\times m$ em que a os índices de cada entrada trocam entre si.

- Matriz simétrica - matriz igual à sua simétrica, ou seja, $A = A^t$.

- Combinação linear - uma combinação linear de matrizes é uma soma ponderada de várias matrizes.

- Submatriz - a submatriz $A_{ij}$ é a matriz que se obtém retirando a linha $i$ e a coluna $j$ de $A$.

- Menor - o menor da entrada $a_{ij}$ de $A$ é dado pelo determinante de $A_{ij}$ e representa-se por $M_{ij}$.

- Co-fator - o co-fator da entrada $a_{ij}$ de $A$ é dado por $(-1)^{i + j}M_{ij}$ e representa-se por $C_{ij}$.

- Matriz adjunta - transposta da matriz dos cofatores de $A$, que se designa por $Adj(A)$.

### Determinante de uma matriz

O determinante de uma matriz é definido recursivamente:

- O determinante de uma matriz de uma entrada é essa entrada.

- O determinante de uma matriz $n \times n$ é dado, para qualquer linha $i$ (ou por um processo análogo para uma coluna $j$) por uma expansão em co-fatores, ou seja,

$$
\det(A) = a_{i1}C_{i1} + a_{i2}C_{i2} + ... + a_{in}C_{in}
$$

A partir da última fórmula, pode-se deduzir uma expressão conveniente para o determinante de uma matriz $2\times 2$:

$$
\det(\begin{bmatrix}
a & b\\
c & d
\end{bmatrix}) = a \times d - b \times c
$$

Propriedades da função determinante:

- $\det(Id) = 1$

- $\det(A) = \det(A^t)$

- $\det(AB) = \det(A)\det(B)$

- $A$ é invertível se $\det(A) \neq 0$ e, nesse caso, $\det(A^{-1}) = \frac{1}{\det(A)}$.

- $\det(B) = k\det(A)$, se $B$ for obtida de $A$ multiplicando uma das suas linhas ou colunas por $k$.

- $\det(B) = -\det(A)$ se $B$ for obtida de $A$ por troca de duas linhas ou colunas.

- $\det(B) = \det(A)$, se $B$ for obtida de $A$ por soma a uma linha do produto de outra linha por um escalar não nulo (ou por um processo análogo para uma coluna).

### Produto de matrizes

O produto de duas matrizes $A_{mn}$ e $B_{pq}$ apenas está definido se $n = p$. Nesse caso, a matriz $C$ resultante tem tamanho $m\times q$ e cada entrada $c_{ij}$ de $C$ é dada pelo produto escalar da linha $i$ de $A$ e da coluna $b$ de $B$.

$$
A = \begin{bmatrix}
1 & 2 & 0\\
2 & 0 & -1
\end{bmatrix},
\ B = \begin{bmatrix}
1 & 2\\
2 & 0\\
0 & 1
\end{bmatrix},
\ AB = \begin{bmatrix}
5 & 2\\
2 & 3
\end{bmatrix}
$$

É importante notar que o produto de matrizes não é comutativo, embora seja associativo. O produto de uma matriz pela matriz nula é sempre uma matriz nula, e o produto de uma matriz pela identidade é ela própria. $A^0 = Id$ e $A^n$ é o produto de $A$ por sí própria $n$ vezes.

A matriz inversa de $A$ é uma matriz $A^{-1}$ tal que $AA^{-1} = Id$. Se essa matriz existir, $A$ diz-se invertível. Note-se que apenas matrizes quadradas têm inversa, embora possa haver matrizes não quadradas com inversas à esquerda ou à direita. A matriz inversa de uma matriz quadrada é dada pela seguinte expressão:

$$
A^{-1} = \frac{Adj(A)}{det(A)}
$$

---

## Sistemas de equações lineares

Um sistema de equações lineares pode ser escrito em notação matricial. Define-se uma matriz de coeficientes $A$, uma matrix de incógnitas $X$ e uma matriz de termos independentes $B$. A  matriz aumentada do sistema obtém-se juntando $A$ e $B$. Por exemplo, o sistema

$$
\begin{cases} 3x + 5y + z = 3 \\ 7x – 2y = 0 \\ -6x + 3y + 2z = 2 \end{cases}
$$

pode ser representado por estas matrizes:

$$
A = \begin{bmatrix}
3 & 5 & 1\\
7 & -2 & 0\\
-6&3&2
\end{bmatrix},
\ X = \begin{bmatrix}
x \\
y \\
z
\end{bmatrix},
\ B = \begin{bmatrix}
3\\
0\\
2
\end{bmatrix}
$$

Omitindo a matriz $X$, obtém-se a seguinte matriz do sistema (por vezes denotada como $[A|B]$:

$$
\begin{bmatrix}
3 & 5 & 1 &|&3\\
7 & -2 & 0&|&0\\
-6&3&2&|&2
\end{bmatrix}
$$

Um sistema de equações lineares é possível e determinado sse $\det(A) \neq 0$, sendo impossível ou indeterminado quando esta condição não se cumpre. No primeiro caso, a solução do sistema é dada por $X = A^{-1}B$. A **regra de Cramer** dita que, para cada entrada $x_i$ de $X$ e sendo $A_i$ a matriz $A$ com a coluna $i$ substituída por $B$,

$$
x_i = \frac{\det(A_i)}{\det(A)}
$$

[Cramer's rule - Wikipedia](https://en.wikipedia.org/wiki/Cramer%27s_rule)

**Definições:**

- Sistema homogéneo - sistema em que a matriz dos termos independentes é nula. Tem pelo menos uma opção (a solução nula).

### Método de Gauss

A resolução de sistemas de equações lineares é muito facilitada pela transformação de um sistema em sistemas mais simples. Há três formas de simplificar um sistema:

- Trocar a ordem das equações.

- Somar a uma equação um múltiplo de outra equação.

- Multiplicar uma equação por um número real não nulo.

O método de Gauss consiste em transformar uma matriz aplicando estes princípios de equivalência, de tal forma que a matriz resultante esteja em escada reduzida, ou seja, cumpra estas condições:

- As linhas nulas, a existirem, são as últimas.

- A entrada guia (primeira entrada não nula de uma linha) deve ser um e todas as  restantes entradas nessa coluna são nulas.

- As entradas estão ordenadas da esquerda para a direita, em "escada".

Se o sistema for possível e determinado, a matriz em escada reduzida corresponde à identidade.

O método de Gauss permite também calcular facilmente a inversa de uma matriz. Basta calcular a matriz em escada e reduzida de $[A|B]$. Se a matriz obtida for do tipo $[Id|B']$, então $B' = B^{-1}$. Caso contrário, $A$ não admite inversa.

**Definições:**

- Característica - número de entradas guia numa matriz, que se representa por $car(A)$. Permite saber quais os sitemas possíveis (em que $car(A) = car[A|B]$), os sistemas possíveis e determinados (em que $car(A) = n$, sendo $n$ o número de incógnitas), e os sistemas indeterminados (em que $car(A) < n$).

## Espaço euclidiano $\R^n$

Um conjunto ordenado de vetores $B = (b_1, ..., b_n)$ é uma base de $\R^n$ se qualquer ponto ou vetor de $\R^n$ puder ser escrito como uma combinação linear única desses vetores - os vetores têm, por isso, de ser linearmente independentes. Um vetor $u$ pode ser escrito como $(\alpha_1, ..., \alpha_n)_B$, em que $\alpha_1, ..., \alpha_n$ são os coeficientes dessa combinação linear. $n$ é a dimensão de $\R^n$, e qualquer base de $\R^n$ têm exatamente $n$ vetores. O conjunto de vetores $((1, 0, ... , 0), (0, 1, ... , 0), ...,(0, 0, ..., 1))$ é a base canónica de $\R^n$.

Um subespaço é definido, formalmente, como um subconjunto de $\R^n$ tal que a soma de dois vetores desse conjunto pertença ao mesmo conjunto, tal como a multiplicação de um desses vetores por um escalar. Por exemplo, a reta $y = x + 1$ não é um subestpaço de $R^2$. Basta considerar o vetor $(0, 1)$, que pertence ao conjunto, mas que quando multiplicado por $2$ gera o vetor $(0, 2)$, que já não pertence ao conjunto. Daí se conclui que um subespaço de $R^2$ inclui sempre a origem.

Se o subespaço for formado pelas combinações lineares dos vetores $u_1, ..., u_n$, pode representar-se por $S = <u_1, ..., u_n>$. Se estes vetores forem linearmente independentes dizem-se uma base do subespaço vetorial $S$. Se $\R^n$ puder sempre ser escrito como a soma de dois vetores de espaços lineares $S_1$ e $S_2$, diz-se que $\R^n$ é uma soma direta destes espaços, o que se denota por $\R^n = S_1 \oplus S_2$.
