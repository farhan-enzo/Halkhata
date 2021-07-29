<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Invoice :: Show</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-2"></div>

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
                        <th>Sl.</th>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th style="text-align: center">Quantity</th>
                        <th>Total</th>
                    </thead>

                    <tbody>
                        <c:forEach items="${invoice.items}" var="item" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${item.product.name}</td>
                                <td>${item.product.sellingPrice}</td>
                                <td style="text-align: center">${item.orderedQuantity}</td>
                                <td>${item.orderedQuantity * item.product.sellingPrice}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="text-align: center"><b>Grand Total: </b></td>
                            <td><b>${grandTotal}</b></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
