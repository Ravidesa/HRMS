
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

public class UpdateStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            String leaveId = request.getParameter("leaveApplicationId");
            int leaveApplicationId = Integer.parseInt(leaveId);
            int userId = Integer.parseInt(request.getParameter("userId"));
            int daysUsedForLeave = Integer.parseInt(request.getParameter("daysUsedForLeave"));

            String leaveStatus = request.getParameter("leaveStatus").toUpperCase();
            String currentRole = request.getParameter("currentRole").toUpperCase();
            String role = request.getParameter("role").toUpperCase();

            HttpSession s = request.getSession();

            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
            LeaveBalance leaveBal = leaveBalDao.fetchRemainingAndUsedDays(userId);

            int remainingDaysafterCalculating = leaveBal.getDaysRemaining();
            int usedDays = leaveBal.getDaysUsed();

            if (leaveStatus.equals("APPROVED")) {
                remainingDaysafterCalculating = leaveBal.getDaysRemaining() - daysUsedForLeave;
                usedDays = daysUsedForLeave + leaveBal.getDaysUsed();
            }

            System.out.println("remainingDays --> " + remainingDaysafterCalculating);
            System.out.println("useddays --> " + usedDays);

            if (currentRole.equals("HR")) {
                LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

                if (leaveDao.updateStatus(leaveApplicationId, leaveStatus)) {
                    if (leaveBalDao.updateRemainingAndUsedDays(userId, remainingDaysafterCalculating, usedDays)) {
                        Message msg = new Message("Status Updated!", "sucess", "alert-success");
                        s.setAttribute("msg", msg);
                    } else {
                        Message msg = new Message("Wrong with Bal!", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
//                    response.sendRedirect("hr/manage_leave_emp.jsp");
                    out.print("success");
                } else {
                    Message msg = new Message("Wrong with Status!", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                    out.print("failure");
                }
                
            } else if (currentRole.equals("SA")) {
                if (role.equals("HR")) {
                    LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

                    if (leaveDao.updateStatus(leaveApplicationId, leaveStatus)) {
                        if (leaveBalDao.updateRemainingAndUsedDays(userId, remainingDaysafterCalculating, usedDays)) {
                            Message msg = new Message("Status Updated!", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            Message msg = new Message("Wrong with Bal!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
//                    response.sendRedirect("hr/manage_leave_emp.jsp");
                        out.print("success");
                    } else {
                        Message msg = new Message("Wrong with Status!", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                        out.print("failure");
                    }
                    
                } else if (role.equals("EMPLOYEE")) {
                    LeaveApplicationDao leaveDao = new LeaveApplicationDao(ConnectionProvider.getConnection());

                    if (leaveDao.updateStatus(leaveApplicationId, leaveStatus)) {
                        if (leaveBalDao.updateRemainingAndUsedDays(userId, remainingDaysafterCalculating, usedDays)) {
                            Message msg = new Message("Status Updated!", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            Message msg = new Message("Wrong with Bal!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        out.print("success");
                    } else {
                        Message msg = new Message("Wrong with Status!", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                        out.print("failure");
                    }
                    
                }
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
