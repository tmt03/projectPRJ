/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.EventDAO;
import dal.MemberDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import model.Events;
import model.Members;

/**
 *
 * @author thanm
 */
public class EventServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MemberServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MemberServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String keyword1 = request.getParameter("keyword2");

            EventDAO dao = new EventDAO();
            MemberDAO mdao = new MemberDAO();
            List<Events> e = null;
            List<Members> m = null;
            

            if (keyword1 != null && !keyword1.isEmpty()) {
                // Nếu có từ khóa tìm kiếm, thực hiện truy vấn với từ khóa
                e = dao.searchEvent(keyword1);
            } else {
                // Nếu không có từ khóa tìm kiếm, lấy tất cả các thành viên
                e = dao.getAllEvent();
                m = mdao.getAllMembers();
            }
            
            request.setAttribute("dataE", e);
            request.setAttribute("data", m);
            request.getRequestDispatcher("event.jsp").forward(request, response);
        } catch (Exception ex) {
            // Xử lý các ngoại lệ nếu có
        }
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
        // Lấy giá trị tham số 'action' từ request
        String action = request.getParameter("action");
        try {
            if ("delete".equals(action)) {
                // Gọi phương thức deleteMember nếu action là 'delete'
                deleteEvent(request, response);
            }
            if ("add".equals(action)) {
                // Gọi phương thức updateMember nếu action là 'update'
                addEvent(request, response);
            }
            if ("update".equals(action)) {

                // Gọi phương thức updateMember nếu action là 'update'
                updateEvent(request, response);

            } else {
                // Xử lý các trường hợp khác hoặc báo lỗi
                response.sendRedirect("errorPage.jsp"); // Hoặc một cách xử lý khác
            }
        } catch (Exception e) {
            // Log the exception for troubleshooting
        logger.error("An error occurred in doPost method:", e);
        // Forward to error page or display an error message
        request.setAttribute("errorMessage", "An error occurred while processing your request.");
        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
        }

    }

    //Xóa
    public void deleteEvent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("eventId");
        EventDAO dao = new EventDAO();
        //Xóa
        dao.deleteEvent(id);
        response.sendRedirect("event");
    }

    //Thêm
    private void addEvent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");
        int score = Integer.parseInt(request.getParameter("score"));

        // Tạo đối tượng Member mới
        Events ev = new Events();
        ev.setName(name);
        ev.setDescription(description);
        ev.setStart_date(start_date);
        ev.setEnd_date(end_date);
        ev.setScore(score);
        // Tạo đối tượng MemberDAO để thêm thành viên mới vào cơ sở dữ liệu
        EventDAO eventDAO = new EventDAO();
        eventDAO.addEvent(ev);
        response.sendRedirect("event");

    }

    private void updateEvent(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        request.setCharacterEncoding("UTF-8");
        // Nhận thông tin từ request
        int id = Integer.parseInt(request.getParameter("editId"));
        String name = request.getParameter("editName");
        String description = request.getParameter("editDescription");
        String start_date = request.getParameter("editStart_date");
        String end_date = request.getParameter("editEnd_date");
        int score = Integer.parseInt(request.getParameter("editScore"));

        //
        // Tạo đối tượng Member mới với thông tin cập nhật
        Events e = new Events();
        e.setId(id);
        e.setName(name);
        e.setDescription(description);
        e.setStart_date(start_date);
        e.setEnd_date(end_date);
        e.setScore(score);
        // Tạo đối tượng MemberDAO để thực hiện cập nhật thành viên trong cơ sở dữ liệu
        EventDAO eventDAO = new EventDAO();
        eventDAO.updateEvent(e);
        response.sendRedirect("event");

    }
    
    
}
