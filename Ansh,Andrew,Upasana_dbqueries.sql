/* QUESTION 3 -- SQL Queries */

	/*Average Prescription Cost at "CVS"*/
	Select avg(Prescription.TotalCost) As 'Total Prescription Rev ($)'
	From Prescription;

	/*View products and their suppliers*/
	Select Product.Name as 'Product', Supplier.Name As 'Supplier'
	From Product
	INNER JOIN Supplier
	ON Product.SupplierID=Supplier.SupplierID
	Order by Product.name ASC;
	
	/*Most sales generating doctors*/
	Select Doctor.Lastname, Sum(Prescription.TotalCost) As 'Total Sales'
	From Doctor
	FULL OUTER JOIN Prescription
	ON Doctor.DoctorID=Prescription.DoctorID
	GROUP BY Doctor.LastName
	ORDER BY Sum(Prescription.TotalCost) DESC;

	/*The Full Outer Join includes values that are not linked 
	to both tables. In this example, not all doctors have prescribed
	medicine at our pharmacy, but they are still in our database,
	and should be included as such.*/

	/*Prescription Drugs that are above the average cost of a non-prescription and their suppliers*/
	Select Product.Name as 'Product', Supplier.Name  as 'Supplier'
		From Product 
		FULL OUTER JOIN Supplier
		ON Product.SupplierID=Supplier.SupplierID
		FULL OUTER JOIN Prescription
		ON Prescription.ProductID= Product.ProductID
		Where (Select avg(Orderline.UnitPrice) 
				From Orderline) < Prescription.TotalCost
		GROUP BY Product.Name, Supplier.Name
		Order BY Product.Name ASC;

		/*Database by Upasana Roy, Ansh Jain, Andrew Piispanen*/