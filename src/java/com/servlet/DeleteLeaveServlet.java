/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;


import com.dao.LeaveApplicationDao;
import com.helper.ConnectionProvider;
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
public class DeleteLeaveServlet extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            String leaveId = request.getParameter("leaveAppId");
            int leaveAppId = Integer.parseInt(leaveId);
            
            boolean deleted = deleteLeave(leaveAppId);
            
            if(deleted){
                out.print("success");
            }else{
                out.print("failure");
            }
        }
    }
    
    private boolean deleteLeave(int leaveAppId) {
        LeaveApplicationDao leaveAppDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
        if(leaveAppDao.deleteLeaveApp(leaveAppId)){
            return true;
        }
        return false;
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
