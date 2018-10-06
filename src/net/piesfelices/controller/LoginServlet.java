package net.piesfelices.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.piesfelices.bean.LoginBean;
import net.piesfelices.dao.LoginDao;

public class LoginServlet extends HttpServlet {
    public LoginServlet() {}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        LoginBean loginBean = new LoginBean();

        loginBean.setUsuario(usuario);
        loginBean.setPassword(password);

        LoginDao loginDao = new LoginDao();

        String userValidate = loginDao.authenticateUser(loginBean);

        if (userValidate.equals("SUCCESS")) {
            request.setAttribute("usuario",usuario);
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        } else {
            request.setAttribute("errMessage",userValidate);
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
