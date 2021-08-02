
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[]){
	printf("I am: %d\n", (int) getpid());

	pid_t pid = fork();
	printf("fork returned %d\n", (int) pid);

	if(pid<0){
		perror("Fork failed");
	}
	if(pid==0){
		 printf("I'am the child with pid %\n", (int) getpid());
		 exit(0);
	}else if(pid > 0){
			printf("I am the parent\n");
	}
	
	return 0;
}
