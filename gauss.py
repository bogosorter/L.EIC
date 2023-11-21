"""
A program that solves a determiate system of linear equations using Gauss-Jordan
elimitaion, by M7kra.
https://m7kra.github.io/

The program differs from the recommended implementation in that:
- it uses OOP instead of functional programming
- a slightly different strategy is used while solving the matrix (the same
  strategy in our linear algebra classes)
"""

class Matrix:

    def __init__(self, matrix):
        self.matrix = matrix
        self.m = len(matrix)
        self.n = self.m + 1 # This is a m * (m + 1) matrix

    def solve(self):
        """
        Solve the matrix using Gauss-Jordan elimination
        """
        for i in range(self.m): self.normalize(i)
        if not self.determinate(): raise ValueError

        self.clean()
        return [row[self.n - 1] for row in self.matrix]

    def determinate(self):
        """
        Assumes that the matrix is in it's reduced row echellon form
        """
        for i in range(self.m):
            for j in range(self.m):
                if i == j:
                    if self.matrix[i][j] != 1: return False
                elif self.matrix[i][j] != 0: return False
        return True

    def normalize(self, k):
        """
        Place a row in the kth line whose first kth element is 1 and ensure that
        for all other rows their kth element is 0
        """
        tmp = self.findrow(k)
        if tmp == None: return
        self.swap(tmp, k)
        self.mul(k, 1 / self.matrix[k][k])

        for i in range(self.m):
            if i == k: continue
            self.add(i, k, -self.matrix[i][k])

    def swap(self, a, b):
        """
        Swap row a and b
        """
        self.matrix[a], self.matrix[b] = self.matrix[b], self.matrix[a]
    
    def mul(self, a, k):
        """
        Multiply row a by k
        """
        for i in range(self.n): self.matrix[a][i] *= k

    def add(self, a, b, k):
        """
        Add k * row b to row a
        """
        for i in range(self.n): self.matrix[a][i] += self.matrix[b][i] * k

    def findrow(self, k):
        """
        Find the first row whose index is >= k and whose kth element is not 0
        """
        for i in range(k, self.m):
            if self.matrix[i][k] != 0: return i

    def clean(self):
        """
        Transform floats into integers whenever possible
        """
        for i in range(self.m):
            for j in range(self.n):
                if self.matrix[i][j] % 1 != 0: continue
                self.matrix[i][j] = int(self.matrix[i][j])

    def print(self):
        self.clean()
        print('-' * (self.n * 3 + 3))
        for i in range(self.m):
            for j in range(self.n):
                if j == 0 or j == self.n - 1: print('|', end='')
                print(f'{self.matrix[i][j]:^3}', end='')
                if j == self.n - 1: print('|', end='')
            print()
        print('-' * (self.n * 3 + 3))


print('A determinate system of linear equations')
print('Original matrix:')
matrix = Matrix([
    [1, 1, 0, 0],
    [2, -1, 3, 3],
    [1, -2, -1, 3],
])
matrix.print()
try:
    result = matrix.solve()
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print(f'Solution: {result}\n')
except:
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print('The matrix is impossible or indeterminate')

print('An indeterminate system of linear equations')
print('Original matrix:')
matrix = Matrix([
    [1, 1, 0],
    [1, 1, 0]
])
matrix.print()
try:
    result = matrix.solve()
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print(f'Solution: {result}\n')
except:
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print('The matrix is impossible or indeterminate\n')

print('An impossible system of linear equations')
print('Original matrix:')
matrix = Matrix([
    [1, 1, 0],
    [1, 1, -1]
])
matrix.print()
try:
    result = matrix.solve()
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print(f'Solution: {result}\n')
except:
    print('Reduced row echellon form of the matrix:')
    matrix.print()
    print('The matrix is impossible or indeterminate\n')
