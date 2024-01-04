package entity;

public class User {

	private int id;
	private String username;
	private String email;
	private String password;
	private int failedCount;

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public User(int id, String username, String email, String password, int failedCount) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.failedCount = failedCount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getFailedCount() {
		return failedCount;
	}

	public void setFailedCount(int failedCount) {
		this.failedCount = failedCount;
	}

}
