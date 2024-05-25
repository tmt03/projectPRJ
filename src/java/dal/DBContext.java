package dal;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        Properties prop = new Properties();
        try (InputStream input = new FileInputStream("config.properties")) {
            prop.load(input);
            String user = "sa";
            String pass = prop.getProperty("db.password");
            String url = "jdbc:sqlserver://LAPTOP-UACSD3DT:1433;databaseName=QLNS";
            connection = DriverManager.getConnection(url, user, pass);
        } catch (IOException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
