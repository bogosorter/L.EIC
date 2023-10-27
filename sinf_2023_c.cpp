// Solution for problem C of SINF 2023

#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    int n;
    cin >> n;
    int mountains[n];
    for (int i = 0; i < n; i++) cin >> mountains[i];

    int best = mountains[0];
    int minimum = mountains[1];
    int result = 0;
    for (int i = 1; i < n; i++) {
        result = max(result, min(mountains[i], best) - minimum);
        if (mountains[i] > best) {
            best = mountains[i];
            minimum = best;
        } else {
            minimum = min(minimum, mountains[i]);
        }
    }
    cout << result << "\n";
}