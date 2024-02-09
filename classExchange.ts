/*
 * M7kra's ClassExchange
 *
 * About: This program attempts to find a sequence of class exchanges that
 * enables a student to go from one class to another. It uses DFS (depth-first
 * search) to find a cycle that includes the edge A -> B in the graph of
 * possible class exchanges.
 *
 * Instructions:
 * - Make sure the graph is updated
 * - Call change(A, B) where A is your current class and B is your target class
 * - Since the program uses DFS, it might not find the shortest cycle on the
 *   first try. Call change with a third argument, the number of iterations. The
 *   higher the number the higher the chance of finding the shortest cycle. For
 *   instance, to run 1000 iterations, call change(A, B, 1000)
 */


function main() {
    change(10, 16, 100);
}

// Find a cycle that includes the edge a -> b
function change(a: number, b: number, iterations: number = 1) {
    let best: number[] | null = null;
    for (let i = 0; i < iterations; i += 1) {
        const result = dfs(b, a, new Set());
        if (result && (!best || result.length < best.length)) {
            best = result;
        }
    }
    if (best) printCycle(best);
    else console.log('No class exchange is possible');
}

function dfs(vertex: number, target: number, visited: Set<number>): number[] | null {
    if (visited.has(vertex)) return null;
    if (vertex == target) return [vertex];

    visited.add(vertex);
    for (const child of shuffle(graph[vertex])) {
        const result = dfs(child, target, visited);
        if (result) {
            result.unshift(vertex);
            return result;
        }
    }

    return null;
}

function shuffle(array: number[]) {
    return array.sort(() => Math.random() - 0.5);
}

function printCycle(cycle: number[]) {
    let result = String(cycle[cycle.length - 1]);
    for (let i = 0; i < cycle.length; i += 1) {
        result += ' -> ' + cycle[i];
    }
    console.log(result);
}

const graph: {[key: number]: number[]} = {
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
};

const testData: {[key: number]: number[]} = {
    1: [2],
    2: [3, 5],
    3: [4, 6],
    4: [1],
    5: [2],
    6: []
}

main();