    package dal;

import model.Roles;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolesDAO extends DBContext {

    public List<Roles> getAllRoles() throws SQLException {
        List<Roles> roles = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "  FROM [dbo].[roles]";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                Roles role = new Roles(id, name);
                roles.add(role);
            }
        } catch(SQLException e) {
            System.out.println(e);
        }
        return roles;
    }

    public static void main(String[] args) throws SQLException {
        RolesDAO dao = new RolesDAO();
            List<Roles> roles = dao.getAllRoles();
            for (Roles role : roles) {
                System.out.println("ID: " + role.getId() + ", Name: " + role.getName());
            }
        
    }
}
