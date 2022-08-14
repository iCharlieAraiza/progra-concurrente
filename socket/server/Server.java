package org.main;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(80);
        Socket socket = serverSocket.accept();

        System.out.println("El cliente se ha conectado");

        InputStreamReader inputStreamReader = new InputStreamReader(socket.getInputStream());
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

        String string = bufferedReader.readLine();
        System.out.println("cliente: " + string);

        PrintWriter printWriter = new PrintWriter(socket.getOutputStream());
        printWriter.println("<h1>hello</h1>");
        printWriter.flush();
    }
}
