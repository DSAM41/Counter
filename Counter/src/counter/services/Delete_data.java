package counter.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import counter.dao.ItemCounterDao;
import counter.model.ItemCounter;

/**
 * Servlet implementation class Delete_data
 */
@WebServlet("/Delete_data")
public class Delete_data extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete_data() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("DeleteUser");
		String hopo = request.getParameter("hopo");
		String flti = request.getParameter("flti");
		String alc2 = request.getParameter("alc2");
		ItemCounter item = new ItemCounter();
		item.setHopo(hopo);
		item.setFlti(flti);
		item.setAlc2(alc2);
		
		
		ItemCounterDao.deleteData(item);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
