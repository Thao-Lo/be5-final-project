package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Product;
import sql.connection.DBConnection;

public class ProductDAO {
	public List<Product> getLatestProducts() throws SQLException {
		Connection connection = DBConnection.makeConnection();

		String SQL = "SELECT * FROM product WHERE is_new = 1;";
		Statement stmt = connection.createStatement();

		ResultSet resultSet = stmt.executeQuery(SQL);

		ArrayList<Product> list = new ArrayList<Product>();

		while (resultSet.next()) {

			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			int price = resultSet.getInt("price");
			String imgName = resultSet.getString("img_name");
			boolean isNew = resultSet.getBoolean("is_new");
			int quantity = resultSet.getInt("quantity");
			String description = resultSet.getString("description");

			Product product = new Product(id, name, price, imgName, isNew, quantity, description);
			list.add(product);
		}

		return list;
	}
	
	public List<Product> getAllProducts() throws SQLException {
		Connection connection = DBConnection.makeConnection();

		String SQL = "SELECT * FROM product;";
		Statement stmt = connection.createStatement();

		ResultSet resultSet = stmt.executeQuery(SQL);

		ArrayList<Product> list = new ArrayList<Product>();

		while (resultSet.next()) {

			int id = resultSet.getInt("id");
			String name = resultSet.getString("name");
			int price = resultSet.getInt("price");
			String imgName = resultSet.getString("img_name");
			boolean isNew = resultSet.getBoolean("is_new");
			int quantity = resultSet.getInt("quantity");
			String description = resultSet.getString("description");

			Product product = new Product(id, name, price, imgName, isNew, quantity, description);
			list.add(product);
		}

		return list;
	}
	public Product getProductById(int productId) throws SQLException {
		
		Connection connection = DBConnection.makeConnection();
		
		String sql = "SELECT * FROM product where id = ?;";
		
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setInt(1, productId);
								
		ResultSet resultSet = preStmt.executeQuery();

		Product product = new Product();
		
		if (resultSet.next()) {
			product.setId(resultSet.getInt("id"));
			product.setName(resultSet.getString("name"));
			product.setPrice(resultSet.getInt("price"));
			product.setImgName(resultSet.getString("img_name"));
			product.setIs_new(resultSet.getBoolean("is_new"));
			product.setQuantity(resultSet.getInt("quantity"));
			product.setDescription(resultSet.getString("description"));		
			
			} else {
			return null;
		}
		
		return product;
	}
	
}
