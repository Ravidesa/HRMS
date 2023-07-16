<%@page import="java.sql.*,com.helper.ConnectionProvider,com.entities.Message" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Font Awesome  -->
        <script src="https://kit.fontawesome.com/59a8c3ce34.js" crossorigin="anonymous"></script>
        <!-- Bootstrap CSS -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous">


        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <style>
            .bsimg{
                display: flex;
                justify-content: center;
                align-items: center;
                padding-bottom: 43px
            }
            .divider:after,
            .divider:before {
                content: "";
                flex: 1;
                height: 1px;
                background: #eee;
            }
            .form-control{
                display: block;
                width: 100%;
                padding: 0.8rem 0.75rem;
                font-size: 0.875rem;
                font-weight: 400;
                line-height: 1.5;
                color: #131920;
            }
            .form-control:hover{
                background: #f8f9fa;
            }
        
            .btn-control:hover{
                background: #0853c1;
            }
            
            .texted{
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <section class="vh-100">
            <div class="h-100">
                <div class="row d-flex align-items-center">
                    <div class="col-md-4 col-lg-7 col-xl-6 ">
                        <!--<img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid" alt="alt"/>-->
                        <img src="images/forLogin.jpg" class="img-fluid" alt="alt" style="height: 770px;width: 100%"/>
                    </div>
                    <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1" style="margin-left: 21px;">

                        <%
                            Message m = (Message)session.getAttribute("msg");
                            if(m != null){
                        %>
                        <div id="alertMessage" class="alert <%= m.getCssClass() %> alert-dismissible fade show" style="position: relative;top: -123px;left: 455px;width: 220px;" role="alert">
                            <strong><%= m.getContent() %></strong>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>

                        <% 
                           session.removeAttribute("msg");
                            } 
                        %>
                        
                        <div class="bsimg" style="margin-bottom: 48px;padding-bottom: 0px;">
                            <img src="images/bstech.png" style="width: 29%;"/>
                        </div>

                        

                        <div class="d-flex align-items-center my-3 mb-5 divider">
                            <p class="text-muted fw-bold text-center" style="margin:5px;">Login via email</p>
                        </div>

                        <form action="LoginServlet" method="post">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="userEmail" style="border-radius: 5px;box-shadow: none;" autocomplete="off">
                                <label for="floatingInput">Email address</label>
                            </div>
                            <div class="form-floating">
                                <input type="password" class="form-control rounded-input" id="floatingPassword" placeholder="Password" name="password" style="border-radius: 5px;box-shadow: none;" autocomplete="off">
                                <label for="floatingPassword">Password</label>
                            </div>

                            <div class="d-flex justify-content-around align-items-center mt-4 mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="form1Example3" checked />
                                    <label class="form-check-label" for="form1Example3"> Remember me </label>
                                </div>
                                <a href="forgot_password.jsp" class="text-muted texted">Forgot password?</a>
                            </div>

                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-control" type="submit"style="border-radius: 30px;">Sign In</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>

        <script>
            $(document).ready(function () {
                $('#alertMessage').delay(1000).fadeOut();
            });
        </script>

    </body>
</html>
