package servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AccountManager")
public class AccountHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static Connection conn;
	;
	
    public AccountHandler() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		try {
			conn=game.main.DatabaseConnectionManager.getConnection();
			
			
		} catch (Exception e) {
			throw new ServletException();
		}
	}

	public void destroy() {
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
