/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;


import com.helper.ConnectionProvider;
import com.dao.UserDAO;
import com.entities.Message;
import com.entities.User;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author RAVI DESAI
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uEmail = request.getParameter("userEmail");
        String upassword = request.getParameter("password");

        if (isValidCredentials(uEmail, upassword) == true) {
            
            UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
            User u = dao.getUserRole(uEmail);
            
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", u);
            session.setMaxInactiveInterval(86400);
            
            if (u.getRole().equals("EMPLOYEE")) {
                response.sendRedirect("employee_dashboard.jsp");
            } else if (u.getRole().equals("HR")) {
                response.sendRedirect("hr/index.jsp?id="+u.getId());
            } else if (u.getRole().equals("SA")) {
                response.sendRedirect("admin_dashboard.jsp");
            }
        } else {
            Message msg = new Message("Inavalid Details ! Try again", "error", "alert-danger");
            HttpSession s = request.getSession();
            s.setAttribute("msg", msg);
            response.sendRedirect("login.jsp");
        }
    }

    private boolean isValidCredentials(String userEmail, String pass) {
        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
        User u = dao.getUserEmailAndPassword(userEmail,pass);
        System.out.println(u);
        if(u == null || !pass.equals(u.getPassword())) {
            System.out.println("nullll");
            
            return false;    
        } else {
            System.out.println("getting.....");
            return true;
        }
        
    }

//    private User getUserRole(String userEmail) {
//        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
//        User u = dao.getUserRole(userEmail);
//
//        if (u.getRole().equals("EMPLOYEE")) {
//            return u;
//        } else if (u.getRole().equals("HR")) {
//            return u;
//        } else if (u.getRole().equals("SA")) {
//            return u;
//        }
//        return u;
//    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
