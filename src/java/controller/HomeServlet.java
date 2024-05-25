/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dal.EventDAO;
import dal.Event_participationDAO;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import model.Report;

import model.bxhEvent;

/**
 *
 * @author thanm
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
            EventDAO eventDAO = new EventDAO();
            Event_participationDAO dao = new Event_participationDAO();

            List<bxhEvent> topEvents = eventDAO.getBxhEvent();
            List<Report> report = dao.getReport();

            // Sắp xếp BXH MEMBER theo total_score giảm dần
            Collections.sort(report, new Comparator<Report>() {
                @Override
                public int compare(Report r1, Report r2) {
                    return Integer.compare(r2.getTotal_score(), r1.getTotal_score());
                }
            });

            // Đặt danh sách các sự kiện hàng đầu vào thuộc tính của request để chuyển đến JSP
            request.setAttribute("topEvents", topEvents);
            request.setAttribute("topMembers", report);

            // Chuyển hướng đến trang JSP để hiển thị danh sách các sự kiện hàng đầu
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            // Xử lý ngoại lệ SQL
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
        request.getRequestDispatcher("home").forward(request, response);
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
