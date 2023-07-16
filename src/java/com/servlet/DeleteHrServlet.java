/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.helper.ConnectionProvider;
import com.dao.HrDao;


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
public class DeleteHrServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            int hrId = Integer.parseInt(request.getParameter("hrId"));
            int userIdHr = Integer.parseInt(request.getParameter("userIdHr"));
            
            boolean deleted = deleteHrAndUser(hrId, userIdHr);
            
            if(deleted){
                out.print("success");
            }else{
                out.print("failure");
            }
        }
    }
    
    private boolean deleteHrAndUser(int hrId, int userIdHr) {
        HrDao hrDao = new HrDao(ConnectionProvider.getConnection());
        if(hrDao.deleteHrUser(hrId, userIdHr)){
            return true;
        }
        return false;
    }
}
