<%@page import="java.sql.*,com.helper.ConnectionProvider,com.entities.Message" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>title</title>
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
        <link href="style/loginCss.css">
    </head>
    <body>
        <div class="container">
            <div class="row">

                <div class="col-md-6 offset-md-3 mt-2">
                    <%
                    Message m = (Message)session.getAttribute("msg");
                    if(m != null){
                    %>
                    <div class="alert <%= m.getCssClass() %> alert-dismissible fade show" role="alert">
                        <strong><%= m.getContent() %></strong>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                        
                    <% 
                       session.removeAttribute("msg");
                        } 
                    %>
                    <!--                    <h2 class="text-center text-dark">Login Form</h2>
                                        <div class="text-center mb-5 text-dark">Made with bootstrap</div>-->
                    <div class="card my-5">



                        <form class="card-body cardbody-color p-lg-5" action="LoginServlet" method="post">

                            <div class="text-center">
                                <img src="https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397__340.png" class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3"
                                     width="200px" alt="profile">
                            </div>

                            <div class="mb-3">
                                <input type="text" class="form-control" id="Username" name="userEmail" aria-describedby="emailHelp"
                                       placeholder="User Name" autocomplete="off">
                            </div>
                            <div class="mb-3">
                                <input type="password" class="form-control" name="password" id="password" placeholder="password">
                            </div>
                            <div class="text-center"><button type="submit" class="btn btn-color px-5 mb-5 w-100">Login</button></div>
                            <div id="emailHelp" class="form-text text-center mb-5 text-dark">Not
                                Registered? <a href="#" class="text-dark fw-bold"> Create an
                                    Account</a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>

