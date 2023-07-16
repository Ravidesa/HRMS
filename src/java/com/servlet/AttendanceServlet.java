package com.servlet;

import com.dao.PunchDataDao;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import com.entities.GetAttendace;
import com.helper.ConnectionProvider;

public class AttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the user ID from the request parameter
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Fetch the attendance data for the given user ID from the database or any other source
        // For demonstration purposes, let's assume the data is retrieved as a list of date, day, and duration triples
        PunchDataDao punchDao = new PunchDataDao(ConnectionProvider.getConnection());
        List<GetAttendace<Date, String, String>> attendanceData = punchDao.getAttendanceIndi(userId);

        // Create a JSON array to hold the attendance data
        JSONArray jsonArray = new JSONArray();
        
        // Iterate over the attendance data list and create JSON objects for each date, day, and duration
        for (GetAttendace<Date, String, String> attendance : attendanceData) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("date", attendance.getDate());
            jsonObject.put("weekday", attendance.getWeekDay());
            jsonObject.put("duration", attendance.getDuration());
            jsonArray.put(jsonObject);
        }

        // Create a JSON object to hold the final response
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("attendanceData", jsonArray);

        // Set the content type of the response to application/json
        response.setContentType("application/json");

        // Write the JSON response to the output stream
        response.getWriter().write(jsonResponse.toString());
    }

}
