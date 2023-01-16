package counter.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import counter.dao.ItemCounterDao;
import counter.model.ItemCounter;

/**
 * Servlet implementation class EDIT_DATA
 */
@WebServlet("/Edit_data")
public class Edit_data extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Edit_data() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("EditUser");
		String hopo = request.getParameter("hopo");
		String flti = request.getParameter("flti");
		String alc2 = request.getParameter("alc2");
		String counter = request.getParameter("counter");
		
		ItemCounter item = new ItemCounter();
		item.setHopo(hopo);
		item.setFlti(flti);
		item.setAlc2(alc2);
		item.setCounter(counter);

		
		int status = ItemCounterDao.editData(item);
		
		Gson gson = new Gson();
		String userJSON = gson.toJson(status);
		PrintWriter printWriter = response.getWriter();
		printWriter.write(userJSON);
		printWriter.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
