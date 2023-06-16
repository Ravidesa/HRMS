
<%@include file="header.jsp" %>

<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <!--            <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>Add Skill</h3>
                        </div>-->
            <div class="col-12 col-md-12 order-md-2 order-first d-flex justify-content-end">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html" class="text-success">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Skill & Qualification</li>
                    </ol>
                </nav>
            </div>
        </div>

    </div>


    <!-- Basic Vertical form layout section start -->
    <section id="basic-vertical-layouts">
        <div class="row match-height">
            <div class="col-md-8 col-12">
                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Add Skill</h3>
                </div>
                <div class="card">
                    <div class="card-content">
                        <div class="card-body">
                            <form class="form form-vertical">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group has-icon-left">
                                                <label for="first-name-icon">Skill Name</label>
                                                <div class="position-relative">
                                                    <input type="text" class="form-control" placeholder="Input Skill" id="first-name-icon">
                                                    <div class="form-control-icon">
                                                        <i class="fa fa-table"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12 d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
                                        </div>
                                        
                                    </div>
                                </div>
                            </form>
                        </div> 
                    </div>
                </div>

                <div class="col-12 col-md-6 order-md-1 order-last">
                    <h3>Add Qualification</h3>
                </div>

                <div class="card">
                    <div class="card-content">
                        <div class="card-body">
                            <form class="form form-vertical">
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group has-icon-left">
                                                <label for="first-name-icon">Qualification Name</label>
                                                <div class="position-relative">
                                                    <input type="text" class="form-control" placeholder="Input Qualification" id="first-name-icon">
                                                    <div class="form-control-icon">
                                                        <i class="fa fa-table"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12 d-flex justify-content-end">
                                            <button type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- // Basic Vertical form layout section end -->
</div>

<%@include file="footer.jsp" %>