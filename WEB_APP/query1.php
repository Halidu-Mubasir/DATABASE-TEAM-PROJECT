<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Query 1</title>
	<!-- //connect to the library -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
<body>

	 <?php
	 	//database connection parameters
	 	//change the database name to suite what you have in phpmyadmin
		$servername = "localhost";
		$username = "root";
		$password = "";
		$dbname = "electricity_bill_management_system";

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);
		
		// Check connection
		if ($conn->connect_error) 
		{
		  die("Connection failed: " . $conn->connect_error);
		}

		//write sql
		$sql = "SELECT 
		Employee.positionId,
		Employee.salary,
		Position.positionName
	from Employee
	inner join Position on Employee.positionId = Position.positionId
	order by salary;";

		//execute sql
		$result = $conn->query($sql);

		//check if any record was found
		if ($result->num_rows > 0) 
		{
			//create an array
			$position  = array();
			$emp_salary = array();

			  // loop through the query result and fetch one record at a time
			  while($row = $result->fetch_assoc()) 
			  {
				  	//add record to array 
				  	//the curtomer_counrtry is a field/column in the customer table based on the query on line 27
				  	array_push($position, $row["positionName"]);
					array_push($emp_salary, $row["salary"]);	 

			   }//end of loop

		}//end of  if condition

		//close the connection to database
		$conn->close();
	?> 

	<!-- //starting drawing canvas -->
	<canvas id="myChart" style="width:100%;max-width:600px"></canvas>

	<!-- //canvas script -->
	<script>

	//change the content of the xvalues to be record from the database
	// var xValues = ["Italy", "France", "Spain", "USA", "Argentina"];

	// example of record coming from database below
	var xValues = <?php  

				//echo the array list on 39 and 46 as json list of items
				echo json_encode($position);
			?>

	var yValues = <?php  

				//echo the array list on 39 and 46 as json list of items
				echo json_encode($emp_salary);
			?>
	
	// the data list below are hardcoded
	//var yValues = [7000, 10000, 12000, 50000, 55000];
	var barColors = ["red", "green","blue","yellow","pink"];

	new Chart("myChart", {
	  type: "bar",
	  data: {
	    labels: xValues,
	    datasets: [{
	      backgroundColor: barColors,
	      data: yValues
	    }]
	  },
	  options: {
	    legend: {display: false},
	    title: {
	      display: true,
	      text: "Employee Salary Chart;"
	    }
	  }
	});
	</script>


</body>
</html>