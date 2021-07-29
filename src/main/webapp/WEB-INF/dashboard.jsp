<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>
        Welcome
    </title>
</head>
<body>

<div class="container">
    <div class="row" style="padding-top: 10%">

        <div class="col-md-2"></div>

        <div class="col-md-8">
            <div class="mb-3">
                <legend>Welcome <strong>${user.username}</strong></legend>
            </div>

            <div class="mb-3">
                This is a simple Halkhata Application!
            </div>

            <div class="container">
                <div class="row">

                    <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">BRAND</h5>

                            <a href="/brand/show"
                               type="button"
                               style="margin-bottom: 10px"
                               class="btn btn-primary">Add new brand</a>

                            <a href="/brand/show"
                               type="button"
                               style="margin-bottom: 10px"
                               class="btn btn-primary">Brand List</a>
                        </div>
                    </div>

                    <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">PRODUCT</h5>

                            <a href="/product/create"
                               type="button"
                               style="margin-bottom: 10px"
                               class="btn btn-primary">Add new product</a>

                            <a href="/product/list"
                               type="button"
                               style="margin-bottom: 10px"
                               class="btn btn-primary">product List</a>
                        </div>
                    </div>

                    <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">INVOICE</h5>

                            <div class="col-sm">
                                <a href="/invoice/create"
                                   type="button"
                                   style="margin-bottom: 10px"
                                   class="btn btn-primary">Create New Invoice</a>

                                <a href="/invoice/list"
                                   type="button"
                                   style="margin-bottom: 10px"
                                   class="btn btn-primary">Invoice List</a>
                            </div>
                        </div>
                    </div>

                    <c:if test="${profile.name == 'ADMIN'}">
                        <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                            <div class="card-body">
                                <h5 class="card-title">PROFILE</h5>

                                <div class="col-sm">
                                    <a href="/profile/create"
                                       type="button"
                                       style="margin-bottom: 10px"
                                       class="btn btn-primary">Create New Profile</a>

                                    <a href="/profile/list"
                                       type="button"
                                       style="margin-bottom: 10px"
                                       class="btn btn-primary">Profile List</a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">Analytics</h5>

                            <div class="col-sm">
                                <a href="/analytics/show"
                                   type="button"
                                   style="margin-bottom: 10px"
                                   class="btn btn-primary">Show Analytics</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>