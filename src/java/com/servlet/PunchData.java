package com.servlet;

import com.dao.PunchDataDao;
import com.dao.UserDAO;
import com.entities.Message;
import com.entities.PunchP;
import com.entities.User;
import com.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/punchData")
public class PunchData extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract form data
        int userId = Integer.parseInt(request.getParameter("userId"));
        String punchInTime = request.getParameter("punchInTimeInput");
        String punchOutTime = request.getParameter("punchOutTimeInput");
        String duration = request.getParameter("durationInput");
        String currentDate = request.getParameter("currentDateInput");
        String week_day = request.getParameter("selectedWeekDay");
        String role = request.getParameter("role");
//          SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

        PrintWriter out = response.getWriter();
        try {
            Date date = Date.valueOf(convertToSqlDateFormat(currentDate));
//           System.out.println(date.toString());

            PunchP p = new PunchP(userId, punchInTime, punchOutTime, duration, date, week_day);
            PunchDataDao punch = new PunchDataDao(ConnectionProvider.getConnection());

            HttpSession s = request.getSession();

            if (role.equalsIgnoreCase("Employee")) {
                if (punch.savePunch(p)) {
                    Message msg = new Message("PunchData inserted ", "sucess", "alert-success");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("emp/attendance.jsp?isPunched=true");
                } else {
                    out.print("Employee attendance inserted !! ");
                    Message msg = new Message("PunchData not inserted!", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("emp/attendance.jsp?isPunched=false");
                }
            } else if (role.equalsIgnoreCase("HR")) {
                if (punch.savePunch(p)) {
                    Message msg = new Message("PunchData inserted ", "sucess", "alert-success");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("hr/attendanceHr.jsp?isPunched=true");
                } else {
                    out.print("Hr attendace not inserted !! ");
                    Message msg = new Message("PunchData not inserted!", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                    response.sendRedirect("hr/attendanceHr.jsp?isPunched=false");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Send failure response
            response.setContentType("text/plain");

            out.println("Failed to insert data!" + duration);
        }
    }
//    Convert date string from "dd-mm-yyyy" format to "yyyy-mm-dd" format

    private static String convertToSqlDateFormat(String inputDate) {
        String[] parts = inputDate.split("-");
        return parts[2] + "-" + parts[1] + "-" + parts[0];
    }
}
