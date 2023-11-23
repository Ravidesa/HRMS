/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.entities.LeaveApplication;
import com.entities.LeaveBalance;
import com.entities.Message;

import com.dao.LeaveApplicationDao;
import com.dao.LeaveBalanceDao;
import com.helper.ConnectionProvider;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

public class ApplyLeave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            System.out.println("hello");
            String userIdString = request.getParameter("userIdLeave");
            int userId = Integer.parseInt(userIdString);
            int leaveCatId = Integer.parseInt(request.getParameter("leaveCatId"));
            int totalDaysForLeave = Integer.parseInt(request.getParameter("daysForLeave"));

            String reason = request.getParameter("reason");
            String role = request.getParameter("role").toUpperCase();

            String startDateApp = request.getParameter("startDate");
            String endDateApp = request.getParameter("endDate");

            Date startDate = Date.valueOf(convertToSqlDateFormat(startDateApp));
            Date endDate = Date.valueOf(convertToSqlDateFormat(endDateApp));

            HttpSession s = request.getSession();

            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
            LeaveBalance leaveBal = leaveBalDao.fetchRemainingAndUsedDays(userId);

            int remainingDaysafterCalculating = leaveBal.getDaysRemaining() - totalDaysForLeave;
            int usedDays = totalDaysForLeave + leaveBal.getDaysUsed();

            System.out.println("remainingDays --> " + remainingDaysafterCalculating);
            System.out.println("useddays --> " + usedDays);
            if (role.equals("EMPLOYEE")) {
                if (remainingDaysafterCalculating > 0) {

                    LeaveApplication leaveApp = new LeaveApplication(userId, leaveCatId, startDate, endDate, reason, totalDaysForLeave);
                    LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

                    if (leaveDao.saveLeave(leaveApp)) {
                            Message msg = new Message("apply for leave Successfully !", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
//                        if (leaveBalDao.updateRemainingAndUsedDays(userId, remainingDaysafterCalculating, usedDays)) {
//                            Message msg = new Message("apply for leave Successfully !", "sucess", "alert-success");
//                            s.setAttribute("msg", msg);
//                        } else {
//                            Message msg = new Message("Wrong with leaveBal updation !", "error", "alert-danger");
//                            s.setAttribute("msg", msg);
//                        }

                    } else {
                        Message msg = new Message("something wrong with leave apply !", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
                    response.sendRedirect("emp/manage_leave.jsp");
                } else {
                    Message msg = new Message("Your Remaining days are not available !", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("emp/manage_leave.jsp");
                }
            } else if (role.equals("HR")) {
                if (remainingDaysafterCalculating > 0) {

                    LeaveApplication leaveApp = new LeaveApplication(userId, leaveCatId, startDate, endDate, reason, totalDaysForLeave);
                    LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

                    if (leaveDao.saveLeave(leaveApp)) {
                            Message msg = new Message("apply for leave Successfully !", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
//                        if (leaveBalDao.updateRemainingAndUsedDays(userId, remainingDaysafterCalculating, usedDays)) {
//                            Message msg = new Message("apply for leave Successfully !", "sucess", "alert-success");
//                            s.setAttribute("msg", msg);
//                        } else {
//                            Message msg = new Message("Wrong with leaveBal updation !", "error", "alert-danger");
//                            s.setAttribute("msg", msg);
//                        }

                    } else {
                        Message msg = new Message("something wrong with leave apply !", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
                    response.sendRedirect("hr/leave_apply_hr.jsp");
                } else {
                    Message msg = new Message("Your Remaining days are not available !", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("hr/leave_apply_hr.jsp");
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
