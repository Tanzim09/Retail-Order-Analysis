# 📌 Retail Order Analysis: Data Cleaning & Visualization

## 📖 Project Overview

This project focuses on analyzing and cleaning retail order data using **Python (Pandas)** and **SQL** for structured queries. Additionally, insights are visualized using **Power BI** for better decision-making.

---

## 📂 Dataset Description

The dataset contains information about customer orders, including:

- `Order ID` – Unique order identifier
- `Customer Name` – Name of the customer
- `Product Name` – Name of the purchased product
- `Quantity Ordered` – Number of units ordered
- `Price Each` – Price per unit
- `Order Date` – Date when the order was placed
- `Order Status` – Status of the order (Completed, Pending, Canceled)
- `City` – Customer’s city
- `State` – Customer’s state

---

## 🔧 Data Cleaning Process

Using **Pandas**, we performed:  
✅ **Handling missing values** – Removed rows with null values in critical columns.  
✅ **Data type conversion** – Converted `Order Date` to datetime and `Quantity Ordered` to integers.  
✅ **Duplicate removal** – Eliminated duplicate orders.  
✅ **Standardization** – Formatted city and state names consistently.  
✅ **Derived columns** – Created a `Total Price` column (`Quantity Ordered` × `Price Each`).

---

## 📊 SQL Integration

After cleaning the data, we stored it in an SQL database.

### **SQL Table Schema:**

```sql
CREATE TABLE RetailOrders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ProductName VARCHAR(255),
    QuantityOrdered INT,
    PriceEach FLOAT,
    OrderDate DATE,
    OrderStatus VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    TotalPrice FLOAT
);
```

### **Sample Query for Analysis:**

```sql
SELECT State, SUM(TotalPrice) AS TotalRevenue
FROM RetailOrders
GROUP BY State
ORDER BY TotalRevenue DESC;
```

---

## 📈 Power BI Visualization

Built a **Power BI dashboard** which includes:  
📌 **Total Revenue by Region** – A bar chart displaying revenue across different states.  
📌 **Top Selling Category** – A pie chart showing the best-selling products.  
📌 **Monthly Sales Trend** – A line chart tracking revenue trends over time.

---

## 🚀 How to Run the Project

1️⃣ Install dependencies:

```bash
pip install pandas sqlalchemy
```

2️⃣ Run the Python script to clean data and store it in SQL.  
3️⃣ Connect Power BI to the SQL database and load the cleaned data.  
4️⃣ Build visualizations and analyze the insights!
