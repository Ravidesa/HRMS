
<%@include file="header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.EmployeeDao,com.dao.DesignationDao" %>
<%@ page import="com.entities.Employee,com.entities.Designation,com.helper.GetDesignationOptions" %>
<%@ page import="com.dao.HrDao" %>
<%@ page import="com.entities.Hr" %>
<%@ page import="java.text.SimpleDateFormat" %>



<style>
    .gradient-custom {
        background: linear-gradient(to right bottom, rgb(202, 247, 255), rgb(28, 202, 255));
    }

</style>



<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-12 order-md-1 order-last">
                <h3>Manage Employee</h3>
            </div>
            <div class="col-12 col-md-12 order-md-2 order-first" style="padding-left: 14px;padding-bottom: 8px;">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb" style="justify-content: flex-start;padding-left: 0px;">
                        <li class="breadcrumb-item"><a href="index.jsp" class="text-info">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Manage Employee</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card">
            <div class="card-body">

                <div class="addButton" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <!--<a href="add_employee.jsp"><button class="btn btn-primary" style="width: 100px;">Add</button></a>-->
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#addEmployee" style="padding-left: 0.5rem;padding-right: 0.5rem;box-shadow: none">
                        <i class="fa fa-plus-circle text-success" aria-hidden="true" style="font-size: 33px; height: 30px;"></i>
                    </button>
                </div>

                <table class='table' id="table1" >

                    <%
                        Message m = (Message)session.getAttribute("msg");
                        if(m != null){
                    %>
                    <div id="magOfSuc" class="alert <%= m.getCssClass() %> alert-dismissible fade show" role="alert" style="width: 26%;position: absolute;top: -171px; right: -13px;">
                        <strong><%= m.getContent() %></strong>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>

                    <% 
                       session.removeAttribute("msg");
                        } 
                    %>
                    <thead>

                        <tr>
                            <th>Profile</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Designation</th>
                            <th>Contact</th>
                            <th>

                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:94px;">Joining Date</div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            Joining Date
                                        </p>
                                    </div>
                                </div>

                            </th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            EmployeeDao empDao = new EmployeeDao(ConnectionProvider.getConnection());
                            List<Employee> empList = empDao.getAllEmployee();
   
                            for(Employee emp : empList){
                                
                                byte[] imageData = emp.getEmp_image();
                                String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                            
                                java.sql.Timestamp createdAccountTimestamp = emp.getCreatedAccount();
                                java.util.Date createdAccountDate = new java.util.Date(createdAccountTimestamp.getTime());
                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                                String createdAccountDateStr = dateFormat.format(createdAccountDate);
                                
                                String designationOptions = GetDesignationOptions.getEmpDesignationOptions(emp.getDeg_id_emp());
                        %>
                        <tr>
                            <td style="padding: 0">
                                <!--data-bs-toggle="modal" data-bs-target="#employeeDetails"-->
                                <img src="data:image/png;base64,<%= base64Image%>" style="width: 40px;margin-left: 41px;" class="user-image" alt="alt"
                                     name="<%= emp.getId()%>" data-image-src="data:image/png;base64,<%= base64Image%>" data-fname="<%= emp.getFname() %>" 
                                     data-lname="<%= emp.getLname() %>" data-designation="<%= emp.getDegName() %>" data-contact="<%= emp.getContact()%>"
                                     data-dob="<%= createdAccountDateStr%>"  data-gender="<%= emp.getGender()%>" data-email="<%= emp.getEmail() %>"
                                     data-createdaccount="<%= createdAccountDateStr%>" data-address="<%= emp.getAddress()%>"
                                     data-bs-toggle="modal" data-bs-target="#employeeDetails"
                                     />
                            </td>
                            <td class="textTranform">

                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:70px;"><%= emp.getFname() +" "+ emp.getLname()%></div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            <%= emp.getFname() +" "+ emp.getLname()%>
                                        </p>
                                    </div>
                                </div>

                            </td>
                            <td>

                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:82px;"><%= emp.getEmail()%></div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            <%= emp.getEmail()%>
                                        </p>
                                    </div>
                                </div>

                            </td>

                            <td>

                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:70px;"><%=emp.getDegName()%></div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            <%=emp.getDegName()%>
                                        </p>
                                    </div>
                                </div>

                            </td>
                            <td>+91<%= emp.getContact()%></td>


                            <td><%= createdAccountDateStr%></td>

                            <td>

                                <%
                                    if(emp.getStatus() == 0){
                                %>
                                <a style="cursor: pointer" id="empDeactive" class="emp-active-deactive"
                                   name="<%= emp.getId()%>" data-useridemp="<%= emp.getUser_id_emp()%>"
                                   data-role="<%= emp.getRole()%>"
                                   data-status="<%= emp.getStatus()%>"
                                   data-username="<%= emp.getFname() + " " + emp.getLname()%>"
                                   >
                                    <i class="fa fa-ban text-danger"></i>
                                </a>
                                <% }else{ %>
                                <a style="cursor: pointer" id="empActive" class="emp-active-deactive"
                                   name="<%= emp.getId()%>" data-useridemp="<%= emp.getUser_id_emp()%>"
                                   data-role="<%= emp.getRole()%>"
                                   data-status="<%= emp.getStatus()%>"
                                   data-username="<%= emp.getFname() + " " + emp.getLname()%>"
                                   >
                                    <i class="fa fa-check-circle text-success" aria-hidden="true"></i>
                                </a>
                                <% } %>

                            </td>

                            <td style="padding-right: 0px;">
                                <a style="cursor: pointer;padding-right: 5px;" name="<%= emp.getId()%>" class="employeeEdit"
                                   data-image-src="data:image/png;base64,<%= base64Image%>" data-fname="<%= emp.getFname()%>"
                                   data-currentuserrole="<%= user.getRole()%>"
                                   data-lname="<%= emp.getLname()%>" data-designation="<%= emp.getDegName()%>"
                                   data-dob="<%= emp.getDob()%>"  data-gender="<%= emp.getGender()%>" data-email="<%= emp.getEmail()%>"
                                   data-createdaccount="<%= createdAccountDateStr%>" data-address="<%= emp.getAddress()%>"
                                   data-contact="<%= emp.getContact()%>" 
                                   data-useridemp="<%= emp.getUser_id_emp()%>" data-degidemp="<%= emp.getDeg_id_emp()%>"
                                   data-contact="<%= emp.getContact()%>" data-role="<%= emp.getRole()%>"
                                   data-getalldeg="<%= designationOptions%>"
                                   data-degname="<%= emp.getDegName()%>"
                                   data-bs-toggle="modal"  data-bs-target="#editEmployeeModal"><i class="fa fa-pen text-info"></i>
                                </a>

                                <a style="cursor: pointer;padding-right: 5px" id="employeeDelete" class="employee-delete"
                                   name="<%= emp.getId()%>" data-useridemp="<%= emp.getUser_id_emp()%>"
                                   data-username="<%= emp.getFname() + " " + emp.getLname()%>"
                                   >
                                    <i class="fa fa-trash text-danger"></i>
                                </a>



                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </section>
</div>


<!--modal-->

<!-- Modal employee details -->
<div class="modal fade" id="employeeDetails" style="display:none;">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="headerForDetails">  </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <!--                    <span aria-hidden="true">&times;</span>-->
                </button>
            </div>

            <div class="modal-body" id="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>
</div>

<!--Modal for add employee-->

<div class="modal fade" id="addEmployee" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">ADD EMPLOYEE</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="form" id="addingUser" action="../AddSampleUser"  enctype="multipart/form-data" method="post">
                    <div class="row">

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">First Name</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="fname" name="fname" placeholder="First Name" id="first-name-icon" autocomplete="off">
                                    <input type="hidden" name="currentRole" value="<%= user.getRole()%>" readonly>
                                    <div class="form-control-icon">
                                        <i class="fa fa-user"></i>
                                    </div>
                                </div>
                                <spam id="fnameError" class="errors text-danger"></spam>
                            </div>
                        </div>  

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Last Name</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="lname" name="lname" placeholder="Last Name" id="first-name-icon" autocomplete="off">

                                    <div class="form-control-icon">
                                        <i class="fa fa-user"></i>
                                    </div>
                                </div>
                                <spam id="lnameError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Email</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="email" name="email" placeholder="Email" id="first-name-icon" autocomplete="off">
                                    <div class="form-control-icon">
                                        <i class="fa fa-envelope"></i>
                                    </div>
                                </div>
                                <spam id="emailError" class="errors text-danger"></spam>
                            </div>
                        </div>
                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Password</label>
                                <div class="position-relative">
                                    <input type="password" class="form-control" id="pass" name="password" placeholder="Password" id="first-name-icon" autocomplete="off">

                                    <div class="form-control-icon">
                                        <i class="fa fa-key"></i>
                                    </div>
                                </div>
                                <spam id="passError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Gender</label>
                                <div class="position-relative pt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" id="gender1" type="radio" name="gender" id="inlineRadio1" value="Male">
                                        <label class="form-check-label" for="inlineRadio1">Male</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" id="gender2" type="radio" name="gender" id="inlineRadio2" value="Female">
                                        <label class="form-check-label" for="inlineRadio2">Female</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" id="gender3" type="radio" name="gender" id="inlineRadio3" value="other">
                                        <label class="form-check-label" for="inlineRadio3">Other</label>
                                    </div>
                                </div>
                                <spam id="genderError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <input type="hidden" name="role" value="EMPLOYEE" readonly/>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Designation</label>
                                <div class="position-relative">
                                    <fieldset class="form-group">
                                        <select class="form-select" name="designation" aria-label="Default select example" style="width: 100%;right: 0px;bottom: -39px;">

                                            <%
                                                DesignationDao degDao = new DesignationDao(ConnectionProvider.getConnection());
                                                List<Designation> degList = degDao.getEmpAllDesignation();
                                 
                                                for(Designation deg : degList){
                                            %>
                                            <option value="<%= deg.getId()%>"><%= deg.getName()%></option>
                                            <!--<option value="EMPLOYEE">EMPLOYEE</option>-->
                                            <% } %>
                                        </select>
                                    </fieldset>
                                </div>
                            </div>
                        </div>

                        <!--<input type="hidden" class="form-control" placeholder="employee id" id="empId" name="user_id_emp" readonly>-->



                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Contact</label>
                                <div class="position-relative input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">+91</span>
                                    </div>
                                    <input type="text" class="form-control" placeholder="Contact" name="contact" id="contact" style="padding-left:5px;">

                                </div>

                                <spam id="contactError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Date Of Birth</label>
                                <div class="position-relative">
                                    <input type="date" class="form-control" placeholder="Date Of Birth" name="dob" id="dob">
                                    <div class="form-control-icon">
                                        <i class="fa fa-birthday-cake"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Profile</label>
                                <div class="position-relative">
                                    <input type="file" class="form-control" placeholder="" name="emp_image" accept="image/*">
                                    <div class="form-control-icon">
                                        <i class="fa fa-user"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Address line 1*</label>
                                <textarea class="form-control" placeholder="Address line 1" id="address1" rows="1" name="address1" style="padding-left: 6px;padding-right: 6px;"></textarea>
                            </div>
                            <spam id="add1Error" class="errors text-danger"></spam>
                        </div>
                        
                        <div class="col-md-12 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Address line 2 (optional)</label>
                                <textarea class="form-control" placeholder="Address line 2" id="address2" rows="1" name="address2" style="padding-left: 6px;padding-right: 6px;"></textarea>
                            </div>
                            
                        </div>
                        
                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">State</label>
                                <div class="position-relative">
                                    <input type="text" id="state" class="form-control" name="state" placeholder="State" style="padding-left: 10px;"/>
                                </div>
                                <spam id="stateError" class="errors text-danger"></spam>
                            </div>
                            
                        </div>
                                        
                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">City</label>
                                <div class="position-relative">
                                    <input type="text" id="city" class="form-control" name="city" placeholder="City" style="padding-left: 10px;" />
                                </div>
                                <spam id="cityError" class="errors text-danger"></spam>
                            </div>
                        </div>  
                                
                        <input type="hidden" class="form-control" id="address" name="address" readonly>

                        <div class="col-12 d-flex justify-content-end">
                            <button id="submitAddButton" type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--end of add employee modal-->


<!-- Modal of Edit Employee -->
<div class="modal fade" id="editEmployeeModal" style="display:none;">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="headeForEdit">  </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <!--                    <span aria-hidden="true">&times;</span>-->
                </button>
            </div>
            <div id="startHere">

            </div>
        </div>
    </div>
</div>
<!--end of edit employee modal-->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<!--date of birth-->
<script>
    $(document).ready(function() {
    // Get the current date
var today = new Date();

// Format the current date to the required format (YYYY-MM-DD)
var year = today.getFullYear();
var month = String(today.getMonth() + 1).padStart(2, "0");
var day = String(today.getDate()).padStart(2, "0");
var formattedDate = year + "-" + month + "-" + day;

// Set the max attribute of the date input field
document.getElementById("dob").setAttribute("max", formattedDate);
});
</script>

<!--concating address-->
<script>
    $(document).ready(function() {
    // Update concatenated address whenever any of the inputs change
    $('#state, #city, #address1, #address2').on('input', function() {
        var state = $('#state').val();
        var city = $('#city').val();
        var address1 = $('#address1').val();
        var address2 = $('#address2').val();
        
        var concatenatedAddress;
        if(address2 === ''){
            concatenatedAddress = address1 + ', ' + city + ', ' + state;
        }else{
            concatenatedAddress = address1 + ', ' + address2 + ', ' + city + ', ' + state;
        }
        
        $('#address').val(concatenatedAddress);
    });
});
</script>

<script>

    $(document).ready(function () {
                        $(".user-image").click(function () {
                            var empId = parseInt($(this).attr("name"));
//            alert("Id " + empId);
                            console.log("imageclick");
                            var imageSrc = $(this).data("image-src");
                            var fname = $(this).data("fname");
                            var lname = $(this).data("lname");
                            var designation = $(this).data("designation");
                            var dob = $(this).data("dob");
                            var gender = $(this).data("gender");
                            var email = $(this).data("email");
                            var contact = $(this).data("contact");
                            var createdAccount = $(this).data("createdaccount");
                            var address = $(this).data("address");

                            $("#headerForDetails").text(fname + " " + lname);

                            var modalContent = "<section class='vh-50' style='background-color: #f4f5f7;'><div class='container py-4 h-100'>";
                            modalContent += "<div class='row d-flex justify-content-center align-items-center h-100'><div class='col col-lg-12 mb-4 mb-lg-0' style='padding-left: 0px;padding-right: 0px;'>";
                            modalContent += "<div class='card mb-3' style='border-radius: .5rem;'><div class='row g-0'>";

                            modalContent += "<div class='col-md-4 gradient-custom text-center text-white' style='border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;'>";
                            modalContent += "<img src='" + imageSrc + "' alt='Avatar' class='img-fluid my-5' style='width: 38%;' />";
                            modalContent += "<h5>" + fname + " " + lname + "</h5>";
                            modalContent += "<p>" + designation + "</p>";
                            modalContent += "</div>";

                            modalContent += "<div class='col-md-8'><div class='card-body p-4'>";
                            modalContent += "<h6>Information</h6>";

                            modalContent += "<hr class='mt-0 mb-4'><div class='row pt-1'>";

                            modalContent += "<div class='col-6 mb-3'><h6>Email</h6>";
                            modalContent += "<p class='text-muted'>" + email + "</p></div>";

                            modalContent += "<div class='col-6 mb-3'><h6>Phone</h6>";
                            modalContent += "<p class='text-muted'>+91" + contact + "</p></div>";

                            modalContent += "<div class='col-6 mb-3'><h6>Birthday</h6>";
                            modalContent += "<p class='text-muted'>" + dob + "</p></div>";

                            modalContent += "<div class='col-6 mb-3'><h6>Gender</h6>";
                            modalContent += "<p class='text-muted'>" + gender + "</p></div>";

                            modalContent += "<div class='col-6 mb-6'><h6>Address</h6>";
                            modalContent += "<p class='text-muted'>" + address + "</p></div>";
                            
                            modalContent += "<div class='col-6 mb-6'><h6>Joining Date</h6>";
                            modalContent += "<p class='text-muted'>" + createdAccount + "</p></div>";

                            modalContent += "</div></div></div>";
                            modalContent += "</div></div></div></div></div></section>";

                            $("#modal-body").html(modalContent);
                            showModal();
                        });

                        $("#magOfSuc").delay(1000).fadeOut();

                        $(".employeeEdit").click(function () {
                            var empId = parseInt($(this).attr("name"));
                            var imageSrc = $(this).data("image-src");
                            var fname = $(this).data("fname");
                            var lname = $(this).data("lname");
                            var gender = $(this).data("gender");
                            var email = $(this).data("email");
                            var address = $(this).data("address");
                            var contact = $(this).data("contact");
                            var userIdEmp = parseInt($(this).data("useridemp"));
                            var role = $(this).data("role");

                            var currentuserrole = $(this).data("currentuserrole");
                            var degName = $(this).data("degname");

                            var degidemp = $(this).data("degidemp");
                            var getalldeg = $(this).data("getalldeg");

                            $("#headeForEdit").text(fname + " " + lname);


                            var modalContent = "<form class='form' id='editUser' action='../UpdateUser' enctype='multipart/form-data' method='post'>";
                            modalContent += "<section class='vh-50' style='background-color: #f4f5f7;'>";
                            modalContent += "<div class='container'><div class='row d-flex justify-content-center align-items-center h-100'>";
                            modalContent += "<div class='col col-lg-12 mb-4 mb-lg-0' style='padding-left: 0px;padding-right: 0px;'><div class='card mb-3' style='border-radius: .5rem;'>";
                            modalContent += "<div class='row g-0'>";

                            modalContent += "<div class='col-md-4 gradient-custom text-center text-white' style='border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;'>";
                            modalContent += "<img src='" + imageSrc + "' alt='Avatar' class='img-fluid my-5' style='width: 68%;' />";
                            modalContent += "<h5 class='textTranform'>" + fname + " " + lname + "</h5>";
                            modalContent += "<p class='text-muted'>" + degName + "</p>";
                            modalContent += "</div>";

                            modalContent += "<div class='col-md-8'><div class='card-body p-4'><h6>Information</h6><hr class='mt-0 mb-4'><div class='row pt-1'>";


                            modalContent += "<div class='col-6 mb-3'>";
                            modalContent += "<h6>First Name</h6>";
                            modalContent += "<input type='text' class='form-control textTranform' name='fname' value='" + fname + "'>";
                            modalContent += "<input type='hidden' class='form-control' id='degIdEmp' name='degIdEmp' value='" + degidemp + "' readonly>";
                            modalContent += "<input type='hidden' class='form-control' id='empId' name='empId' value='" + empId + "' readonly>";
                            modalContent += "<input type='hidden' class='form-control' id='userId' name='userIdEmp' value='" + userIdEmp + "' readonly>";
                            modalContent += "<input type='hidden' class='form-control' id='role' name='role' value='" + role + "' readonly>";
                            modalContent += "<input type='hidden' class='form-control' id='currentrole' name='currentRole' value='" + currentuserrole + "' readonly>";
                            modalContent += "</div>";

                            modalContent += "<div class='col-6 mb-3'>";
                            modalContent += "<h6>Last Name</h6>";
                            modalContent += "<input type='text' class='form-control textTranform' name='lname' value='" + lname + "'>";
                            modalContent += "</div>";



                            modalContent += "<div class='col-6 mb-3'>";
                            modalContent += "<h6>Email</h6>";
                            modalContent += "<input type='text' class='form-control' name='email' value='" + email + "'>";
                            modalContent += "</div>";

                            modalContent += "<div class='col-6 mb-4'>";
                            modalContent += "<h6>Phone</h6>";
                            modalContent += "<div class='input-group'>";
                            modalContent += "<div class='input-group-prepend'>";
                            modalContent += "<span class='input-group-text'>+91</span>";
                            modalContent += "</div>";
                            modalContent += "<input type='text' class='form-control' name='contact' value='" + contact + "'>";
                            modalContent += "</div>";
                            modalContent += "</div>";


                            modalContent += "<div class='col-md-6 mb-3'><h6>Gender</h6><div class='form-group has-icon-left'><div class='position-relative pt-2'>";
                            modalContent += "<div class='form-check form-check-inline'>";
                            modalContent += "<input class='form-check-input' id='gender1' type='radio' name='gender' id='inlineRadio1' value='Male'";
                            if (gender === "Male") {
                                modalContent += " checked ";
                            }
                            modalContent += ">";
                            modalContent += "<label class='form-check-label' for='inlineRadio1'>Male</label></div>";

                            modalContent += "<div class='form-check form-check-inline'>";
                            modalContent += "<input class='form-check-input' id='gender2' type='radio' name='gender' id='inlineRadio2' value='Female'";
                            if (gender === "Female") {
                                modalContent += " checked ";
                            }
                            modalContent += ">";
                            modalContent += "<label class='form-check-label' for='inlineRadio2'>Female</label></div>";

                            modalContent += "<div class='form-check form-check-inline'>";
                            modalContent += "<input class='form-check-input' id='gender3' type='radio' name='gender' id='inlineRadio3' value='Other'";
                            if (gender === "Other") {
                                modalContent += " checked ";
                            }
                            modalContent += ">";
                            modalContent += "<label class='form-check-label' for='inlineRadio3'>Other</label></div>";
                            modalContent += "</div><spam id='genderError' class='errors text-danger'></spam></div></div>";


                            modalContent += "<div class='col-md-6 mb-3'><div class='form-group has-icon-left'>";
                            modalContent += "<label for='first-name-icon'>Designation</label>";
                            modalContent += "<div class='position-relative'>";
                            modalContent += "<fieldset class='form-group'><select onchange='updateDesignationName()' class='form-select' name='selectdesignation' id='selectdesignation' aria-label='Default select example' style='width: 100%;right: 0px;bottom: unset;'>";
                            modalContent += getalldeg;
                            modalContent += "</select></fieldset></div></div></div>";

                            modalContent += "<div class='col-md-12 mb-6'><div class='form-group has-icon-left'>";
                            modalContent += "<label for='first-name-icon'>Profile</label>";
                            modalContent += "<div class='position-relative'>";
                            modalContent += "<input type='file' class='form-control' name='emp_image' accept='image/*'>";
                            modalContent += "<div class='form-control-icon'><i class='fa fa-user'></i></div></div></div></div>";

                            modalContent += "<div class='col-md-12 col-12'><div class='form-group has-icon-left'>";
                            modalContent += "<label for='first-name-icon'>Address</label>";
                            modalContent += "<textarea class='form-control' id='address' rows='4' name='address' style='padding-left: 6px;padding-right: 6px;'>" + address + "</textarea></div></div>";



                            modalContent += "</div><div class='d-flex justify-content-end'>";
                            modalContent += "<button type='button' class='btn btn-warning' data-bs-dismiss='modal' style='margin-right: 6px;'>Close</button>";
                            modalContent += "<button type='submit' id='edit-profile-button' class='btn btn-primary'> Save</button>";
                            modalContent += "</div></div></div>";

                            modalContent += "</div></div></div></div></div></section></form>";



                            $("#startHere").html(modalContent);
                            showEditModal();
                        });

                        $(".emp-active-deactive").click(function () {
                            var id = parseInt($(this).attr("name"));
                            var userId = parseInt($(this).data("useridemp"));
                            var role = $(this).data("role");
                            var status = parseInt($(this).data("status"));
                            var username = $(this).data("username");
                            var checkStatus = "";
                            if (status === 0) {
                                checkStatus = "Deactive";
                            } else if (status === 1) {
                                checkStatus = "Active";
                            }
//            alert(empId);
                            Swal.fire({
                                icon: 'warning',
                                title: 'Confirm ' + checkStatus,
                                text: 'Are you sure you want to ' +checkStatus+' '+username+' ?',
                                showCancelButton: true,
                                confirmButtonColor: '#d33',
                                cancelButtonColor: '#3085d6',
                                confirmButtonText: checkStatus,
                                cancelButtonText: 'Cancel'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // Send AJAX request to delete employee
                                    $.ajax({
                                        url: '../ActiveDeactiveUserServlet',
                                        type: 'POST',
                                        data: {
                                            id: id,
                                            userId: userId,
                                            role: role,
                                            status: status
                                        },
                                        success: function (response) {
                                            if (response === 'success') {
                                                Swal.fire({
                                                    icon: 'success',
                                                    title: 'Success',
                                                    text: 'Hr ' + checkStatus + '.',
                                                    onClose: function () {
                                                        location.reload(); // Refresh the page
                                                    }
                                                });
                                            } else {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'could not be ' + checkStatus + '.'
                                                });
                                            }
                                        },
                                        error: function () {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Error',
                                                text: 'An error occurred while ' + checkStatus + ' the hr.'
                                            });
                                        }
                                    });
                                }
                            });
                        });

                        $(".employee-delete").click(function () {
                            var empId = parseInt($(this).attr("name"));
                            var userIdEmp = parseInt($(this).data("useridemp"));
                            var username = $(this).data("username");
//            alert(empId);
                            Swal.fire({
                                icon: 'warning',
                                title: 'Confirm Delete',
                                text: 'Are you sure you want to Delete '+username+'?',
                                showCancelButton: true,
                                confirmButtonColor: '#d33',
                                cancelButtonColor: '#3085d6',
                                confirmButtonText: 'Delete',
                                cancelButtonText: 'Cancel'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // Send AJAX request to delete employee
                                    $.ajax({
                                        url: '../DeleteEmployeeServlet',
                                        type: 'POST',
                                        data: {
                                            empId: empId,
                                            userIdEmp: userIdEmp
                                        },
                                        success: function (response) {
                                            if (response === 'success') {
                                                Swal.fire({
                                                    icon: 'success',
                                                    title: 'Success',
                                                    text: 'Employee Deleted.',
                                                    onClose: function () {
                                                        location.reload(); // Refresh the page
                                                    }
                                                });
                                            } else {
                                                Swal.fire({
                                                    icon: 'error',
                                                    title: 'Error',
                                                    text: 'could not be deleted.'
                                                });
                                            }
                                        },
                                        error: function () {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Error',
                                                text: 'An error occurred while deleteing the employee.'
                                            });
                                        }
                                    });
                                }
                            });
                        });
                    });                

                    function showModal() {
                        $("#employeeDetails").show();
                    }

                    function closeModal() {
                        $("#employeeDetails").hide();
                    }

                    function showEditModal() {
                        $("#editEmployeeModal").show();
                    }

                    function closeEditModal() {
                        $("#editEmployeeModal").show();
                    }

</script>

<script>
    function updateDesignationName() {
        var dropdown = document.getElementById("selectdesignation");

        var designationId = document.getElementById("degIdEmp");

        var selectedOption = dropdown.options[dropdown.selectedIndex];
        var selectedDesignationId = selectedOption.value;

        designationId.value = selectedDesignationId;
    }
</script>


<!--validation-->
<!--<script>
    $(document).ready(function () {
        // Function to validate the form
        $("#submitAddButton").click("submit", function (e) {
            e.preventDefault();

            // Clear error messages
            $('.errors').text('');


            // Validate First Name
            var firstName = $('#fname').val().trim();
            if (firstName === '') {
                $('#fnameError').text('Please enter first name');
//                return;
            } else if (!isValidAlphabetic(firstName)) {
                $('#fnameError').text('First name should contain only alphabets');
//                return;
            }

            // Validate Last Name
            var lastName = $('#lname').val().trim();
            if (lastName === '') {
                $('#lnameError').text('Please enter last name');
//                return;
            } else if (!isValidAlphabetic(lastName)) {
                $('#lnameError').text('Last name should contain only alphabets');
//                return;
            }

            // Validate Email
            var email = $('#email').val().trim();
            if (email === '') {
                $('#emailError').text('Please enter email');
//                return;
            } else if (!isValidEmail(email)) {
                $('#emailError').text('Please enter a valid email');
//                return;
            }

            // Validate Password
            var password = $('#pass').val().trim();
            if (password === '') {
                $('#passError').text('Please enter password');
//                return;
            }

            // Validate Gender
            var gender = $('input[name="gender"]:checked').val();
            if (!gender) {
                $('#genderError').text('Please select gender');
//                return;
            }

            var designation = $('select[name="designation"]').val();
            if (designation === null || designation === "") {
                $('#designationError').text('Please select a designation');
//                return;
            }


            // Validate Contact
            var contact = $('#contact').val().trim();
            if (contact === '') {
                $('#contactError').text('Please enter contact');
//                return;
            } else if (!isValidNumber(contact)) {
                $('#contactError').text('Please enter a valid contact number');
//                return;
            } else if (contact.length !== 10)
            {
                $('#contactError').text('Contact number should be of 10 digits');
//                return;
            }

            // Validate Address
            var address = $('#address').val().trim();
            if (address === '') {
                $('#addError').text('Please enter address');
                return;
            }

            $('#addingUser').unbind('submit').submit();
        });

        // Email validation helper function
        function isValidEmail(email) {
            // Use a regular expression to validate email format
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailPattern.test(email);
        }

        // Contact number validation helper function
        function isValidNumber(number) {
            // Use a regular expression to validate number format
            var numberPattern = /^[0-9]+$/;
            return numberPattern.test(number);
        }
        function isValidAlphabetic(value) {
            // Use a regular expression to validate alphabetic characters only
            var alphabeticPattern = /^[A-Za-z]+$/;
            return alphabeticPattern.test(value);
        }

        $('#addEmployee').on('hidden.bs.modal', function () {
            $('#addingUser')[0].reset();
            $('.errors').text('');
        });

    });
</script>-->


<!--validation-->
<script>
    $(document).ready(function () {
        // Function to validate the form
        $("#submitAddButton").click("submit", function (e) {
            e.preventDefault();
            var errors = [];
            // Clear error messages
            $('.errors').text('');


            // Validate First Name
            var firstName = $('#fname').val().trim();
            if (firstName === '') {
                errors.push('Please enter first name');
                $('#fnameError').text('Please enter first name');
//                return;
            } else if (!isValidAlphabetic(firstName)) {
                errors.push('Please enter first name');
                $('#fnameError').text('First name should contain only alphabets');
//                return;
            }

            // Validate Last Name
            var lastName = $('#lname').val().trim();
            if (lastName === '') {
                errors.push('Please enter first name');
                $('#lnameError').text('Please enter last name');
//                return;
            } else if (!isValidAlphabetic(lastName)) {
                errors.push('Please enter first name');
                $('#lnameError').text('Last name should contain only alphabets');
//                return;
            }

            // Validate Email
            var email = $('#email').val().trim();
            if (email === '') {
                errors.push('Please enter first name');
                $('#emailError').text('Please enter email');
//                return;
            } else if (!isValidEmail(email)) {
                errors.push('Please enter first name');
                $('#emailError').text('Please enter a valid email');
//                return;
            }

            // Validate Password
            var password = $('#pass').val().trim();
            if (password === '') {
                errors.push('Please enter first name');
                $('#passError').text('Please enter password');
//                return;
            }

            // Validate Gender
            var gender = $('input[name="gender"]:checked').val();
            if (!gender) {
                errors.push('Please enter first name');
                $('#genderError').text('Please select gender');
//                return;
            }

            var designation = $('select[name="designation"]').val();
            if (designation === null || designation === "") {
                errors.push('Please enter first name');
                $('#designationError').text('Please select a designation');
//                return;
            }


            // Validate Contact
            var contact = $('#contact').val().trim();
            if (contact === '') {
                errors.push('Please enter first name');
                $('#contactError').text('Please enter contact');
//                return;
            } else if (!isValidNumber(contact)) {
                errors.push('Please enter first name');
                $('#contactError').text('Please enter a valid contact number');
//                return;
            } else if (contact.length !== 10)
            {
                errors.push('Please enter first name');
                $('#contactError').text('Contact number should be of 10 digits');
//                return;
            }
            
            var address1 = $('#address1').val().trim();
            if (address1 === '') {
                errors.push('Please enter address line1');
                $('#add1Error').text('Please enter address');
                
            }
            
            var state = $('#state').val().trim();
            if (state === '') {
                errors.push('Please enter State');
                $('#stateError').text('Please enter state');
            }
            
            var city = $('#city').val().trim();
            if (city === '') {
                errors.push('Please enter city');
                $('#cityError').text('Please enter city');
                
            }


            if (errors.length > 0) {
//                alert(errors.join('\n'));
            } else{
                $('#addingUser').unbind('submit').submit();
            }

            
        });

        // Email validation helper function
        function isValidEmail(email) {
            // Use a regular expression to validate email format
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailPattern.test(email);
        }

        // Contact number validation helper function
        function isValidNumber(number) {
            // Use a regular expression to validate number format
            var numberPattern = /^[0-9]+$/;
            return numberPattern.test(number);
        }
        function isValidAlphabetic(value) {
            // Use a regular expression to validate alphabetic characters only
            var alphabeticPattern = /^[A-Za-z]+$/;
            return alphabeticPattern.test(value);
        }

        $('#addEmployee').on('hidden.bs.modal', function () {
            $('#addingUser')[0].reset();
            $('.errors').text('');
        });

    });
</script>
<%@include file="footer.jsp" %>
