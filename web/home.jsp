<%-- 
    Document   : home
    Created on : 17-ene-2019, 18:58:14
    Author     : Usuario
--%>

<%@page import="Pojos.Habitacion"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" href="css/fontawesome.css">
    <link rel="stylesheet" href="css/mycss.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
    <title>Hotel Azarquiel</title>
  </head>
  <body>
<%
    String ficha = (String)session.getAttribute("ficha");
    Habitacion habitacion;
    List listaHabitacionesLibres=(List) session.getAttribute("listaHabitacionesLibres");
    List listaTotalHabitaciones=(List) session.getAttribute("listaTotalHabitaciones");
%>
    <div class="container shadow-lg bg-primary">
        <nav class="navbar navbar-expand-md navbar-dark bg-primary">
            <a class="navbar-brand" href="#">Hotel Azarquiel</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link <%=(ficha.equals("entrada")?"active":"")%>" href="Controller?op=entradaoreserva&ficha=entrada">Entradas<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%=(ficha.equals("reservas")?"active":"")%>" href="Controller?op=entradaoreserva&ficha=reservas">Reservas</a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
    <%
    if (ficha.equals("entrada")) {
    %>
    <div class="container shadow-lg">
        <div class="row my-5">
            <div class="col-md-6 offset-md-3 mb-3">
                <h2 class="bg-primary text-center text-white">Entradas al hotel</h2>
                <form action="Controller?op=hospedar" method="POST" name="fhospedar">
                    <div class="form-group">
                        <label class="control-label" for="dni">DNI</label>
                        <input type="text" class="form-control" id="dni" name="dni" aria-describedby="dniHelp" placeholder="Enter DNI" required>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="selectHabitaciones">Habitaciones</label>
                        <div>
                            <select id="selectHabitaciones" name="selectHabitaciones" class="form-control" required>
                                <option value="" disabled selected>Elija una opción</option>
                                <%
                                    for(int i=0;i<listaHabitacionesLibres.size();i++){
                                        habitacion=(Habitacion)listaHabitacionesLibres.get(i);
                                %>
                                <option value="<%=habitacion.getNhabitacion()%>"><%=habitacion.getNhabitacion()%></option>
                                    <%}
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="fecha">Fecha Salida</label>
                        <input type="text" placeholder="Fecha Salida" id="fecha" name="fecha" class="form-control datepicker" required>
                    </div>
                    <button type="submit" class="btn btn-danger">Hospedar</button>
                </form>
            </div>
        </div>
    </div>
    <%
    }
    if (ficha.equals("reservas")) {
    %>
    <div class="container shadow-lg">
        <div class="row mt-5">
            <div class="col-md-6 offset-md-3">
                    <h2 class="bg-primary text-center text-white">Listado de habitaciones para consultas de reservas</h2>
            </div>
        </div>
        <div class="row my-3">
            <div class="col-md-12 table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Nº Habitación</th>
                            <th scope="col">Nº Personas</th>
                            <th scope="col">Precio</th>
                            <th scope="col">Ocupada</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for(int i=0;i<listaTotalHabitaciones.size();i++){
                            habitacion=(Habitacion) listaTotalHabitaciones.get(i);
                        %>
                        <tr>
                            <td>
                                <button type="button" class="btn-primary" data-id="<%=habitacion.getNhabitacion()%>" data-toggle="modal" data-target="#modalreservas">
                                    <%=habitacion.getNhabitacion()%>
                                </button>
                            </td>
                            <td>
                                <%=habitacion.getNpersonas()%>
                            </td>
                            <td>
                                <%=habitacion.getPrecio()%>
                            </td>
                            <td>
                                <%=(habitacion.isOcupada()?"SI":"NO")%>
                            </td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%
    }
    %>
    <!-- Modal -->
    <div class="modal fade bd-example-modal-lg" id="modalreservas" tabindex="-1" role="dialog" aria-labelledby="modalreservas" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title bg-primary col-md-12 text-white text-center" id="exampleModalLabel">RESERVAS</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                      <div id="reservas" class="col-sm-12">
                           <!--se rellena con ajax-->
                      </div>
                    </div>
                </div>
                <div class="modal-footer col-md-1 offset-md-6">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- The snackbar -->
    <% String mensaje = (String)request.getAttribute("mensaje");
        if (mensaje!=null){
            %>
            <div id="snackbar"><%=mensaje%></div>
            <script type="text/javascript">
                toast();
            </script>
        <%}
    %>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="js/jquery-3.3.1.slim.min.js"></script>
    <script src="js/jquery-1.12.4.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/myjs.js"></script>
   </body>
</html>
