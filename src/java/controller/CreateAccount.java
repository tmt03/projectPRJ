/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author thanm
 */
public class CreateAccount extends HttpServlet {

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
            out.println("<title>Servlet CreateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccount at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("createacc.jsp").forward(request, response);
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
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String full_name = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone_number = request.getParameter("phoneNumber");

            UserDAO userDAO = new UserDAO();
            if (userDAO.checkUser(username)) {
                // Nếu tài khoản đã tồn tại, hiển thị thông báo và chuyển hướng người dùng
                request.setAttribute("errorMessage2", "Tài khoản đã tồn tại");
                request.getRequestDispatcher("createacc.jsp").forward(request, response);
                return;
            }

            // Tạo tài khoản mới
            boolean created = userDAO.createUser(username, password, full_name, email, phone_number);
            if (created) {
                // Nếu tạo tài khoản thành công, chuyển hướng người dùng đến trang thành công
// Sau khi đăng ký thành công
                request.setAttribute("successMessage", "Đăng ký thành công!");

                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Nếu có lỗi xảy ra trong quá trình tạo tài khoản, hiển thị thông báo lỗi
                request.getRequestDispatcher("createacc.jsp").forward(request, response);
            }

        } catch (IOException e) {
            System.out.println("Error in CreateAccountServlet: " + e.getMessage());
            request.setAttribute("errorMessage", "Error creating account");
            request.getRequestDispatcher("createacc.jsp").forward(request, response);
        }
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
