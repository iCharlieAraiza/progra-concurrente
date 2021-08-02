#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

void doSomeWork(void){
	const int NUM_TIMES = 5;
	for(int i = 0; i < NUM_TIMES; i++){
		sleep(rand()%4);
		printf("Done pass %d\n", i);
	}
}

int main(int argc, char *argv[]){
	printf("I am: %d\n", (int) getpid());

	pid_t pid = fork();
	printf("fork returned %d\n", (int) pid);

	if(pid<0){
		perror("Fork failed");
	}
	if(pid==0){
		 printf("I'am the child with pid %d \n", (int) getpid());
		 doSomeWork();
		 exit(0);
	}
	
	printf("I'm the parent, waiting for child to end.\n");
	wait(NULL);
	printf("Parent ending\n");

	return 0;
}
