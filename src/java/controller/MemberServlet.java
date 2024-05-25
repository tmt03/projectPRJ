/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.MemberDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Members;

/**
 *
 * @author thanm
 */
public class MemberServlet extends HttpServlet {

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
            String keyword = request.getParameter("keyword");
            MemberDAO dao = new MemberDAO();
            List<Members> members;

            if (keyword != null && !keyword.isEmpty()) {
                // Nếu có từ khóa tìm kiếm, thực hiện truy vấn với từ khóa
                members = dao.searchMembers(keyword);
            } else {
                // Nếu không có từ khóa tìm kiếm, lấy tất cả các thành viên
                members = dao.getAllMembers();
            }

            request.setAttribute("data", members);
            request.getRequestDispatcher("managemember.jsp").forward(request, response);
        } catch (Exception e) {
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

        if ("delete".equals(action)) {
            // Gọi phương thức deleteMember nếu action là 'delete'
            deleteMember(request, response);
        } else if ("add".equals(action)) {
            // Gọi phương thức updateMember nếu action là 'update'
            addMember(request, response);
        } else if ("update".equals(action)) {
            try {
                // Gọi phương thức updateMember nếu action là 'update'
                updateMember(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(MemberServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            // Xử lý các trường hợp khác hoặc báo lỗi
            response.sendRedirect("errorPage.jsp"); // Hoặc một cách xử lý khác
        }
    }

    //Xóa
    public void deleteMember(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("memberId");
        MemberDAO dao = new MemberDAO();
        //Xóa
        dao.deleteMember(id);
        response.sendRedirect("member");
    }

    //Thêm
    private void addMember(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String mssv = request.getParameter("mssv");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String birthdate = request.getParameter("birthdate");
        String joinedDate = request.getParameter("joinedDate");
        String status = request.getParameter("status");
        int departmentId = Integer.parseInt(request.getParameter("department_id"));

        // Tạo đối tượng Member mới
        Members member = new Members();
        member.setName(name);
        member.setMssv(mssv);
        member.setGender(gender);
        member.setPhone(phone);
        member.setEmail(email);
        member.setBirthdate(birthdate);
        member.setJoinedDate(joinedDate);
        member.setStatus(status);
        member.setDepartment_id(departmentId);

        // Tạo đối tượng MemberDAO để thêm thành viên mới vào cơ sở dữ liệu
        MemberDAO memberDAO = new MemberDAO();
        memberDAO.addMember(member);
        response.sendRedirect("member");

    }

    private void updateMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        try {
            request.setCharacterEncoding("UTF-8");
            // Nhận thông tin từ request
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("editName");
            String mssv = request.getParameter("editMssv");
            String gender = request.getParameter("editGender");
            String phone = request.getParameter("editPhone");
            String email = request.getParameter("editEmail");
            String birthdate = request.getParameter("editBirthdate");
            String joinedDate = request.getParameter("editJoinedDate");
            String status = request.getParameter("editStatus");
            int departmentId = Integer.parseInt(request.getParameter("editDepartment_id"));            //

            // Tạo đối tượng Member mới với thông tin cập nhật
            Members member = new Members();
            member.setId(id);
            member.setName(name);
            member.setMssv(mssv);
            member.setGender(gender);
            member.setPhone(phone);
            member.setEmail(email);
            member.setBirthdate(birthdate);
            member.setJoinedDate(joinedDate);
            member.setStatus(status);
            member.setDepartment_id(departmentId);

            // Tạo đối tượng MemberDAO để thực hiện cập nhật thành viên trong cơ sở dữ liệu
            MemberDAO memberDAO = new MemberDAO();
            memberDAO.updateMember(member);
            response.sendRedirect("member");

        } catch (IOException e) {

            // Xử lý các ngoại lệ nếu cần thiết
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
