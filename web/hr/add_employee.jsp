
<%@include file="header.jsp" %>
<%@page import="com.entities.User,com.dao.UserDAO,com.helper.ConnectionProvider" %>
<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>Add Employee</h3>
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html" class="text-success">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Employee</li>
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

                            <div class="row">
                                <div class="col-md-12 col-12">
                                    <div class="form-group has-icon-left">
                                        <label for="first-name-icon">Employee Email</label>
                                        <div class="position-relative">
                                            <select class="form-control" id="email" name="email">
                                                <option>--Select--</option>
                                                <%
                                                UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
                                                List<User> users = dao.getAllUserEMP();
                                                for (User u : users) {
                                                %>

                                                <option value="<%= u.getId()%>"> <%= u.getEmail()%></option>
                                                <%
                                                }
                                                %>
                                            </select>
                                            <div class="form-control-icon">
                                                <i class="fa fa-envelope"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 col-12">
                                    <div class="form-group has-icon-left">
                                        <label for="first-name-icon">Employee Name</label>
                                        <div class="position-relative">
                                            <input type="text" class="form-control" placeholder="employee name" id="empName" readonly>
                                            <div class="form-control-icon">
                                                <i class="fa fa-hash"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <form class="form" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Designation</label>
                                            <div class="position-relative">
                                                <input type="text" class="form-control" placeholder="designatuion" id="first-name-icon">
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
                                                <input type="text" class="form-control" placeholder="contact" id="first-name-icon">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-phone"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Date Of Birth</label>
                                            <div class="position-relative">
                                                <input type="date" class="form-control" placeholder="last name" id="first-name-icon">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-birthday-cake"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Profile</label>
                                            <div class="position-relative">
                                                <input type="file" class="form-control" placeholder="" name="imageFile" accept="image/*">
                                                <div class="form-control-icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12 col-12">
                                        <div class="form-group has-icon-left">
                                            <label for="first-name-icon">Address</label>
                                            <textarea class="form-control" id="form7Example7" rows="4"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-12 d-flex justify-content-end">
                            <button type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
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

<script>
    $(document).ready(function () {
        $("#email").change(function () {
            var selectedEmailId = parseInt($(this).val());

            $.ajax({
                url: '../AllEmployee',
                type: 'post',
                data: {id: selectedEmailId},
                success: function (response) {
                    $("#empName").val(response);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(error);
                }
            });
        });
    });
</script>


<%@include file="footer.jsp" %>