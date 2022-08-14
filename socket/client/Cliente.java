package org.main;
import java.net.*;
import java.io.*;

public class Client {
    public static void main(String[] args) {
        try{
            Socket socket = new Socket("localhost",80);
            DataOutputStream outputStream = new DataOutputStream(socket.getOutputStream());
            outputStream.writeUTF("Hola servidor!");
            outputStream.flush();
            outputStream.close();
            socket.close();
        }catch(Exception e){System.out.println(e);}
    }
}
