package POJO;

import java.sql.Date;

public class MedicineInventoryPOJO {

	private int medicine_id;
	private String name;
	private String generic_name;
	private String category;
	private String manufacturer;
	private String batch_no;
	private Date expiry_date;
	private int quantity_in_stock;
	private int reorder_level;
	private double unit_price;

	public MedicineInventoryPOJO(int medicine_id, String name, String generic_name, String category,
			String manufacturer, String batch_no, Date expiry_date, int quantity_in_stock, int reorder_level,
			double unit_price) {
		super();
		this.medicine_id = medicine_id;
		this.name = name;
		this.generic_name = generic_name;
		this.category = category;
		this.manufacturer = manufacturer;
		this.batch_no = batch_no;
		this.expiry_date = expiry_date;
		this.quantity_in_stock = quantity_in_stock;
		this.reorder_level = reorder_level;
		this.unit_price = unit_price;
	}

	public int getMedicine_id() {
		return medicine_id;
	}

	public void setMedicine_id(int medicine_id) {
		this.medicine_id = medicine_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGeneric_name() {
		return generic_name;
	}

	public void setGeneric_name(String generic_name) {
		this.generic_name = generic_name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getBatch_no() {
		return batch_no;
	}

	public void setBatch_no(String batch_no) {
		this.batch_no = batch_no;
	}

	public Date getExpiry_date() {
		return expiry_date;
	}

	public void setExpiry_date(Date expiry_date) {
		this.expiry_date = expiry_date;
	}

	public int getQuantity_in_stock() {
		return quantity_in_stock;
	}

	public void setQuantity_in_stock(int quantity_in_stock) {
		this.quantity_in_stock = quantity_in_stock;
	}

	public int getReorder_level() {
		return reorder_level;
	}

	public void setReorder_level(int reorder_level) {
		this.reorder_level = reorder_level;
	}

	public double getUnit_price() {
		return unit_price;
	}

	public void setUnit_price(double unit_price) {
		this.unit_price = unit_price;
	}
}

