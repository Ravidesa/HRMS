/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.entities.Message;
import com.entities.Employee;
import com.entities.User;
import com.entities.Hr;
import com.helper.ConnectionProvider;

import com.dao.EmployeeDao;
import com.dao.UserDAO;
import com.dao.HrDao;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

@MultipartConfig
public class UpdateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            String currentRole = request.getParameter("currentRole").toUpperCase();

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String gender = request.getParameter("gender");
            String role = request.getParameter("role").toUpperCase();

//            String gender = request.getParameter("gender");
            int emp_id = Integer.parseInt(request.getParameter("empId"));
            int userEmpId = Integer.parseInt(request.getParameter("userIdEmp"));
            User user = new User(userEmpId, fname, lname, email, gender);
            UserDAO userDao = new UserDAO(ConnectionProvider.getConnection());

            Part img_part = request.getPart("emp_image");
            InputStream imageInputStream = img_part.getInputStream();
            ByteArrayOutputStream outputstream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int byteRead;
            while ((byteRead = imageInputStream.read(buffer)) != -1) {
                outputstream.write(buffer, 0, byteRead);
            }

            //for employee or hr
            byte[] imageData = outputstream.toByteArray();
            
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");

            HttpSession s = request.getSession();

            if (userDao.updateUser(user)) {

                if (currentRole.equals("SA")) {
                    if (role.equals("EMPLOYEE")) {
                        int degIdEmp = Integer.parseInt(request.getParameter("degIdEmp"));
                        Employee emp = new Employee(emp_id, degIdEmp, contact, imageData, address);
                        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());

                        if (empDao.updateEmp(emp)) {
                            Message msg = new Message("Employee Updated Successfully !", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            out.print("Employee Updated inserted !! ");
                            Message msg = new Message("Employee Updated Updated!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        
                        response.sendRedirect("super_admin/manage_employee.jsp");
                    
                    } else if (role.equals("HR")) {
                        int degIdEmp = Integer.parseInt(request.getParameter("degIdEmp"));
                        Hr hr = new Hr(emp_id, degIdEmp, contact, imageData, address);
                        HrDao hrDao = new HrDao(ConnectionProvider.getConnection());

                        if (hrDao.updateHr(hr)) {
                            Message msg = new Message("HR Updated Successfully !", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            out.print("HR not Updated !! ");
                            Message msg = new Message("HR not Updated!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        
                        response.sendRedirect("super_admin/manage_hr.jsp");
                    }
                } else if (currentRole.equals("HR")) {
                    if (role.equals("EMPLOYEE")) {
                        int degIdEmp = Integer.parseInt(request.getParameter("degIdEmp"));
                        Employee emp = new Employee(emp_id, degIdEmp, contact, imageData, address);
                        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());

                        if (empDao.updateEmp(emp)) {
                            Message msg = new Message("Employee Updated Successfully !", "sucess", "alert-success");
                            s.setAttribute("msg", msg);
                        } else {
                            out.print("Employee not inserted !! ");
                            Message msg = new Message("Employee not Updated!", "error", "alert-danger");
                            s.setAttribute("msg", msg);
                        }
                        response.sendRedirect("hr/manage_employee.jsp");
                    }
                }

            } else {
                out.print("User not Updated !! ");
                Message msg = new Message("User not updated!", "error", "alert-danger");
                s.setAttribute("msg", msg);
                
                if(currentRole.equals("SA")){
                    if (role.equals("EMPLOYEE")) {
                        response.sendRedirect("super_admin/manage_employee.jsp");
                    }else if(role.equals("HR")){
                        response.sendRedirect("super_admin/manage_hr.jsp");
                    }
                }else if(currentRole.equals("HR")){
                    response.sendRedirect("hr/manage_employee.jsp");
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
