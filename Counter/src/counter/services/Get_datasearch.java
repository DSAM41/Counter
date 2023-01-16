package counter.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import counter.dao.ItemCounterDao;
import counter.model.ItemCounter;

/**
 * Servlet implementation class Get_hopo_data
 */
@WebServlet("/Get_datasearch")
public class Get_datasearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Get_datasearch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Get_hopo_data");
		String hopo = request.getParameter("hopo");
		String flti = request.getParameter("flti");
		String alc2 = request.getParameter("alc2");
		String counter = request.getParameter("counter");
		ItemCounter item_search = new ItemCounter();
		item_search.setHopo(hopo);
		item_search.setFlti(flti);
		item_search.setAlc2(alc2);
		item_search.setCounter(counter);

		List<ItemCounter> item = ItemCounterDao.getDatasearch(item_search);
		
		System.out.println("GetUserHopo");
		Gson gson = new Gson();
		String userJSON = gson.toJson(item);
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
