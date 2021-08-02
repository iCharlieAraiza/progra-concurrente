#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char *argv[]){
	printf("I am: %d\n", (int) getpid());

	pid_t pid = fork();
	printf("fork returned %d\n", (int) pid);

	if(pid<0){
		perror("Fork failed");
	}
	if(pid==0){
		 printf("I'am the child with pid %d \n", (int) getpid());
		sleep(5);
		 exit(0);
	}
	
	printf("I'm the parent, waiting for child to end.\n");
	wait(NULL);
	printf("Parent ending\n");

	return 0;
}
