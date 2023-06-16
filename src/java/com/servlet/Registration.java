/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;


import com.helper.ConnectionProvider;
import com.dao.UserDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 *
 * @author RAVI DESAI
 */
public class Registration extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        String tableName = "users";

        // Get attribute names and values from the request parameters
        List<String> attributeNames = new ArrayList<>();
        List<String> attributeValues = new ArrayList<>();

        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String paramValue = request.getParameter(paramName);
            attributeNames.add(paramName);
            attributeValues.add(paramValue);
        }
        
        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
//        out.println(dao);
        if(dao.insertUserData(tableName, attributeNames, attributeValues)){
            out.print("insertion successfully done!");
            response.sendRedirect("registration.jsp");
        }else{
            out.print("Something went Wrong");
        }
    }
    
}
