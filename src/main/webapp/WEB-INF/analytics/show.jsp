<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <title>Analytics</title>

    <style>
        div#products:hover {
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row" style="padding-top: 10%">

        <div class="col-md-2"></div>

        <div class="col-md-8">
            <div class="mb-3">
                <legend>Business Overview</legend>
            </div>

            <div class="mb-3">
                Analytics
            </div>

            <div>
                <div class="row">

                    <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">Total Monthly Sale</h5>
                            <p style="font-size: xx-large; font-weight: bold;">
                                ${currentMonthTotalSale}
                            </p>
                        </div>
                    </div>

                    <div class="card"
                         style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                        <div class="card-body">
                            <h5 class="card-title">Total Monthly Profit</h5>
                            <p style="font-size: xx-large; font-weight: bold">
                                ${currentMonthTotalProfit}
                            </p>
                        </div>
                    </div>

                    <div class="card"
                         id="products"
                         data-bs-toggle="modal"
                         data-bs-target="#stockOutProducts"
                         style="width: 15rem; margin-right: 10px; margin-bottom: 10px">

                        <div class="card-body">
                            <h5 class="card-title">Near stock out products</h5>
                            <a style="font-size: xx-large; font-weight: bold; color: #dc3545">
                                ${nearStockOutProducts.size()}
                            </a>

                            <!-- Modal -->
                            <div class="modal fade"
                                 id="stockOutProducts"
                                 tabindex="-1"
                                 aria-labelledby="exampleModalLabel"
                                 aria-hidden="true">

                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Product list</h5>
                                        </div>

                                        <div class="modal-body">
                                            <table class="table">
                                                <thead>
                                                <tr>
                                                    <th>Sl.</th>
                                                    <th>Name</th>
                                                    <th>Quantity</th>
                                                    <th>Brand Name</th>
                                                    <th>Edit</th>
                                                </tr>
                                                </thead>

                                                <tbody>
                                                <c:forEach items="${nearStockOutProducts}" var="product" varStatus="i">
                                                    <tr>
                                                        <td>${i.index + 1}</td>

                                                        <td>${product.name}</td>

                                                        <td>${product.quantity}</td>

                                                        <td>${product.brand.name}</td>

                                                        <td>
                                                            <a href="/product/edit?id=${product.id}" class="link">
                                                                <i class="fas fa-pen"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <c:if test="${profile.name == 'ADMIN'}">
                        <div class="card" style="width: 15rem; margin-right: 10px; margin-bottom: 10px">
                            <div class="card-body">
                                <h5 class="card-title">PROFILE</h5>
                                <p style="font-size: xx-large; font-weight: bold">10</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>