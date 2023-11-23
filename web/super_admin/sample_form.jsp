
<%@include file="header.jsp" %>
<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>Add Sample User</h3>
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp" class="text-info">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Sample User</li>
                    </ol>
                </nav>
            </div>
        </div>

    </div>

 
    <!-- // Basic multiple Column Form section start -->
    <section id="multiple-column-form">
        <div class="row match-height">
            <div class="col-12">
                <div class="card">
                    <div class="card-content">
                        <div class="card-body">
                            <form class="form" id="addingUser" action="../JustCheck"  method="post">
                                <div class="row">
                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">First Name</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" id="fname" name="fname" placeholder="first name" id="first-name-icon" autocomplete="off">

                                                <div class="form-control-icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                            </div>
                                            <spam id="nameError"></spam>
                                        </div>
                                    </div>  
                                    
                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Last Name</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" id="lname" name="lname" placeholder="last name" id="first-name-icon" autocomplete="off">

                                                <div class="form-control-icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                            </div>
                                            <spam id="nameError"></spam>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Email</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" id="email" name="email" placeholder="email" id="first-name-icon" autocomplete="off">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-envelope"></i>
                                                </div>
                                            </div>
                                            <spam id="emailError"></spam>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Password</label>
                                            <div class="position-relative">
                                                <input type="password" class="form-control" id="password" name="password" placeholder="password" id="first-name-icon" autocomplete="off">

                                                <div class="form-control-icon">
                                                    <i class="fa fa-key"></i>
                                                </div>
                                            </div>
                                            <spam id="passError"></spam>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Gender</label>
                                            <div class="position-relative pt-2">
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" id="gender1" type="radio" name="gender" id="inlineRadio1" value="male">
                                                    <label class="form-check-label" for="inlineRadio1">Male</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" id="gender2" type="radio" name="gender" id="inlineRadio2" value="female">
                                                    <label class="form-check-label" for="inlineRadio2">Female</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">User Category</label>
                                            <div class="position-relative">
                                                <fieldset class="form-group">
                                                    <select class="form-select" name="role" aria-label="Default select example" style="width: 100%;right: 0px;top: 2;height: 39;">
                                                        <option selected disabled>Please select role</option>
                                                        <option value="Hr">HR</option>
                                                        <option value="employee">EMPLOYEE</option>
                                                    </select>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </div>

                                    <!--<input type="hidden" class="form-control" placeholder="employee id" id="empId" name="user_id_emp" readonly>-->

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Designation</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" placeholder="designatuion" name="designation" id="first-name-icon">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-hash"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Contact</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" placeholder="contact" name="contact" id="first-name-icon">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-phone-alt"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Date Of Birth</label>
                                            <div class="position-relative">
                                                <input type="date" class="form-control" placeholder="last name" name="dob" id="first-name-icon">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-birthday-cake"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

<!--                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Profile</label>
                                            <div class="position-relative">
                                                <input type="file" class="form-control" placeholder="" name="emp_image" accept="image/*">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>-->

                                    <div class="col-md-12 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Address</label>
                                            <textarea class="form-control" id="form7Example7" rows="4" name="address"></textarea>
                                        </div>
                                    </div>

                                    <div class="col-12 d-flex justify-content-end">
                                        <button id="submitButton" type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
                                    </div>
                                </div>
                            </form>
                                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- // Basic multiple Column Form section end -->
</div>

<!--<script>
    $(document).ready(function () {
        $("#submitButton").click(function (event) {
            event.preventDefault(); // Prevent form submission

            // Perform form validation
            if (validateForm()) {
                $("#addingUser").submit(); // Submit the form
            }
        });

        function validateForm() {
            
            //clear previoud one
             $("#nameError").text("");
             $("#emailError")
             
            // Retrieve form inputs
            
            var name = $("#name");
            var email = $("#email");
            var password = $("#password");
            var gender = $("input[name='gender']:checked");
            var role = $("#role");


            var nameVal = name.val().trim();
            var emailVal = email.val().trim();
            var passwordVal = password.val().trim();
            var genderVal = gender.val();
            var roleVal = role.val().trim();
            var isValid = true;
            // Validate name field

            if (nameVal === "") {
                $("#nameError").text("**Name can'b blank.").css('color', 'red');
                return false;
            }else if (nameVal.length <= 2) {
                $("#nameError").text("**Character must be greated then 2.").css('color', 'red');
                return false;
            }
            
            if(emailVal === "" ){
                $("#emailError").text("**Email can'b blank.").css('color', 'red');
                return false;
            }

            if (!genderVal) {
                $("#genderError").text("**Please select gender").css('color', 'red');
                isValid = false;
            }

          
            return true; // Return true if the form is valid
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
    });
</script>-->


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

<script>
    $(ready).document(function(){
        
        $(".msgOfSuc").fadeOut(1000);
    });
</script>

<%@include file="footer.jsp" %>