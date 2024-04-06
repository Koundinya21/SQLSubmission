-- CREATE TABLE orders (
--   customer_id INT, -- Customer ID associated with the order
--   orderId INT NOT NULL PRIMARY KEY, -- Unique identifier for each order
--   productName varchar(200), -- Name of the product in the order
--   quantity INT, -- Quantity of the product ordered
--   orderStatus varchar(200), -- Status of the order
--   deliveryDate date, -- Date of delivery for the order
--   FOREIGN KEY (customer_id) REFERENCES customers(customerId) ON DELETE CASCADE -- Foreign key constraint referencing customers table
-- );
-- CREATE TABLE customers(
--   customerId INT NOT NULL PRIMARY KEY, -- Unique identifier for each customer
--   Route_id INT, -- Route ID associated with the customer
--   customerNumber BIGINT, -- Customer number
--   FOREIGN KEY (Route_id) REFERENCES Routes(RouteId) ON DELETE CASCADE -- Foreign key constraint referencing Routes table
-- );
-- CREATE TABLE Routes(
--   RouteId INT NOT NULL PRIMARY KEY, -- Unique identifier for each route
--   RouteName varchar(200), -- Name of the route
--   vehicle_id INT, -- Vehicle ID associated with the route
--   FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicleId) ON DELETE CASCADE -- Foreign key constraint referencing Vehicles table
-- );
-- CREATE TABLE Vehicles(
--   vehicleId INT NOT NULL PRIMARY KEY, -- Unique identifier for each vehicle
--   vehicleName varchar(200), -- Name of the vehicle
--   parent_vehicle_id INT, -- Parent vehicle ID
--   parent_branch_id INT, -- Parent branch ID
--   FOREIGN KEY (parent_branch_id) REFERENCES Branch(BranchId) ON DELETE CASCADE -- Foreign key constraint referencing Branch table
-- );
-- CREATE TABLE Branch(
--   BranchId INT NOT NULL PRIMARY KEY, -- Unique identifier for each branch
--   BranchName varchar(200) -- Name of the branch
-- );
SELECT Vehicles.vehicleId,
    orders.productName,
    sum(orders.quantity) AS quantity_sum
FROM Vehicles
    INNER JOIN Routes ON Vehicles.vehicleId = Routes.vehicle_id
    INNER JOIN customers ON Routes.RouteId = customers.Route_id
    INNER JOIN orders ON customers.customerId = orders.customer_id
WHERE orders.orderStatus = "confirmed"
GROUP BY Vehicles.vehicleId,
    orders.productName