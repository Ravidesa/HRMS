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
                padding-bottom: 14px
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
            .fontSize{
                font-size: 20px;
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
                        <img src="images/forLogin.jpg" class="img-fluid" alt="alt" style="height: 770px;width: 100%"/>
                    </div>
                    <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1" style="margin-left: 21px;">

                        <%
                            Message m = (Message)session.getAttribute("msg");
                            if(m != null){
                        %>
                        <div id="alertMessage" class="alert <%= m.getCssClass() %> alert-dismissible fade show" role="alert">
                            <strong><%= m.getContent() %></strong>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>

                        <% 
                           session.removeAttribute("msg");
                            } 
                        %>
                        
                        <div class="bsimg d-flex justify-content-start">
                            <img src="images/bstech.png" style="width: 29%;"/>
                        </div>


                        <div class="mb-1">
                            <p class="text-muted fw-bold fa-2x" style="margin-bottom: 0;">Hi, Check Your Mail</p>
                            <p>We have sent a password to your email.</p>
                        </div>
                        
                        <div class="d-flex align-items-center my-3 mb-3 divider">
                            <p class="text-muted fw-bold text-center fa-1x" style="margin:5px;">Log in</p>
                        </div>
                        
                        <form method="post">

                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-control" type="submit"style="border-radius: 30px;">Sign in</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
