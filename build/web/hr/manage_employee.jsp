
<%@include file="header.jsp" %>

<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>Manage Employee</h3>
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html" class="text-success">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Manage Employee</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card">
            <div class="card-body">
                <table class='table' id="table1">
                    <thead>
                        <tr>
                            <th>Emp img</th>
                            <th>Full Name</th>
                            <th>Designation</th>
                            <th>Status</th>
                            <th>Account created</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding: 0">
                                <img src="../images/default.png" style="width: 40px;margin-left: 41px; " data-bs-toggle="modal" data-bs-target="#employeeDetails" alt="alt"/>
                            </td>
                            <td>John Doe</td>
                            <td>IT</td>
                            <td>
                                <span class="badge bg-success">Active</span>
                            </td>
                            <td>2021-11-01</td> 
                            <td><a style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editEmployee"><i class="fa fa-pen text-success"></i></a>   <a href="editDesignation.php"><i class="fa fa-trash text-danger"></i></a></td>
                        </tr>
                        <tr>
                            <td style="padding: 0;">
                                <img src="../images/default.png" style="width: 40px;margin-left: 41px; " alt="alt"/>
                            </td>
                            <td>Jane Doe</td>
                            <td>HR</td>
                            <td>
                                <span class="badge bg-danger">Deactivated</span>
                            </td>
                            <td>2021-11-01</td>
                            <td>
                                <a style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editEmployee"><i class="fa fa-pen text-success"></i></a> 
                                <a href="#"><i class="fa fa-trash text-danger"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>564355</td>
                            <td>Juan Dela Cruz</td>
                            <td>ENGINEERING</td>
                            <td>
                                <span class="badge bg-success">Active</span>
                            </td>
                            <td>2021-11-01</td>
                            <td><a href="editDesignation.php"><i class="fa fa-pen text-success"></i></a>   <a href="editDesignation.php"><i class="fa fa-trash text-danger"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </section>
</div>


<!--modal-->

<!-- Modal employee details -->
<div class="modal fade" id="employeeDetails" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel"> HRMS </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <!--                    <span aria-hidden="true">&times;</span>-->
                </button>
            </div>

            <div class="modal-body">
                <div class="container text-center">
                    <img src="../images/default.png" class="img-fluid" style="max-width: 150px;border-radius: 50%;">
                    <h5 class="modal-title mt-3" id="exampleModalLabel"> Ravi </h5>

                    <!--details-->
                    <div id="profile-details" class="mt-3">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th scope="row">ID :</th>
                                    <td>1567</td>
                                </tr>
                                <tr>
                                    <th scope="row">Email :</th>
                                    <td>22mca0121@nirmauni.ac.in</td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender :</th>
                                    <td>Male</td>
                                </tr>
                                <tr>
                                    <th scope="row">Status :</th>
                                    <td>Active</td>
                                </tr>
                                <tr>
                                    <th scope="row">Registered On :</th>
                                    <td>Created on</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--end Details-->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!--end modal-->


<!-- Modal of Edit Employee -->
<div class="modal fade" id="editEmployee" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel"> HRMS </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <!--                    <span aria-hidden="true">&times;</span>-->
                </button>
            </div>

            <div class="modal-body">
                <div class="container text-center">
                    <img src="../images/default.png" class="img-fluid" style="max-width: 150px;border-radius: 50%;">
                    <h5 class="modal-title mt-3" id="exampleModalLabel"> Ravi </h5>

                    <!--Profile Edit-->
                    <div id="profile-edit">
                        <h3 class="mt3">Please Edit Carefully</h3>

                        <form  method="POST" enctype="multipart/form-data">
                            <table class="table" border="1">
                                <tr>
                                    <th scope="row">ID :</th>
                                    <td>1568</td>
                                </tr>
                                <tr>
                                    <th scope="row">Email :</th>
                                    <td><input type="email" class="form-control" name="user_email" value="ravi"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Name :</th>
                                    <td><input type="text" class="form-control" name="user_name" value="jhj"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Password :</th>
                                    <td><input type="password" class="form-control" name="user_password" value="llsa"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender :</th>
                                    <td>male</td>
                                </tr>
                                <tr>
                                    <th scope="row">About :</th>
                                    <td>
                                        <textarea class="form-control" name="user_about" rows="3">
                                                    kalksjkajsk
                                        </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">New Profile:</th>
                                    <td>
                                        <input type="file" name="image" class="form-control">
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <button type="submit" class="btn btn-outline-primary">Save</button>
                            </div>
                        </form>
                    </div>
                    <!--End profile-->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="edit-profile-button" data-bs-dismiss="modal" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

<!--end Edit Employee modal-->

<!--<script>
    $(document).ready(function () {
        //your code here
        let editStatus = false;
        $("#edit-profile-button").click(function () {
            if (editStatus == false) {
                $("#profile-details").hide();
                $("#profile-edit").show();

                editStatus = true;
                $(this).text("Back");
            } else {
                $("#profile-edit").hide();
                $("#profile-details").show();

                editStatus = false;
                $(this).text("Edit");
            }
        })
    });

</script>-->
<%@include file="footer.jsp" %>