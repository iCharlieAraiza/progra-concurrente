#include <iostream>

using namespace std;

int algo(int n);

int main()
{
    int num = algo(3);
    cout<< num;

    return 0;
}

int algo(int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    else { 
        return 3 * algo(n - 2 ) + 2 * algo(n - 1);
    }
}
