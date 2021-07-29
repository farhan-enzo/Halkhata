<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="${_csrf.parameterName}" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <title>Invoice :: Create</title>

    <style>
        tr#productRow:hover {
            cursor: pointer;
            background: #e3f2fd;
        }

        span.pointer {
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="input-group mb-3" style="margin-top: 10px">
                <input type="text"
                       id="productSearch"
                       class="form-control"
                       placeholder="Product Name"
                       aria-label="Username"
                       aria-describedby="basic-addon1">
                <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
            </div>

            <div class="mb-3">
                <table class="table" id="productList">
                    <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr id="productRow" onclick="addItem(${product.id})">
                            <td>
                                ${product.name}/${product.quantity}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="col-md-8">

            <div class="mb-3">
                <legend>Invoice</legend>
                <div class="row">
                    <div class="col">
                        <p>Invoice No.: ${invoice.invoiceNo}</p>
                        <p>Date: ${invoice.date}</p>
                    </div>

                    <div class="col">
                        <p>Customer Name: </p>
                        <p>Customer Contact No.: </p>
                    </div>
                </div>
            </div>

            <div class="mb-3"></div>

            <legend>
                Item List
                <hr/>
            </legend>

            <div class="mb-3">
                <table class="table">
                    <thead>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th style="text-align: center">Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </thead>

                    <tbody>

                    <c:forEach items="${invoice.items}" var="item">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>${item.product.sellingPrice}</td>
                            <td style="text-align: center">
                                <span id="minusItem" class="pointer" onclick="minusItem(${item.product.id})">
                                    <i class="fas fa-minus-square fa-lg"></i>
                                </span>

                                    &nbsp;&nbsp; <b style="color: #fd7e14;">${item.orderedQuantity}</b>&nbsp;&nbsp;

                                <span id="plusItem" class="pointer" onclick="plusItem(${item.product.id})">
                                    <i class="fas fa-plus-square fa-lg"></i>
                                </span>
                            </td>
                            <td>${item.orderedQuantity * item.product.sellingPrice}</td>
                            <td>
                                <span class="pointer" onclick="dropItem(${item.product.id})">
                                    <i class="far fa-times-circle fa-lg"></i>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td></td>
                        <td></td>
                        <td style="text-align: center"><b>Grand Total: </b></td>
                        <td><b>${grandTotal}</b></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="mb-3">
                <form:form method="POST" modelAttribute="invoice">
                    <button class="btn btn-lg btn-primary btn-block"
                            type="submit">
                        Done
                    </button>
                </form:form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#productSearch").on("keyup", function() {
            var value = $(this).val().toLowerCase();

            $("#productList tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });

    function addItem(id) {
        $.ajax({
            url: '/invoice/addItem?id=' + id,
            type: 'GET',
            cache: false,
            contentType: 'application/json; charset=UTF-8',
            dataType: 'text',
            beforeSend: function(xhr) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");

                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                var currentUrl = window.location.href;

                if (currentUrl.includes("?status=inProgress")) {
                    location.reload();
                } else {
                    window.location.href = currentUrl + '?status=inProgress';
                }
            },
            error: function(e) {
                alert("Error while adding!");
            }
        });
    }

    function plusItem(id) {
        $.ajax({
            url: '/invoice/plusItem?id=' + id,
            type: 'GET',
            cache: false,
            contentType: 'application/json; charset=UTF-8',
            dataType: 'text',
            beforeSend: function(xhr) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");

                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                location.reload();
            },
            error: function(e) {
                alert("Error! Can not increment quantity.");
            }
        });
    }

    function minusItem(id) {
        $.ajax({
            url: '/invoice/minusItem?id=' + id,
            type: 'GET',
            cache: false,
            contentType: 'application/json; charset=UTF-8',
            dataType: 'text',
            beforeSend: function(xhr) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");

                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                location.reload();
            },
            error: function(e) {
                alert("Error! Can not decrement quantity.");
            }
        });
    }

    function dropItem(id) {
        if (confirm("Are you sure, you want to delete it?")) {
            $.ajax({
                url: '/invoice/dropItem?id=' + id,
                type: 'GET',
                cache: false,
                contentType: 'application/json; charset=UTF-8',
                dataType: 'text',
                beforeSend: function (xhr) {
                    var token = $("meta[name='_csrf']").attr("content");
                    var header = $("meta[name='_csrf_header']").attr("content");

                    xhr.setRequestHeader(header, token);
                },
                success: function (data) {
                    location.reload();
                },
                error: function (e) {
                    alert("Error while removing!");
                }
            });
        }
    }
</script>
</body>
</html>
