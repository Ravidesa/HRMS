/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.helper.ConnectionProvider;
import com.dao.EmployeeDao;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author RAVI DESAI
 */
public class DeleteEmployeeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            int empId = Integer.parseInt(request.getParameter("empId"));
            int userIdEmp = Integer.parseInt(request.getParameter("userIdEmp"));
            
            boolean deleted = deleteEmployeeAndUser(empId, userIdEmp);
            System.out.println(deleted);
            if(deleted){
                out.print("success");
            }else{
                out.print("failure");
            }
        }
    }
    
    private boolean deleteEmployeeAndUser(int empId, int userIdEmp) {
        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());
        if(empDao.deleteEmpUser(empId, userIdEmp)){
            return true;
        }
        return false;
    }
}
