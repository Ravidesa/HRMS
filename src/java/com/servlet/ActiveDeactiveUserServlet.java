
package com.servlet;

import com.dao.EmployeeDao;
import com.dao.HrDao;
import com.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ActiveDeactiveUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            int status = Integer.parseInt(request.getParameter("status"));
            String role = request.getParameter("role");
            
            if(status == 0){
                status = 1;
            }else if(status == 1){
                status = 0;
            }
            
            System.out.println(status);
            System.out.println(role);
            
            boolean activeDeactive = false;
            
            if(role.equalsIgnoreCase("Employee")){
                activeDeactive = activeDeactiveEmployeeAndUser(id, userId, status);
            }else{
                activeDeactive = activeDeactiveHrAndUser(id, userId, status);
            }
            
            
            if(activeDeactive){
                out.print("success");
            }else{
                out.print("failure");
            }
        }
    }

    private boolean activeDeactiveHrAndUser( int id,int userId, int status) {
        HrDao hrDao = new HrDao(ConnectionProvider.getConnection());
        
        if(hrDao.activeDeactiveHrUser(id, userId, status)){
            System.out.println(hrDao);
            return true;
        }
        return false;
    }
    
    private boolean activeDeactiveEmployeeAndUser(int id, int userId, int status) {
        EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());
        
        if(empDao.activeDeactiveEmpUser(id, userId, status)){
            return true;
        }
        return false;
    }
   
}
