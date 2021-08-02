
#include <stdio.h>
#include <stdlib.h>
#include <pvm3.h>           


#define NUM_SLAVES 2 //Número de esclavos               
#define SIZE  10 //Tamaño total de los datos a almacenar          
#define DATA_SIZE (SIZE/NUM_SLAVES)//Tamaño de cada esclavo

//Se llama al prototipo de la función get_slave_no()
int get_slave_no(int*, int);
    
 int main()
 {
    int mytid;
    int slaves[NUM_SLAVES]; //Arreglo de los ids de los esclavos
    int items[SIZE];  //datos que se procesarán
    int result, i, sum;
    int results[NUM_SLAVES];    /* results from the slaves              */
    
    //Entrar al sistema PVM
    mytid = pvm_mytid();
    
    //Captura los valores desde la linea de comandos
    for(i = 0; i < SIZE; i++){
        printf("%d Agrega un valor ", i+1);
        int num;
        
        scanf("%d", &num);
        
        items[i] = num;
    }
        
    //Se cream los esclavos
    result = pvm_spawn("slave_add", (char**)0, PvmTaskDefault, "", NUM_SLAVES, slaves);
     
    //Revisar si se han creado el número correcto de esclavos
    if(result != NUM_SLAVES)
    {
        fprintf(stderr, "Error: No se puede crear el esclavo.\n");
        pvm_exit();
        exit(EXIT_FAILURE);
    }
    
    //  Se pasan los datos hacia los esclavos   
    for(i = 0; i < NUM_SLAVES; i++)
        {
        pvm_initsend(PvmDataDefault);
        pvm_pkint(items + i*DATA_SIZE, DATA_SIZE, 1);
        pvm_send(slaves[i], MSG_DATA);
    }
    
       //Recibe el resultado desde los esclavos
    for(i = 0; i < NUM_SLAVES; i++)
    {
        int bufid, bytes, type, source;
        int slave_no;
    
        //Recibe el mensaje desde cualquier esclavo
        bufid = pvm_recv(-1, MSG_RESULT);

        //Recibe la información del mensaje
        pvm_bufinfo(bufid, &bytes, &type, &source);
    
        // Recibe el número del esclavo
            slave_no = get_slave_no(slaves, source);

        // Desempaca el resultado en una posición apropiada
        pvm_upkint(results + slave_no, 1, 1);
    }
    
        //Se calcula el resultado final

    sum = 0;
    for(i = 0; i < NUM_SLAVES; i++){
        sum += results[i];
    }
    
    printf("La suma es %d\n", sum);
    //Se sale del sistema PVM    
    pvm_exit();
    exit(EXIT_SUCCESS);
} 
    
int get_slave_no(int* slaves, int task_id){
    int i;
    
    for(i = 0; i < NUM_SLAVES; i++){
        if(slaves[i] == task_id)
                return i;
    }    
      return -1;
 } 
    
