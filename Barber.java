package org.main;

import java.util.concurrent.*;

class BarberoDormilon extends Thread {

    /* PREREQUISITES */


  /* we create the semaphores. First there are no customers and 
   the barber is asleep so we call the constructor with parameter
   0 thus creating semaphores with zero initial permits. 
   Semaphore(1) constructs a binary semaphore, as desired. */

    public static Semaphore clientes = new Semaphore(0);
    public static Semaphore barbero = new Semaphore(0);
    public static Semaphore accesoAsientos = new Semaphore(1);

    /* we denote that the number of chairs in this barbershop is 5. */

    public static final int CHAIRS = 5;

  /* we create the integer numberOfFreeSeats so that the customers
   can either sit on a free seat or leave the barbershop if there
   are no seats available */

    public static int numeroDeAsientosLibres = CHAIRS;


    /* THE CUSTOMER THREAD */

    class Cliente extends Thread {
  
  /* we create the integer iD which is a unique ID number for every customer
     and a boolean notCut which is used in the Customer waiting loop */

        int iD;
        boolean noCorte =true;

        /* Constructor for the Customer */

        public Cliente(int i) {
            iD = i;
        }

        public void run() {
            while (noCorte) {  // as long as the customer is not cut
                try {
                    accesoAsientos.acquire();  //tries to get access to the chairs
                    if (numeroDeAsientosLibres > 0) {  //if there are any free seats
                        System.out.println("Cliente " + this.iD + " se acaba de sentar.");
                        numeroDeAsientosLibres--;  //sitting down on a chair
                        clientes.release();  //notify the barber that there is a customer
                        accesoAsientos.release();  // don't need to lock the chairs anymore
                        try {
                            barbero.acquire();  // now it's this customers turn but we have to wait if the barber is busy
                            noCorte = false;  // this customer will now leave after the procedure
                            this.get_corteCabello();  //cutting...
                        } catch (InterruptedException ex) {}
                    }
                    else  {  // there are no free seats
                        System.out.println("No hay asientos libres. Cliente " + this.iD + " ha dejado la barbería.");
                        accesoAsientos.release();  //release the lock on the seats
                        noCorte =false; // the customer will leave since there are no spots in the queue left.
                    }
                }
                catch (InterruptedException ex) {}
            }
        }

        /* this method will simulate getting a hair-cut */

        public void get_corteCabello() {
            System.out.println("Cliente " + this.iD + " le están cortando el pelo");
            try {
                sleep(2050);
                System.out.println("Cliente paga y se va");
            } catch (InterruptedException ex) {}
        }

    }


    /* THE BARBER THREAD */


    class Barbero extends Thread {

        public Barbero() {}

        public void run() {
            while(true) {  // runs in an infinite loop
                try {
                    clientes.acquire(); // tries to acquire a customer - if none is available he goes to sleep
                    accesoAsientos.release(); // at this time he has been awaken -> want to modify the number of available seats
                    numeroDeAsientosLibres++; // one chair gets free
                    barbero.release();  // the barber is ready to cut
                    accesoAsientos.release(); // we don't need the lock on the chairs anymore
                    this.cortarPelo();  //cutting...
                } catch (InterruptedException ex) {}
            }
        }

        /* this method will simulate cutting hair */

        public void cortarPelo(){
            System.out.println("El barbero está cortando el pelo");
            try {
                sleep(5000);
            } catch (InterruptedException ex){ }
        }
    }

    /* main method */

    public static void main(String args[]) {

        BarberoDormilon barberShop = new BarberoDormilon();  //Creates a new barbershop
        barberShop.start();  // Let the simulation begin
    }

    public void run(){
        Barbero barberoA = new Barbero();  //Giovanni is the best barber ever
        barberoA.start();  //Ready for another day of work

        /* This method will create new customers for a while */

        for (int i=1; i<15; i++) {
            Cliente aCliente = new Cliente(i);
            aCliente.start();
            try {
                sleep(2000);
            } catch(InterruptedException ex) {};
        }
    }
}
