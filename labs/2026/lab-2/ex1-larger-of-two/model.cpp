#include <iostream>
using namespace std;

int main() {
    int a = 15;
    int b = 23;
    int larger;

    if (a > b) {
        larger = a;
    } else {
        larger = b;
    }

    cout << "The larger number is: " << larger << endl; // Output: The larger number is: 23

    return 0;
}