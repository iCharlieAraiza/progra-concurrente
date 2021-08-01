#include <iostream>

using namespace std;

int main()
{
    int n, sum = 0;
    cout <<"¿Cuánto valores deseas agregar?"<<endl;
    cin >> n;
    cout << endl<<endl;
    int rango [n];
    
    for(int i = 0; i<n; i++){
        cout<< i+1 <<".- Escribe el número: "<<endl;
        cin >> rango[i];
    }

    for(int i = 0; i < n; i++){
        sum += rango[i];
    }
    
    cout<< endl <<"La suma de los números es "<< sum;
    return 0;
}
