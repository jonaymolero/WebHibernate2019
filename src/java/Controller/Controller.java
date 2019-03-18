/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Pojos.Habitacion;
import Pojos.Ocupacion;
import Pojos.OcupacionId;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        
        String op;
        List listaHabitacionesLibres;
        List listaTotalHabitaciones;
        String sql;
        Query query;
        Session em = null;
        
        em = (Session) session.getAttribute("em");
        if (em == null) {
            em = HibernateUtil.getSessionFactory().openSession();
            session.setAttribute("em", em);
        }
        
        op = request.getParameter("op");
        
        if(op.equals("inicio")){
            sql="from Habitacion where ocupada=false";
            query=em.createQuery(sql);
            listaHabitacionesLibres=query.list();
            session.setAttribute("listaHabitacionesLibres", listaHabitacionesLibres);
            
            sql="from Habitacion";
            query=em.createQuery(sql);
            listaTotalHabitaciones=query.list();
            session.setAttribute("listaTotalHabitaciones", listaTotalHabitaciones);
            
            session.setAttribute("ficha", "entrada");
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }else if (op.equals("entradaoreserva")) {
            String ficha = request.getParameter("ficha");
            session.setAttribute("ficha", ficha);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);

        }else if(op.equals("hospedar")){
            String dni= request.getParameter("dni");
            String nhabitacion= request.getParameter("selectHabitaciones");
            String fechaSalida=request.getParameter("fecha");
            fechaSalida = fechaSalida.replace("/", "-");
            Date fechae = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            String fechaEntrada = sdf.format(fechae);
            
            OcupacionId ocupacionId=new OcupacionId(nhabitacion, fechaEntrada);
            Habitacion habitacion=(Habitacion) em.get(Habitacion.class, nhabitacion);
            Ocupacion ocupacion=new Ocupacion(ocupacionId, habitacion, fechaSalida, dni);
            
            Transaction transaction=em.beginTransaction();
            em.persist(ocupacion);
            habitacion.setOcupada(true);
            em.update(habitacion);
            transaction.commit();
            
            listaHabitacionesLibres=(List) session.getAttribute("listaHabitacionesLibres");
            for(int i=0;i<listaHabitacionesLibres.size();i++){
                Habitacion h=(Habitacion) listaHabitacionesLibres.get(i);
                if(h.getNhabitacion().equals(habitacion.getNhabitacion())){
                    listaHabitacionesLibres.remove(h);
                }
            }
            
            session.getAttribute("listaHabitacionesLibres");
            String mensaje = "Hospedado " + ocupacion.getDni() + " en Habitacion " + ocupacion.getId().getNhabitacion();
            request.setAttribute("mensaje", mensaje);
            dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        }else if(op.equals("reservas")){
            String nhabitacion=(String)request.getParameter("nhabitacion");
            sql = "from Reserva where nhabitacion=?";
            query = em.createQuery(sql);
            query.setString(0, nhabitacion);
            List listaReservas=query.list();
            request.setAttribute("listaReservas", listaReservas);
            dispatcher = request.getRequestDispatcher("reservas.jsp");
            dispatcher.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
