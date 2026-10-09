
#include <iostream>
using namespace std;

int main() {
    int arr[] = {3, 8, 4, 7, 10, 5, 12};
    int n = 7;
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (arr[i] % 2 == 0) {
            count++;
        }
    }

    cout << "Number of even elements: " << count << endl;

    return 0;
}
