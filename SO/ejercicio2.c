#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

// Ejecutar árbol de procesos: pstree -pl

int main(){
	int id;
	id = fork();
	
	if(id == 0){
		printf("%s %d\n", "soy el hijo y mi id", getpid());
		sleep(10);
	}else{
		wait(NULL);
		printf("%s %d\n", "soy el padre y mi id", getpid());
	}
}
