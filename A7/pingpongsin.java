class SynchronizedPingPong extends Thread
{
    private String word;
    public SynchronizedPingPong(String s) {word=s;}
    public void run()
    {
        synchronized(getClass())
        {
            for (int i=0;i<3000;i++)
            {
                System.out.print(word);
                System.out.flush();
                getClass().notifyAll();
                try
                {getClass().wait();}
                catch (java.lang.InterruptedException e) {}
            }
            getClass().notifyAll();
        }
    }
    public static void main(String[] args)
    {
        SynchronizedPingPong tP=new SynchronizedPingPong("P");
        SynchronizedPingPong tp=new SynchronizedPingPong("p");
        tp.start();
        tP.start();
    }
}
