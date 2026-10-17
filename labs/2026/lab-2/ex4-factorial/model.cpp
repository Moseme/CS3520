#include <iostream>
using namespace std;

int factorial(int n)
{
    int result = 1;

    for (int i = 1; i <= n; i++)
    {
        result *= i;
    }

    return result;
}

int main()
{
    int N = 5;

    int answer = factorial(N);

    cout << N << "! = " << answer << endl;

    return 0;
}