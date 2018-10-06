package net.piesfelices.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null){
            session.invalidate();
            request.setAttribute("errMessage","Se ha cerrado la sesión correctamente");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/login.jsp");
            requestDispatcher.forward(request,response);

            System.out.println("Desconectado");
        }
    }
}
