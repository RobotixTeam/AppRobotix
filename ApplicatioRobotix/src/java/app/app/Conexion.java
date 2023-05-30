package app.app;

import static java.lang.System.out;
import java.sql.*;

public class Conexion {
    
   Connection cn = null;
    
    public Connection conectar(){
        
        try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Robotix?"
                + "autoReconnect=true&useSSL=false", "root", "andrea");
        
        }catch(ClassNotFoundException | SQLException error){
            out.print(error.toString());
        }
        return cn;
    }
}

