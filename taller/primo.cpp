#include <iostream>

using namespace std;

bool primo(int n);

int main()
{
    int num = 0;
    cout << "Numero: ";
    cin >> num;
    if (primo(num)) {
        cout << endl << "Es primo!"<<endl;
    } else {
        cout << endl << "No es primo!"<<endl;
    }
    
    return 0;
}

/*
    Prueba de escritorio
    n = 5
    i = 2   n%i = 1
    i = 3   n%i= 3
    i = 4   n%i = 1
    return true;
    
    n = 4
    i = 2   n%i = 1
    return false;

    Pseudocódigo
    BOOLEANO primo (ENTERO numero)
        SI numero <= 1 
            RETORNAR falso
        DEFINIR i como ENTERO
        i = 2
        MIENTRAS i < numero HACER
            SI numero % 1 == 0 ENTONCES
                RETORNAR falso
            i = i + 1
        RETORNAR verdadero
*/

bool primo(int n) {
    for(int i = 2; i < n;  i++) {
        if(n%i == 0) {
            return false;
        }
    }
    return true;
}
