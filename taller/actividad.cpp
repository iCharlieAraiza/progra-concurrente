#include <iostream>

using namespace std;

int algo(int n);

int main()
{
    int num = 0;
    cout << "Numero: ";
    cin >> num;

    cout<< algo(num);

    return 0;
}

int algo(int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return 3 * algo(n - 2 ) + 2 * algo(n - 1);
}
