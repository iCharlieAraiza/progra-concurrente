import java.util.Random;
import java.util.concurrent.Semaphore;
import java.util.logging.Level;
import java.util.logging.Logger;

class SincronizacionProcesos {

    private static SincronizacionProcesos thrdsync;
    private static Thread t1, t2, t3, t4, t5;
    private static final Random rand = new Random();
    private static Semaphore semaforo = new Semaphore(2, true);
    String text = "Inicio del libro";

    private void ocupado() {
        try {
            Thread.sleep(rand.nextInt(1000) + 1000);
        } catch (InterruptedException e) {
        }
    }

    void escribir(String sentence) {
        System.out.println(Thread.currentThread().getName() + " comienza a escribir");
        text += "\n" + sentence;
        System.out.println(text);
        System.out.println("Fin del libro\n");
        System.out.println(Thread.currentThread().getName() + " termina de escribir.");
    }

    void leer() {
        System.out.println("\n" + Thread.currentThread().getName() + " comienza a leer.");
    }

    private class Escritor implements Runnable {

        SincronizacionProcesos ts;

        Escritor(String name, SincronizacionProcesos ts) {
            super();
            this.ts = ts;
        }
        public void run() {
            while (true) {
                try {
                    semaforo.acquire();
                } catch (InterruptedException ex) {
                    Logger.getLogger(SincronizacionProcesos.class.getName()).log(Level.SEVERE, null, ex);
                }
                String new_sentence = new String("\tnueva línea del libro");
                ocupado();
                ts.escribir(new_sentence);
                semaforo.release();
            } // of while
        }
    }

    private class Lector implements Runnable {
        SincronizacionProcesos ts;
        Lector(String name, SincronizacionProcesos ts) {
            super();
            this.ts = ts;
        }

        public void run() {
            while (true) {
                try {
                    semaforo.acquire();
                } catch (InterruptedException ex) {
                    Logger.getLogger(SincronizacionProcesos.class.getName()).log(Level.SEVERE, null, ex);
                }
                ocupado();
                ts.leer();
                semaforo.release();
            } // of while
        }
    }

    public void iniciarHilos() {
        SincronizacionProcesos ts = new SincronizacionProcesos();
        t1 = new Thread(new Escritor("Escritor # 1", ts));
        t2 = new Thread(new Lector("Lector # 1", ts));
        t4 = new Thread(new Lector("Lector # 2", ts));
        t1.start();
        t2.start();
        t4.start();

    }

    public static void main(String[] args) {
        thrdsync = new SincronizacionProcesos();
        System.out.println("Iniciemos...\n");
        thrdsync.iniciarHilos();
    }
