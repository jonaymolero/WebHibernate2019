<%-- 
    Document   : reservas
    Created on : 20-ene-2019, 16:53:31
    Author     : Usuario
--%>

<%@page import="Pojos.Reserva"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nhabitacion = (String) request.getParameter("nhabitacion");
    List listaReservas = (List) request.getAttribute("listaReservas");
if(listaReservas.size()==0){%>
    <h5 class="bg-primary text-white text-center">Habitación <%=nhabitacion%> sin reservas...</h5>
<%}else{%>
    <h5 class="bg-primary text-white text-center">Habitación: <%=nhabitacion%></h5>
    <div class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Nº Reserva</th>
                <th scope="col">Nº Habitacion</th>
                <th scope="col">Fecha In</th>
                <th scope="col">Fecha Out</th>
                <th scope="col">DNI</th>
            </tr>
        </thead>
        <tbody>
            <%  Reserva reserva=null;
                for(int i=0;i<listaReservas.size();i++){
                reserva=(Reserva)listaReservas.get(i);
            %>
            <tr>
                <td><%=reserva.getNreserva()%></td>
                <td><%=reserva.getHabitacion().getNhabitacion()%></td>
                <td><%=reserva.getFechae()%></td>
                <td><%=reserva.getFechas()%></td>
                <td>@<%=reserva.getDni()%></td>
            </tr>
            <%}%>
        </tbody>
    </table>
    </div>
<%}%>

