/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.dao.EmployeeDao;
import com.dao.LeaveBalanceDao;
import com.dao.UserDAO;
import com.dao.HrDao;

import com.entities.LeaveBalance;
import com.entities.User;
import com.entities.Employee;
import com.helper.ConnectionProvider;
import com.entities.Hr;
import com.entities.Message;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Date;
import java.time.LocalDate;

@MultipartConfig
public class AddSampleUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();

        try {
            String currentRole = request.getParameter("currentRole").toUpperCase();

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role").toUpperCase();

            User user = new User(fname, lname, email, password, gender, role);
            UserDAO userDao = new UserDAO(ConnectionProvider.getConnection());

            //for employee or hr
            Part img_part = request.getPart("emp_image");
            InputStream imageInputStream = img_part.getInputStream();
            ByteArrayOutputStream outputstream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int byteRead;
            while ((byteRead = imageInputStream.read(buffer)) != -1) {
                outputstream.write(buffer, 0, byteRead);
            }

            byte[] imageData = outputstream.toByteArray();

            String contact = request.getParameter("contact");
            String dateOfBirth = request.getParameter("dob");
            String address = request.getParameter("address");

            HttpSession s = request.getSession();

            Date dob = Date.valueOf(dateOfBirth);
            //fetch most recent userID
            int recentUserId = userDao.saveUser(user);
            System.out.print(recentUserId);
            if (recentUserId != -1) {

                if (currentRole.equals("SA")) {

                    if (role.equals("EMPLOYEE")) {
                        int designationId = Integer.parseInt(request.getParameter("designation"));
                        Employee emp = new Employee(recentUserId, designationId, contact, dob, imageData, address);
                        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());
                        if (empDao.saveEmp(emp)) {
                            LeaveBalance leaveBal = new LeaveBalance(recentUserId);
                            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
                            if (leaveBalDao.saveLeaveBal(leaveBal)) {
                                Message msg = new Message("Employee And leaveBal inserted Successfully !", "sucess", "alert-success");
                                s.setAttribute("msg", msg);
                            } else {
                                out.println("Leave Balance not inserted !! ");
                                Message msg = new Message("Leave Bal not inserted!", "error", "alert-danger");
                                s.setAttribute("msg", msg);
                            }
                        } else {
                            out.println("Employee not inserted !! ");
                            Message msg = new Message("Employee not inserted!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("super_admin/manage_employee.jsp");

                    } else if (role.equals("HR")) {
                        int designationId = Integer.parseInt(request.getParameter("designation"));
                        Hr hr = new Hr(recentUserId, designationId, contact, dob, imageData, address);
                        HrDao hrDao = new HrDao(ConnectionProvider.getConnection());
                        if (hrDao.saveHr(hr)) {
                            LeaveBalance leaveBal = new LeaveBalance(recentUserId);
                            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
                            if (leaveBalDao.saveLeaveBal(leaveBal)) {
                                Message msg = new Message("HR And leaveBal inserted Successfully !", "sucess", "alert-success");
                                s.setAttribute("msg", msg);
                            } else {
                                out.println("Leave Balance not inserted !! ");
                                Message msg = new Message("Leave Bal not inserted!", "error", "alert-danger");
                                s.setAttribute("msg", msg);
                            }
                        } else {
                            out.println("HR not inserted !! ");
                            out.println(hrDao);
                            Message msg = new Message("HR not inserted!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("super_admin/manage_hr.jsp");

                    }
                } else if (currentRole.equals("HR")) {
                    if (role.equals("EMPLOYEE")) {
                        int designationId = Integer.parseInt(request.getParameter("designation"));
                        Employee emp = new Employee(recentUserId, designationId, contact, dob, imageData, address);
                        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());
                        if (empDao.saveEmp(emp)) {
                            LeaveBalance leaveBal = new LeaveBalance(recentUserId);
                            LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
                            if (leaveBalDao.saveLeaveBal(leaveBal)) {
                                Message msg = new Message("inserted Successfully !", "sucess", "alert-success");
                                s.setAttribute("msg", msg);
                            } else {
                                out.println("Leave Balance not inserted !! ");
                                Message msg = new Message("Leave Bal not inserted!", "error", "alert-danger");
                                s.setAttribute("msg", msg);
                            }
                        } else {
                            out.print("not inserted !! ");
                            Message msg = new Message("Employee not inserted!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("hr/manage_employee.jsp");
                    }
                }
            } else {
                out.print("Something went Wrong");
                Message msg = new Message("User not inserted !", "error", "alert-danger");
                s.setAttribute("msg", msg);

                if (currentRole.equals("SA")) {
                    if (role.equals("EMPLOYEE")) {
                        response.sendRedirect("super_admin/manage_employee.jsp");
                    } else if (role.equals("HR")) {
                        response.sendRedirect("super_admin/manage_hr.jsp");
                    }
                } else if (currentRole.equals("HR")) {
                    response.sendRedirect("hr/manage_employee.jsp");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
