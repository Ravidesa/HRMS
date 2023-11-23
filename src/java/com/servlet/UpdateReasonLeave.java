/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.dao.LeaveApplicationDao;
import com.dao.LeaveBalanceDao;
import com.entities.LeaveBalance;
import com.entities.Message;
import com.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
public class UpdateReasonLeave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            String leaveId = request.getParameter("leaveApplicationId");
            int leaveApplicationId = Integer.parseInt(leaveId);
            String rejectReason = request.getParameter("reason");

            LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

            if (leaveDao.updateRejectReason(leaveApplicationId, rejectReason)) {
                out.print("success");
            } else {
                out.print("failure");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
