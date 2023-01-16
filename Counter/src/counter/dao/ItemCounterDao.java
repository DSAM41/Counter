package counter.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import counter.model.ItemCounter;


public class ItemCounterDao {
	static Connection con = DatabaseConnect.getConnection();
	
	public static List<ItemCounter> getData() {
		List<ItemCounter> list = new ArrayList<ItemCounter>();
		try {
			String sql = "select * from counter";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ItemCounter item = new ItemCounter();
				item.setHopo(rs.getString("hopo"));
				item.setFlti(rs.getString("flti"));
				item.setAlc2(rs.getString("alc2"));
				item.setCounter(rs.getString("counter").trim());
				list.add(item);
			}
			ps.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	public static int editData(ItemCounter item) {
		int status;
		try {
			String sql = "update counter set counter='"+item.getCounter()+"' where hopo='"+item.getHopo()+"' and flti='"+item.getFlti()+"' and alc2='"+item.getAlc2()+"' ";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			ps.close();
			rs.close();
			status = 1;
		} catch (SQLException e) {
			e.printStackTrace();
			status = 0;
		}
		return status;
	}
	
	public static int createData(ItemCounter item) {
		int status;
//		try {
//			sql = "select * from counter where hopo='"+item.getHopo()+"' and flti='"+item.getFlti()+"' and alc2='"+item.getAlc2()+"' ";
//			PreparedStatement ps = con.prepareStatement(sql);
//			ResultSet rs = ps.executeQuery();
//			if(rs.next()) {
//				status = 0;
//			} else {
//				sql = "insert into counter(hopo, flti, alc2, counter) values ('"+item.getHopo()+"', '"+item.getFlti()+"', '"+item.getAlc2()+"', '"+item.getCounter()+"' )";
//				ps = con.prepareStatement(sql);
//				rs = ps.executeQuery();
//				status = 1;
//			}
//			ps.close();
//			rs.close();
		try {
			String sql = "insert into counter(hopo, flti, alc2, counter) values ('"+item.getHopo()+"', '"+item.getFlti()+"', '"+item.getAlc2()+"', '"+item.getCounter()+"' )";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			ps.close();
			rs.close();	
			status = 1;
		} catch (SQLException e) {
			e.printStackTrace();
			status = 0;
		}
		return status;
	}
	
	public static void deleteData(ItemCounter item) {
		try {
			String sql = "delete from counter where hopo='"+item.getHopo()+"' and flti='"+item.getFlti()+"' and alc2='"+item.getAlc2()+"' ";
			PreparedStatement ps = con.prepareStatement(sql);;
			ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public static List<ItemCounter> getDatasearch(ItemCounter item_search) {
		
		List<ItemCounter> list = new ArrayList<ItemCounter>();
		
		try {
			boolean status = false;
			String sql = "select * from counter where hopo like '%"+item_search.getHopo()+"%' and flti like '%"+item_search.getFlti()+"%' and alc2 like '%"+item_search.getAlc2()+"%' and counter like '%"+item_search.getCounter()+"%' ";
			System.out.println(sql);
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
//			System.out.println(rs);
			while (rs.next()) {
				status = true;
				ItemCounter item = new ItemCounter();
				item.setHopo(rs.getString("hopo"));
				item.setFlti(rs.getString("flti"));
				item.setAlc2(rs.getString("alc2"));
				item.setCounter(rs.getString("counter"));
				list.add(item);
			}	
			if(!status) {
				list = null;
			}

			
			ps.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
