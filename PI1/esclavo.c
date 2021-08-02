
#include <stdlib.h>
#include <pvm3.h>

#define MSG_DATA   //Código: Mensajes del maestro al esclavo
#define MSG_RESULT //Código: Resultado del esclavo al maestro
#define SIZE        //Tamaño total de los datos a almacenar          
#define DATA_SIZE (SIZE/NUM_SLAVES)// Tamaño de dato para cada esclavo

    
int main()
{
    int mytid, parent_tid;
    int items[DATA_SIZE];           /* data sent by the master  */
    int sum, i;
      
    // Entrar al PVM
    mytid = pvm_mytid();
    
    //Regresar el task id del maestro
    parent_tid = pvm_parent();
    
    //Recibe los datos del maestro
    pvm_recv(parent_tid, MSG_DATA);
    pvm_upkint(items, DATA_SIZE, 1);
    
   //Encuentra el número de elmentos
    sum = 0;
    for(i = 0; i < DATA_SIZE; i++){
        sum = sum + items[i];
    } 
    
    //Regresa los resultados al maestro
    pvm_initsend(PvmDataDefault);
    pvm_pkint(&sum, 1, 1);
    pvm_send(parent_tid, MSG_RESULT);
    
    //Sale del PVM
    pvm_exit();
   
    exit(EXIT_SUCCESS);
} 
