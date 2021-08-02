#include <stdio.h>

#define SIZE  10 //Tamaño total de los datos            

int main(void){
    int items[SIZE]; 
    
    for(int i = 0; i < SIZE; i++){
        printf("%d Agrega un valor ", i+1);
        int num;
        
        scanf("%d", &num);
        
        items[i] = num;
    }
    
    int sum = 0;
    
    for(int i = 0; i < SIZE; i++){
        sum += items[i];
    }
    
    printf("\nEl resultado de la suma es %d", sum);

	return 0;
}
