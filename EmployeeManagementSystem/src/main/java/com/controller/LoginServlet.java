package com.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.mindrot.jbcrypt.BCrypt;

import com.model.User;
import com.service.AuthService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    AuthService service = new AuthService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        

        try {

            User user = service.login(username, password);

           

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());

                response.sendRedirect("employee?action=dashboard");
                return;

            } else {

                request.setAttribute("error", "Invalid username or password!");
                request.getRequestDispatcher("/login.jsp")
                       .forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
}