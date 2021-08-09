package org.main.semaforo;

class FilosofosComelones {
    public static void main(String args[]) {
        Semaphore palillos[];
        Filosofo filosofos[];
        palillos = new Semaphore[5];

        for (int i=0; i<5; i++){
            palillos[i] = new Semaphore(1);
        }
        filosofos = new Filosofo[5];

        for (int i=0; i<5; i++) {
            filosofos[i] = new Filosofo(i, palillos);
            filosofos[i].start();
        }
    }
}


class Semaphore {
    private int value;
    public Semaphore(int value) {
        this.value = value;
    }
    public synchronized void p() {
        while (value == 0) {
            try {
                System.out.println("El palillo se está usando");
                wait();
            } catch(InterruptedException e) {}
        }
        value = value - 1;
    }
    public synchronized void v() {
        value = value + 1;
        notify();
    }
}

class Filosofo extends Thread {
    private int identificador;
    private Semaphore palillos[];

    public Filosofo(int myName, Semaphore chopSticks[]) {
        this.identificador = myName;
        this.palillos = chopSticks;
    }

    public void run() {
        while (true) {
            System.out.println("Filósofo "+ (identificador +1) +" está pensando.");
            try {
                sleep ((int)(Math.random()*20000));
            } catch (InterruptedException e) {}

            System.out.println("Filósofo  "+ (identificador+1) +" tiene hambre.");

            palillos[identificador].p();
            palillos[(identificador +1)%5].p();

            System.out.println("Filósofo "+ (identificador+1) +" está comiendo.");

            try {
                sleep ((int)(Math.random()*10000));
            } catch (InterruptedException e) {}

            palillos[identificador].v();       // Release right
            palillos[(identificador +1)%5].v(); // Release left

        }
    }
}
