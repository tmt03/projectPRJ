/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.Event_participationDAO;
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
import model.event_participation;
import model.Report;

/**
 *
 * @author thanm
 */
public class JoinEvent extends HttpServlet {

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
            out.println("<title>Servlet JoinEvent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet JoinEvent at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Event_participationDAO dao = new Event_participationDAO();
            
            List<Report> r=dao.getReport();
            
            request.setAttribute("dataR", r);
            request.getRequestDispatcher("report.jsp").forward(request, response);
        } catch (Exception e) {
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
        String join = request.getParameter("join");
        if ("join".equals(join)) {
            
            if (join != null && !join.isEmpty()) {
                try {
                    joinEvent(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(JoinEvent.class.getName()).log(Level.SEVERE, null, ex);
                }
            }else{
                response.sendRedirect("event");
            }
        }
    }
    
    public void joinEvent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int eventId = Integer.parseInt(request.getParameter("event_Id"));
        int memberId = Integer.parseInt(request.getParameter("member_Id"));

        // Tạo một đối tượng event_participation từ các tham số
        event_participation e_p = new event_participation();
        e_p.setEvent_id(eventId);
        e_p.setMember_id(memberId);

        // Gọi phương thức joinEvent() trong DAO để thêm sự kiện vào bảng event_participation
        Event_participationDAO dao = new Event_participationDAO();
        dao.joinEvent(e_p);
        response.sendRedirect("event");
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
