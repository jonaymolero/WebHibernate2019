package Pojos;
// Generated 10-dic-2018 12:05:14 by Hibernate Tools 4.3.1



/**
 * Reserva generated by hbm2java
 */
public class Reserva  implements java.io.Serializable {


     private short nreserva;
     private Habitacion habitacion;
     private String fechae;
     private String fechas;
     private String dni;

    public Reserva() {
    }

    public Reserva(short nreserva, Habitacion habitacion, String fechae, String fechas, String dni) {
       this.nreserva = nreserva;
       this.habitacion = habitacion;
       this.fechae = fechae;
       this.fechas = fechas;
       this.dni = dni;
    }
   
    public short getNreserva() {
        return this.nreserva;
    }
    
    public void setNreserva(short nreserva) {
        this.nreserva = nreserva;
    }
    public Habitacion getHabitacion() {
        return this.habitacion;
    }
    
    public void setHabitacion(Habitacion habitacion) {
        this.habitacion = habitacion;
    }
    public String getFechae() {
        return this.fechae;
    }
    
    public void setFechae(String fechae) {
        this.fechae = fechae;
    }
    public String getFechas() {
        return this.fechas;
    }
    
    public void setFechas(String fechas) {
        this.fechas = fechas;
    }
    public String getDni() {
        return this.dni;
    }
    
    public void setDni(String dni) {
        this.dni = dni;
    }




}


