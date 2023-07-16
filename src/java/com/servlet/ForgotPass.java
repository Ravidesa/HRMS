/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.dao.UserDAO;
import com.entities.User;
import com.helper.ConnectionProvider;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebServlet("/JavaMail")
public class ForgotPass extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        final String senderEmail = "njram0210@gmail.com"; // Replace with your email address
        final String senderPassword = "ibmgrjmwcyqedfye"; // Replace with your email password
        final String recipientEmail = email; // Replace with the recipient's email address
        // SMTP server configuration
        Properties properties = new Properties();
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Replace with the desired protocol(s)
        properties.put("mail.smtp.ssl.ciphers", "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"); // Replace with the desired cipher suite(s)
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Replace with your SMTP server address
        properties.put("mail.smtp.port", "587"); // Replace with the appropriate port number
        properties.put("mail.smtp.ssl.trust", "*");
        // Create a session with authentication
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });
        try {
            
            HttpSession s = request.getSession();
            String pass = isValidCredentials(email);
            if (!pass.equals("not Found")) {
                String password = pass;
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(senderEmail)); // Set the sender's email address
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
                message.setSubject("your password");
                message.setText(password);
                // Send the email
                Transport.send(message);
//            response.getWriter().println("Email sent successfully.");
                com.entities.Message msg = new com.entities.Message("Email Successfully sent", "success", "alert-success");
                s.setAttribute("msg", msg);
                response.sendRedirect("check_mail.jsp");
            } else {
                com.entities.Message msg = new com.entities.Message("Email does't exist! please enter another email", "error", "alert-danger");
                s.setAttribute("msg", msg);
                response.sendRedirect("forgot_password.jsp");
            }
            // Create a new email message
            
        } catch (MessagingException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again later.");
        }
        
    }

    private String isValidCredentials(String userEmail) {
        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
        User u = dao.getUserPass(userEmail);
//        System.out.println(pass);
        if (u == null || !userEmail.equals(u.getEmail())) {
            System.out.println("login servlet page getting nullll");
            return "not Found";
        } else {
//            System.out.println("getting.....");
            return u.getPassword();
        }
    }
}
