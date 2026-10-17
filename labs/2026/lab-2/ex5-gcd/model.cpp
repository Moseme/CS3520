
#include <iostream>
using namespace std;

int gcd(int a, int b)
{
    while (b != 0)
    {
        int remainder = a % b;
        a = b;
        b = remainder;
    }

    return a;
}

int main()
{
    int a = 48;
    int b = 18;

    int answer = gcd(a, b);

    cout << "GCD of " << a << " and " << b
         << " = " << answer << endl;

    return 0;
}
