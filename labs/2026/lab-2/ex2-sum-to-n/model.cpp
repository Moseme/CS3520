
#include <iostream>
using namespace std;

int main() {
    int N = 5;
    int sum = 0;

    for (int i = 1; i <= N; i++) {
        sum += i;
    }

    cout << "Sum from 1 to " << N << " is: " << sum << endl;

    return 0;
}
