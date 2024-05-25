/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Report;
import model.event_participation;

public class Event_participationDAO extends DBContext {

    public void joinEvent(event_participation e_p) throws SQLException {
        try {
            // Lấy điểm của sự kiện từ bảng events
            String sqlScore = "SELECT score FROM events WHERE id = ?";
            PreparedStatement statementScore = connection.prepareStatement(sqlScore);
            statementScore.setInt(1, e_p.getEvent_id());
            ResultSet rs = statementScore.executeQuery();

            // Kiểm tra xem có kết quả trả về không
            if (rs.next()) {
                // Nếu có, lấy điểm và cập nhật vào đối tượng event_participation
                int eventScore = rs.getInt("score");
                e_p.setEvent_score(eventScore);
            }

            // Chuẩn bị câu lệnh SQL để thêm mới vào bảng event_participation
            String sqlInsert = "INSERT INTO event_participation (member_id, event_id, event_score) VALUES (?, ?, ?)";
            PreparedStatement statementInsert = connection.prepareStatement(sqlInsert);

            // Thiết lập các tham số cho câu lệnh SQL
            statementInsert.setInt(1, e_p.getMember_id());
            statementInsert.setInt(2, e_p.getEvent_id());
            statementInsert.setInt(3, e_p.getEvent_score());

            // Thực thi câu lệnh SQL để thêm mới vào bảng event_participation
            statementInsert.executeUpdate();

            // Đóng kết nối và tài nguyên
            statementScore.close();
            statementInsert.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Report> getReport() throws SQLException {
        List<Report> report = new ArrayList<>();

        try {
            String query = "SELECT m.name AS member_name, SUM(ep.event_score) AS total_score\n"
                    + "FROM members m\n"
                    + "JOIN event_participation ep ON m.id = ep.member_id\n"
                    + "GROUP BY m.name;";

            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String member_name = resultSet.getString("member_name");
                int total_score = resultSet.getInt("total_score");

                Report r = new Report(member_name, total_score);
                report.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return report;
    }
    
    
     public static void main(String[] args) {
        Event_participationDAO dao = new Event_participationDAO();
        try {
            List<Report> reports = dao.getReport();
            System.out.println("Member Name | Total Score");
            System.out.println("-------------------------");
            for (Report r : reports) {
                System.out.println(r.getMember_name()+ " | " + r.getTotal_score());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
