<%@page import="com.entities.PunchP"%>
<%@page import="com.dao.PunchDataDao"%>
<%@page import="com.helper.GetDesignationOptions"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.entities.Employee"%>
<%@page import="com.dao.EmployeeDao"%>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*, java.io.PrintWriter" %>


<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <style>
            .present {
                background-color: #b3ffb3;
            }

            .absent {
                background-color: #ffb3b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Weekly Attendance</h1>
            <table class="table">



                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Day</th>
                        <th>Duration(HH:MM:SS)</th>
                    </tr>
                </thead>
                <tbody>
                    <%                 PunchDataDao punch = new PunchDataDao(ConnectionProvider.getConnection());
                        List<PunchP> punchList = punch.getAttendance();
                        for (PunchP punchData : punchList) {

                    %>
                     <td><%= punchData.getPunch_date() %></td>
                            <td><%= punchData.getWeek_day()%></td>
                            <td><%= punchData.getDuration()%></td>
                    <!-- Add more rows for other days -->
                    
                    
                    <% } %>
                </tbody>
            </table>
                    
        </div>
    </body>
</html>


<%@ include file="footer.jsp" %>





