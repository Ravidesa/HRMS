<%@page import="java.sql.*,com.helper.ConnectionProvider"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Registration</title>
        <!-- Required meta tags -->
        <!-- <meta charset="utf-8"> -->
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


        <!-- Font -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans&family=Open+Sans&display=swap"
            rel="stylesheet">

        <!-- Css -->
        <link rel="stylesheet" href="style/style.css">
    </head>
    <body>
        
      

        <!-- Contact Us -->
        <section class="my-5">
            <div class="text-center">
                <h1>Registration Form</h1>
                <hr class="w-25 mx-auto">
            </div>

            <div class="container">
                <div class="row">
                    <!-- <div class="col-lg-6 col-md-6 col-xxl-6 col-12">
                            <figure>
                                    <img class="img-fluid">
                            </figure>
                    </div> -->
                    <div class="col-lg-8 col-md-8 col-12 col-xxl-8 mx-auto">
                        
                        <!-- onsubmit="return validation()" -->
                        <form id="form" action="Registration" method="post">
                            
                            <div class="mb-3 controlInput">
                                <label class="form-label">Enter name</label> 
                                <input type="text" class="form-control form-control-sm" id="LName" name="username" autocomplete="off">
                                <i class="fas fa-check-circle"></i>
                                <i class="fas fa-circle-exclamation"></i>
                                <span id="lnameError" class="text-danger"></span>
                            </div>
                            <div class="mb-3 controlInput">
                                <label class="form-label">Email address</label>
                                <input type="text" class="form-control form-control-sm" id="Email" name="email" aria-describedby="emailHelp" autocomplete="off">
                                <i class="fas fa-check-circle"></i>
                                <i class="fas fa-circle-exclamation"></i>
                                <span id="emailError" class="text-danger"></span>
                            </div>
                            <div class="mb-3 controlInput">
                                <label class="form-label">Password</label> 
                                <input type="text" class="form-control form-control-sm" name="password" id="Pass" autocomplete="off">
                                <i class="fas fa-check-circle"></i>
                                <i class="fas fa-circle-exclamation"></i>
                                <span id="passError" class="text-danger"></span>
                            </div>
                            <div class="mb-3 controlInput">
                                <label class="form-label">Confirm Password</label> 
                                <input type="text" class="form-control form-control-sm" id="Cpass" autocomplete="off">
                                <i class="fas fa-check-circle"></i>
                                <i class="fas fa-circle-exclamation"></i>
                                <span id="cpassError" class="text-danger"></span>
                            </div>
                            <div class="mb-3 controlInput">
                                <input type="hidden" class="form-control form-control-sm" id="role" name="role" value="EMPLOYEE" autocomplete="off">
                            </div>
                            <div class="mb-3 controlInput">
                                <label for="gender">Select Gender</label>
                                <br>
                                <input type="radio" id="gender" name="gender" value="male">Male
                                <input type="radio" id="gender" name="gender" value="female">Female
                            </div>
                            
                            <div class="d-flex flex-row-reverse">
                                <button type="submit" class="btn btn-outline-info "
                                        data-bs-toggle="tooltip" data-bs-placement="right"
                                        title="Heyy, Hii">Submit</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Contact US -->

        <footer class="bg-light text-center text-lg-start">

            <div class="text-center p-3"
                 style="background-color: rgba(0, 0, 0, 0.2);">
                © 2023 Copyright: <a class="text-dark"
                                     href="#">Under Ravi Desai</a>
            </div>

        </footer>

        <!-- Separate Popper and Bootstrap JS -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

<!--        <script>
            var fname = document.getElementById('FName');
            var lname = document.getElementById('LName');
            var phn = document.getElementById('Phn');
            var mail = document.getElementById('Email');
            var pass = document.getElementById('Pass');
            var cpass = document.getElementById('Cpass');
            var address = document.getElementById('Address');


            form.addEventListener('submit', (event) => {
                event.preventDefault();

                validate();
            })

            const isMail = (mailVal) => {
                var atSymbol = mailVal.indexOf("@");
                if (atSymbol < 1)
                    return false;

                var dot = mailVal.lastIndexOf('.');
                if (dot <= atSymbol + 2) {
                    return false;
                }

                if (dot === mailVal.length - 1) {
                    return false;
                }
                return true;
            }

            const sendData = (succ, count) => {
                if (succ + 1 === count) {
                    /* alert("registration Successfull"); */
                    location.href = `demo.jsp`;
                }
            }

            const successMsg = () => {
                let conInput = document.getElementsByClassName("controlInput");
                var count = conInput.length - 1;
                console.log(count);
                for (var i = 0; i < conInput.length - 1; i++) {
                    if (conInput[i].className === "controlInput success") {
                        var succ = 0 + i;
                        console.log(succ);
                        sendData(succ, count);
                    } else {
                        return false;
                    }
                }
            }

            const validate = () => {
                var fnameVal = fname.value.trim();
                var lnameVal = lname.value.trim();
                var phnVal = phn.value.trim();
                var mailVal = mail.value.trim();
                var passVal = pass.value.trim();
                var cpassVal = cpass.value.trim();
                var addressVal = address.value.trim();

                if (fnameVal === "") {
                    setErrorMsg(fname, "**First name cant'b be blank");
                } else if (fnameVal.length <= 2) {
                    setErrorMsg(fname, "**First name should have min 3 char")
                } else {
                    setSuccessMsg(fname);
                }

                if (lnameVal === "") {
                    setErrorMsg(lname, "**Last name cant'b be blank");
                } else if (lnameVal.length <= 2) {
                    setErrorMsg(lname, "**Last name should have min 3 char")
                } else {
                    setSuccessMsg(lname);
                }


                if (mailVal === "") {
                    setErrorMsg(mail, "**Email cant'b be blank");
                } else if (!isMail(mailVal)) {
                    setErrorMsg(mail, "**Not a Valid mail");
                } else {
                    setSuccessMsg(mail);
                }

                if (phnVal === "") {
                    setErrorMsg(phn, "**Phone no cant'b be blank");
                } else if (phnVal.length != 10) {
                    setErrorMsg(phn, "**Phone no should be 10 digit")
                } else {
                    setSuccessMsg(phn);
                }

                if (passVal === "") {
                    setErrorMsg(pass, "**Password cant'b be blank");
                } else if (passVal.length <= 4) {
                    setErrorMsg(pass, "**Password must be > 4")
                } else {
                    setSuccessMsg(pass);
                }

                if (cpassVal === "") {
                    setErrorMsg(cpass, "**Password cant'b be blank");
                } else if (passVal != cpassVal) {
                    setErrorMsg(cpass, "**password are not matching")
                } else {
                    setSuccessMsg(cpass);
                }

                if (addressVal === "") {
                    setErrorMsg(address, "**Address cant'b be blank");
                } else {
                    setSuccessMsg(address);
                }

                successMsg();
            }

            function setErrorMsg(input, errormegs) {
                const controlinput = input.parentElement;
                const span = controlinput.querySelector('span');
                controlinput.className = "controlInput error";
                span.innerText = errormegs;
            }

            function setSuccessMsg(input) {
                const controlinput = input.parentElement;
                controlinput.className = "controlInput success";
            }
        </script>-->
    </body>
</html>