package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/checkPunchInHr")
public class checkPunchInHr extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int uId = Integer.parseInt(request.getParameter("userId"));
         LocalDate localDate = LocalDate.now();
        Date currentDate = Date.valueOf(localDate);
//        SimpleDateFormat date = new SimpleDateFormat("dd-MM-yyyy");
       
        PrintWriter out = response.getWriter();
//        out.print(D);

        String dbUrl = "jdbc:mysql://localhost:3306/summerintern";
        String dbUsername = "root";
        String dbPassword = "root";

        // Establish database connection
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String checkQuery = "SELECT * FROM attendance_emp WHERE user_id = ? AND punch_date = ?";
            PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
            checkStatement.setInt(1, uId);
            checkStatement.setDate(2, currentDate);

            ResultSet rs = checkStatement.executeQuery();
            boolean isPunched = rs.next();


            response.sendRedirect("hr/attendanceHr.jsp?isPunched=" + isPunched);

        } catch (SQLException ex) {
            Logger.getLogger(checkPunchIn.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static String convertToSqlDateFormat(String inputDate) {
        String[] parts = inputDate.split("-");
        return parts[2] + "-" + parts[1] + "-" + parts[0];

    }
}
