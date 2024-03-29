package product.model.vo;

public class Product {
	private String productId;
	private String productName;
	private int price;
	private String description;
	private int stock;
	
	public Product(){}
	
	public Product(String productId, String productName, int price, int stock, String description) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.description = description;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}




	public int getStock() {
		return stock;
	}



	public void setStock(int stock) {
		this.stock = stock;
	}


	@Override
	public String toString()
	{
		return productId + "\t" + productName + "\t" + price + "\t" + description+"\t"+stock;
	}
	
	
}
