"""
M7kra's ClassExchange

About: This program attempts to find a sequence of class exchanges that enables
a student to go from one class to another. It uses DFS (depth-first search) to
find a cycle that includes the edge A -> B in the graph of possible class
exchanges.

Instructions:
- Make sure the graph is updated
- Call change(A, B) where A is your current class and B is your target class
- Since the program uses DFS, it might not find the shortest cycle on the
  first try. Call change with a third argument, the number of iterations. The
  higher the number the higher the chance of finding the shortest cycle. For
  instance, to run 1000 iterations, call change(A, B, 1000)
"""

from random import shuffle

def main():
    exchange(10, 16, 1000)

# Find a cycle that includes the edge a -> b
def exchange(a, b, iterations):
    best = None
    for _ in range(iterations):
        result = dfs(b, a, set())
        if result and (not best or len(result) < len(best)):
            best = result
    if best: printCycle(best)
    else: print('No class exchange is possible')

def dfs(vertex, target, visited):
    if vertex in visited: return None
    if vertex == target: return [vertex]
    
    visited.add(vertex)
    shuffle(graph[vertex])
    for child in graph[vertex]:
        result = dfs(child, target, visited)
        if result: return [vertex] + result
    
    return None

def printCycle(cycle):
    cycle = [cycle[-1]] + cycle
    print(' -> '.join([str(x) for x in cycle]))

graph = {
    1: [18],
    2: [1, 18],
    3: [13, 1, 2],
    4: [17],
    5: [17, 18],
    6: [],
    7: [18, 12, 16, 6, 13],
    8: [4, 2],
    9: [2],
    10: [12, 16, 6, 12],
    11: [],
    12: [],
    13: [12],
    14: [],
    15: [12, 16, 4, 10, 13],
    16: [4, 18, 17],
    17: [10, 11],
    18: [6, 14, 17, 15],
    19: [12, 13, 15, 1, 2, 5],
    20: [],
    21: [1],
    22: [],
    23: [],
    24: [],
    25: []
}

testData = {
    1: [2],
    2: [3, 5],
    3: [4, 6],
    4: [1],
    5: [2],
    6: []
}

main()
