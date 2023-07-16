/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.entities.LeaveBalance;
import com.entities.Message;

import com.dao.LeaveApplicationDao;
import com.dao.LeaveBalanceDao;
import com.entities.LeaveApplication;
import com.helper.ConnectionProvider;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author RAVI DESAI
 */
public class UpdateLeaveApply extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            int applicationId = Integer.parseInt(request.getParameter("leaveAppId"));
            int userId = Integer.parseInt(request.getParameter("leaveAppUserId"));
            int leaveCatId = Integer.parseInt(request.getParameter("catLeaveId"));

            int prevDaysUsed = Integer.parseInt(request.getParameter("prevDayUsed"));
            int updatedDayUsed = Integer.parseInt(request.getParameter("updatedDayUsed"));

            String currentRole = request.getParameter("currentRole").toUpperCase();

            String startDateApp = request.getParameter("startDateEdit");
            String endDateApp = request.getParameter("endDateEdit");
            String status = request.getParameter("status").toUpperCase();
            String reason = request.getParameter("reasonEdit");

            Date startDate = Date.valueOf(convertToSqlDateFormat(startDateApp));
            Date endDate = Date.valueOf(convertToSqlDateFormat(endDateApp));

            HttpSession s = request.getSession();

            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
            LeaveBalance leaveBal = leaveBalDao.fetchRemainingAndUsedDays(userId);

            int remainingDaysafterCalculating = leaveBal.getDaysRemaining() - updatedDayUsed;
            System.out.println("Rem --> " + remainingDaysafterCalculating);
            if (status.equals("PENDING")) {
                if (currentRole.equals("EMPLOYEE")) {
                    if (remainingDaysafterCalculating > 0) {
                        LeaveApplication leaveApp = new LeaveApplication(startDate, endDate, reason, updatedDayUsed, applicationId, leaveCatId);
                        LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
                        if (leaveDao.updateLeaveApplication(leaveApp)) {
                            Message msg = new Message("Application Updated!", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            Message msg = new Message("Not updated", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("emp/manage_leave.jsp");
                    } else {
                        Message msg = new Message("Your Remaining days are not available !", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                        response.sendRedirect("emp/manage_leave.jsp");
                    }
                } else if (currentRole.equals("HR")) {
                    if (remainingDaysafterCalculating > 0) {
                        LeaveApplication leaveApp = new LeaveApplication(startDate, endDate, reason, updatedDayUsed, applicationId, leaveCatId);
                        LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
                        if (leaveDao.updateLeaveApplication(leaveApp)) {
                            Message msg = new Message("Application Updated!", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            Message msg = new Message("Not updated", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("hr/leave_apply_hr.jsp");
                    } else {
                        Message msg = new Message("Your Remaining days are not available !", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                        response.sendRedirect("hr/leave_apply_hr.jsp");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Convert date string from "dd-mm-yyyy" format to "yyyy-mm-dd" format
    private static String convertToSqlDateFormat(String inputDate) {
        String[] parts = inputDate.split("-");
        return parts[2] + "-" + parts[1] + "-" + parts[0];
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
