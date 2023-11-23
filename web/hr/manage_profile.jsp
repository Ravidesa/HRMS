<%@include file="header.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="com.dao.HrDao,com.dao.DesignationDao" %>
<%@ page import="com.entities.Hr,com.entities.Designation,com.helper.GetDesignationOptions,com.helper.ConnectionProvider" %>
<%@ page import="java.text.SimpleDateFormat" %>

<style>
    .gradient-custom {
        background: linear-gradient(to right bottom, rgb(255, 255, 255), rgb(255, 255, 255));
    }
</style>

<%
    Message m = (Message)session.getAttribute("msg");
    if(m != null){
%>
<div id="magOfSuc" class="alert <%= m.getCssClass() %> alert-dismissible fade show" role="alert" style="position: absolute;width: 17%;right: 29px;top: 13px;">
    <strong><%= m.getContent() %></strong>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% 
        session.removeAttribute("msg");
    } 
%>


<%
    HrDao hrDao = new HrDao(ConnectionProvider.getConnection());
    Hr hr = hrDao.getHr(user.getId());
//    out.println(hr.getHr_image().toString());
//out.println(hr);
    
    byte[] imageData = hr.getHr_image();
    String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);

    java.sql.Timestamp createdAccountTimestamp = hr.getCreatedAccount();
    java.util.Date createdAccountDate = new java.util.Date(createdAccountTimestamp.getTime());
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    String createdAccountDateStr = dateFormat.format(createdAccountDate);

    
    java.util.Date DateOfBirth = hr.getDob();
    String dob = dateFormat.format(DateOfBirth);
    String designationOptions = GetDesignationOptions.getHrDesignationOptions(hr.getDeg_id_hr());
%>

<section class="vh-50" style="background-color: #f4f5f7;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-lg-12 mb-4 mb-lg-0">
                <div class="card mb-3" style="border-radius: .5rem;">
                    <div class="row g-0">
                        <div class="col-md-4 gradient-custom text-center text-white"
                             style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                            <img src="data:image/png;base64,<%= base64Image%>"
                                 alt="Avatar" class="img-fluid my-5" style="width: 38%;" />
                            <h5><%= hr.getFname() +" "+ hr.getLname() %></h5>
                            <p><%= hr.getDegName()%></p>
                            <a style="cursor: pointer;color: white" name="<%= hr.getId()%>" class="editPersonal"
                               data-image-src="data:image/png;base64,<%= base64Image%>" data-fname="<%= hr.getFname()%>"
                               data-lname="<%= hr.getLname()%>" data-email="<%= hr.getEmail()%>"
                               data-gender="<%= hr.getGender()%>" data-address="<%= hr.getAddress()%>"
                               data-createdaccount="<%= createdAccountDateStr%>" 
                               data-contact="<%= hr.getContact()%>" 
                               data-useridhr="<%= hr.getUser_id_hr()%>" data-degidhr="<%= hr.getDeg_id_hr()%>"
                               data-getalldeg="<%= designationOptions%>" data-degname="<%= hr.getDegName()%>"
                               data-currentuserrole="<%= user.getRole()%>"
                               data-bs-toggle="modal"  data-bs-target="#editProfileModal"><i class="far fa-edit mb-5"></i>
                            </a>

                        </div>
                        <div class="col-md-8">
                            <div class="card-body p-4">
                                <h6>Information</h6>
                                <hr class="mt-0 mb-4">
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <h6>Email</h6>
                                        <p class="text-muted"><%= hr.getEmail()%></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>Phone</h6>
                                        <p class="text-muted"><%= hr.getContact()%></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>Birthday</h6>
                                        <p class="text-muted"><%= dob%></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>Gender</h6>
                                        <p class="text-muted"><%= hr.getGender()%></p>
                                    </div>
                                    <div class="col-6 mb-6">
                                        <h6>Address</h6>
                                        <p class="text-muted"><%= hr.getAddress()%></p>
                                    </div>
                                    <div class="col-6 mb-6">
                                        <h6>Joining Date</h6>
                                        <p class="text-muted"><%= createdAccountDateStr%></p>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Edit Modal -->
<div class="modal fade" id="editProfileModal" style="display:none;">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel"> Edit Personal Information </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

                </button>
            </div>

            <div class="modal-body" id="startHere">
                <!--edit from here-->

            </div>
        </div>
    </div>
</div>
<!--end edit modal-->

<script>

    $(document).ready(function () {

        $("#magOfSuc").delay(1000).fadeOut();

        $(".editPersonal").click(function () {
            var empId = parseInt($(this).attr("name"));
            var userIdEmp = parseInt($(this).data("useridhr"));
            var degidemp = $(this).data("degidhr");

            var fname = $(this).data("fname");
            var lname = $(this).data("lname");
            var email = $(this).data("email");
            var contact = $(this).data("contact");
            var gender = $(this).data("gender");
            var imageSrc = $(this).data("image-src");
            var address = $(this).data("address");
            var currentuserrole = $(this).data("currentuserrole");

            var degName = $(this).data("degname");
            var getalldeg = $(this).data("getalldeg");

            var modalContent = "<form class='form' id='editUser' action='../ManageProfile' enctype='multipart/form-data' method='post'>";
            modalContent += "<section class='vh-50' style='background-color: #f4f5f7;'>";
            modalContent += "<div class='container'><div class='row d-flex justify-content-center align-items-center h-100'>";
            modalContent += "<div class='col col-lg-12 mb-4 mb-lg-0' style='padding-left: 0px;padding-right: 0px;'><div class='card mb-3' style='border-radius: .5rem;'>";
            modalContent += "<div class='row g-0'>";

            modalContent += "<div class='col-md-4 gradient-custom text-center text-white' style='border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;'>";
            modalContent += "<img src='" + imageSrc + "' alt='Avatar' class='img-fluid my-5' style='width: 68%;' />";
            modalContent += "<h5>" + fname + " " + lname + "</h5>";
            modalContent += "<p>" + degName + "</p>";
            modalContent += "</div>";

            modalContent += "<div class='col-md-8'><div class='card-body p-4'><h6>Information</h6><hr class='mt-0 mb-4'><div class='row pt-1'>";


            modalContent += "<div class='col-6 mb-3'>";
            modalContent += "<h6>First Name</h6>";
            modalContent += "<input type='text' class='form-control' name='fname' value='" + fname + "'>";
            modalContent += "<input type='hidden' class='form-control' id='degIdEmp' name='degIdEmp' value='" + degidemp + "' readonly>";
            modalContent += "<input type='hidden' class='form-control' id='empId' name='empId' value='" + empId + "' readonly>";
            modalContent += "<input type='hidden' class='form-control' id='userId' name='userId' value='" + userIdEmp + "' readonly>";
            modalContent += "<input type='hidden' class='form-control' id='currentrole' name='currentRole' value='" + currentuserrole + "' readonly>";
            modalContent += "</div>";

            modalContent += "<div class='col-6 mb-3'>";
            modalContent += "<h6>Last Name</h6>";
            modalContent += "<input type='text' class='form-control' name='lname' value='" + lname + "'>";
            modalContent += "</div>";



            modalContent += "<div class='col-6 mb-3'>";
            modalContent += "<h6>Email</h6>";
            modalContent += "<input type='text' class='form-control' name='email' value='" + email + "'>";
            modalContent += "</div>";

            modalContent += "<div class='col-6 mb-4'>";
            modalContent += "<h6>Phone</h6>";
            modalContent += "<input type='text' class='form-control' name='contact' value='" + contact + "'>";
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
            modalContent += "<button type='button' class='btn btn-secondary' data-bs-dismiss='modal' style='margin-right: 6px;'>Close</button>";
            modalContent += "<button type='submit' id='edit-profile-button' class='btn btn-primary'> Save</button>";
            modalContent += "</div></div></div>";

            modalContent += "</div></div></div></div></div></section></form>";

            $("#startHere").html(modalContent);
            showEditModal();
        });
    });

    function showEditModal() {
        $("#editProfileModal").show();
    }

    function closeEditModal() {
        $("#editProfileModal").hide();
    }
</script>

<!--for designation update-->
<script>
    function updateDesignationName() {
        var dropdown = document.getElementById("selectdesignation");

        var designationId = document.getElementById("degIdEmp");

        var selectedOption = dropdown.options[dropdown.selectedIndex];
        var selectedDesignationId = selectedOption.value;

        designationId.value = selectedDesignationId;
    }
</script>

<%@include file="footer.jsp" %>