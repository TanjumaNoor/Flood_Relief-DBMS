Create Database FloodReliefGoods9;
GO

-- Use the newly created database
USE FloodReliefGoods9;
GO
-- 1. Affected Area table
CREATE TABLE Affected_Area (
    Area_id VARCHAR(20) PRIMARY KEY,
    District_name VARCHAR(100) not null,
    Location_coordination VARCHAR(100),
    Affected_level VARCHAR(20),
    Resources_distributed VARCHAR(200),
	Populations INT check (Populations > 0)
);
GO
-- 2. Warehouse table
CREATE TABLE Warehouse (
    Warehouse_id VARCHAR(20) PRIMARY KEY,
    Warehouse_location VARCHAR(100),
    Storage_capacity INT check ( Storage_capacity >= 0),
    Current_stock INT check ( Current_stock >= 0),
    Warehouse_contact_number VARCHAR(15)
);
-- 3. Relief Goods table
CREATE TABLE Relief_Goods (
    Item_id VARCHAR(20) PRIMARY KEY,
	Item_name VARCHAR(50),
    Item_category VARCHAR(50),
    Item_quantity INT,
    Item_price DECIMAL(10, 2),
    [Expiry_date] DATE,
	Warehouse_id VARCHAR(20) FOREIGN KEY REFERENCES Warehouse
);
GO
-- 4. Suppliers table
CREATE TABLE Suppliers (
    Supplier_id VARCHAR(20) PRIMARY KEY,
    Supplier_name VARCHAR(100),
    S_contact_number VARCHAR(15),
    Category VARCHAR(50),
    Quantity INT,
);

GO
-- 5. Transportation table
CREATE TABLE Transportation (
 Warehouse_id VARCHAR(20),
 Supplier_id VARCHAR(20),
  Transportation_Date DATE,
 PRIMARY KEY ( Warehouse_id, Supplier_id),
 FOREIGN KEY ( Warehouse_id) REFERENCES  Warehouse,
 FOREIGN KEY ( Supplier_id) REFERENCES  Suppliers
);

GO
-- 6. Volunteers table
CREATE TABLE Volunteers (
    Volunteer_id VARCHAR(20) PRIMARY KEY,
    Volunteer_name VARCHAR(100),
    Blood_group VARCHAR(5) NOT NULL,
    V_contact_number VARCHAR(15),
    Skills VARCHAR(200),
    Assigned_task VARCHAR(100),
    V_age INT check (V_age >= 18),
    Assigned_area_id VARCHAR(20) FOREIGN KEY REFERENCES Affected_Area
);
GO
-- 7. Donor table
CREATE TABLE Donor (
    Donor_id VARCHAR(20) PRIMARY KEY,
    Donor_name VARCHAR(100),
    D_contact_number VARCHAR(15),
    Donation_amount DECIMAL(10, 2) check (Donation_amount >= 0),
    Donation_date DATE
);
GO
-- 8. Financial Record table
CREATE TABLE Financial_Record (
    Record_id VARCHAR(20) PRIMARY KEY,
    Amount DECIMAL(10, 2) check ( Amount >= 0),
    Transaction_date DATE,
    Payment_method VARCHAR(50) ,
    [Status] VARCHAR(20)check ([Status] in ('Pending', 'Received', 'Canceled')),
	Donor_id VARCHAR(20) FOREIGN KEY REFERENCES Donor,
	Supplier_id VARCHAR(20) FOREIGN KEY REFERENCES Suppliers
	);
GO
-- 9. Shelter table
CREATE TABLE Shelter (
    Shelter_id VARCHAR(20) PRIMARY KEY,
    Affected_area_id VARCHAR(20),
    Location VARCHAR(100),
    Shelter_contact_no VARCHAR(15),
    Capacity INT check (Capacity > 0),
    Services_offered VARCHAR(200),
    FOREIGN KEY (Affected_area_id) REFERENCES Affected_Area
);
GO
-- 10. Medical & Healthcare table
CREATE TABLE Medical_Healthcare (
    Medicine_name VARCHAR(100),
    Medicine_category VARCHAR(50),
    Quantity INT,
    Shelter_id VARCHAR(20),
    Expiration_date DATE,
    FOREIGN KEY (Shelter_id) REFERENCES Shelter
);


GO
-- 11. Coordination with Local Leaders table
CREATE TABLE Coordination_Local_Leaders (
    Leader_id VARCHAR(20) PRIMARY KEY,
    Leader_name VARCHAR(100) NOT NULL,
    L_contact_number VARCHAR(15),
    Area_id VARCHAR(20) Unique FOREIGN KEY REFERENCES Affected_Area,
    Resources_requested VARCHAR(200),
);
GO
-- 12. Guide table
CREATE TABLE Guide (
 Volunteer_id VARCHAR(20),
 Leader_id VARCHAR(20),
 Contact_Date DATE,
 PRIMARY KEY ( Volunteer_id, Leader_id),
 FOREIGN KEY ( Volunteer_id) REFERENCES  Volunteers,
 FOREIGN KEY ( Leader_id) REFERENCES Coordination_Local_Leaders
);

Go
-- 13. Distribution Records table
CREATE TABLE Distribution_Records (
    Transaction_id VARCHAR(20) PRIMARY KEY,
    Transaction_date DATE NOT NULL,
    Category VARCHAR(50),
    Distributed_item VARCHAR(100),
    Transportation_method VARCHAR(50),
	Distributed_Area VARCHAR(20),
	Warehouse_id VARCHAR(20),
	Quantity INT,
    FOREIGN KEY (Distributed_Area) REFERENCES Affected_Area,
	FOREIGN KEY (Warehouse_id) REFERENCES Warehouse
);

Go
INSERT INTO Affected_Area VALUES
(1, 'Dhaka', '23.8103° N, 90.4125° E', 'High', 'Food, Medicine',500000),
(2, 'Chittagong', '22.3475° N, 91.8123° E', 'Medium', 'Shelter',4000000),
(3, 'Sylhet', '24.8943° N, 91.8687° E', 'High', 'Food, Medicine, Shelter',3200000),
(4, 'Khulna', '22.8456° N, 89.5404° E', 'Low', 'Shelter, Water Supply',1240000),
(5, 'Rajshahi', '24.3740° N, 88.6043° E', 'Medium', 'Food, Medical Aid',6000000),
(6, 'Barisal', '22.7010° N, 90.3535° E', 'High', 'Food, Shelter, Water Supply',300000),
(7, 'Rangpur', '25.7451° N, 89.2623° E', 'Low', 'Water Supply, Medical Aid',120000),
(8, 'Mymensingh', '24.7474° N, 90.4111° E', 'Medium', 'Food, Medical Aid',70000),
(9, 'Feni', '21.4500° N, 92.0141° E', 'High', 'Shelter, Food, Medical Aid',80000),
(10, 'Jessore', '23.1621° N, 89.1839° E', 'Low', 'Food, Water Supply',19200),
(11, 'Comilla', '23.4682° N, 91.1825° E', 'Medium', 'Medical Aid, Food',64000),
(12, 'Noakhali', '23.6445° N, 90.5220° E', 'High', 'Shelter, Medical Aid, Food',246730);

Go
INSERT INTO Warehouse VALUES
('w1', 'Dhaka', 10000, 5000, '015xxxxxxxx'),
('w2', 'Chittagong', 8000, 3000, '016xxxxxxxx'),
('w3', 'Sylhet', 6000, 2000, '017xxxxxxxx'),
('w4', 'Khulna', 7000, 3500, '018xxxxxxxx'),
('w5', 'Rajshahi', 5000, 2500, '019xxxxxxxx'),
('w6', 'Barisal', 4000, 1500, '014xxxxxxxx'),
('w7', 'Rangpur', 3000, 1000, '013xxxxxxxx'),
('w8', 'Mymensingh', 5500, 2750, '015xxxxxxxx'),
('w9', 'Feni', 4500, 2200, '016xxxxxxxx'),
('w10', 'Jessore', 3500, 1700, '017xxxxxxxx'),
('w11', 'Comilla', 6500, 3200, '018xxxxxxxx'),
('w12', 'Noakhali', 7500, 4000, '019xxxxxxxx');

Go
INSERT INTO Relief_Goods VALUES
('itm1', 'Flattened Rice', 'Food', 100, 50.00, '2025-12-31', 'w1'),
('itm2', 'Paracetamol', 'Medicine', 50, 200.00, '2024-11-30', 'w2'),
('itm3', 'Winter Jacket', 'Clothing', 300, 100.00, NULL, 'w3'),
('itm4', 'Soap Pack', 'Hygiene Supplies', 150, 75.00, '2024-12-31', 'w4'),
('itm5', 'Aquatabs', 'Water', 500, 10.00, '2026-01-01', 'w5'),
('itm6', 'Woolen Blanket', 'Blankets', 200, 150.00, NULL, 'w6'),
('itm7', 'Canned Beans', 'Canned Food', 250, 80.00, '2025-08-15', 'w7'),
('itm8', 'Miniket Rice', 'Rice', 1000, 45.00, '2025-05-01', 'w1'),
('itm9', 'Soyabean Oil (5L)', 'Cooking Oil', 400, 120.00, '2025-03-20', 'w3'),
('itm10', 'N95 Masks', 'Medical Masks', 1000, 20.00, '2026-06-30', 'w2'),
('itm11', 'Fruits', 'Baby Food', 120, 250.00, '2024-12-15', 'w8'),
('itm12', 'Solar Lamp', 'Lighting', 75, 500.00, NULL, 'w9'),
('itm13', 'Bread Loaves (Pack of 5)', 'Food', 300, 30.00, '2024-12-01', 'w1'),
('itm14', 'Multivitamin Tablets (Bottle)', 'Medicine', 100, 350.00, '2025-07-01', 'w2'),
('itm15', 'Raincoat', 'Clothing', 150, 200.00, NULL, 'w3'),
('itm16', 'Toothpaste (200g)', 'Hygiene Supplies', 200, 50.00, '2024-11-30', 'w4'),
('itm17', 'Water Can (10L)', 'Water Bottles', 250, 20.00, '2026-03-01', 'w5'),
('itm18', 'Emergency Blanket (Thermal)', 'Blankets', 100, 120.00, NULL, 'w6'),
('itm19', 'Canned Tuna', 'Canned Food', 180, 75.00, '2025-06-01', 'w7'),
('itm20', 'Jasmine Rice (20kg)', 'Rice', 800, 90.00, '2025-04-01', 'w1'),
('itm21', 'Sunflower Oil (2L)', 'Cooking Oil', 350, 150.00, '2025-09-15', 'w3'),
('itm22', 'N95 Masks (20 pcs)', 'Medical Masks', 600, 150.00, '2026-01-15', 'w2'),
('itm23', 'LED Lantern (Rechargeable)', 'Lighting', 50, 300.00, '2024-10-31', 'w8');

Go
INSERT INTO Suppliers VALUES
('s1', 'ABC Pharma', '017xxxxxxxx', 'Medicine', 500),
('s2', 'XYZ Foods', '019xxxxxxxx',  'Food', 1000),
('s3', 'Fresh Supplies Ltd.', '018xxxxxxxx', 'Food', 800),
('s4', 'Health First Co.', '016xxxxxxxx', 'Medicine', 600),
('s5', 'Eco Transport', '017xxxxxxxx', 'Transportation', 20),
('s6', 'Clean Hygiene Ltd.', '019xxxxxxxx', 'Hygiene Kits', 400),
('s7', 'Safe Water Co.', '015xxxxxxxx', 'Water Bottles', 1000),
('s8', 'Global Relief Supplies', '014xxxxxxxx', 'Blankets', 300),
('s9', 'Rice Traders BD', '017xxxxxxxx', 'Food', 2000),
('s10', 'Prime Oils Co.', '018xxxxxxxx', 'Cooking Oil', 500),
('s11', 'Pro Health Supplies', '016xxxxxxxx', 'Medical Masks', 1200),
('s12', 'Baby Care BD', '019xxxxxxxx', 'Baby Food', 200);

Go
INSERT INTO Transportation VALUES
('w2','s1','2024-11-22'),
('w6','s4','2024-11-23'),
('w5','s3','2024-11-24'),
('w3','s8','2024-11-25'),
('w12','s6','2024-11-26'),
('w4','s5','2024-11-27'),
('w1','s2','2024-11-28'),
('w8','s9','2024-11-29'),
('w11','s5','2024-11-30'),
('w10','s8','2024-12-01'),
('w4','s1','2024-12-02'),
('w5','s6','2024-12-03');

Go
INSERT INTO Volunteers VALUES
('v1', 'Arfatun', 'O+', '018xxxxxxxx', 'First Aid', 'Distributing food', 25, 4),
('v2', 'Naina', 'A-', '019xxxxxxxx', 'Driving', 'Transport logistics', 30, 3),                                                
('v3', 'Urmi', 'B+', '017xxxxxxxx', 'Logistics', 'Coordinating relief supplies', 28,7),
('v4', 'prionti', 'AB-', '016xxxxxxxx', 'Swimming', 'Water rescue operations', 35, 4),
('v5', 'Tahsin', 'O-', '015xxxxxxxx', 'First Aid', 'Medical assistance', 22, 2),
('v6', 'Sajid', 'A+', '013xxxxxxxx', 'Driving', 'Transportation of goods', 27, 1),
('v7', 'Moumi', 'B-', '018xxxxxxxx', 'Logistics', 'Managing shelter arrangements', 31, 4),
('v8', 'Asif', 'AB+', '017xxxxxxxx', 'Swimming', 'Flood rescue missions', 29, 12),
('v9', 'Neha', 'O+', '019xxxxxxxx', 'First Aid', 'Providing emergency healthcare', 24, 6),
('v10', 'Puja', 'A-', '016xxxxxxxx', 'Driving', 'Delivering food supplies', 26, 8),
('v11', 'Toma', 'B+', '014xxxxxxxx', 'First Aid', 'Assisting in shelters', 23, 10),
('v12', 'urbana', 'O-', '015xxxxxxxx', 'Logistics', 'Monitoring supply chain', 34, 7),
('v13', 'Rafsan', 'O+', '018xxxxxxxx', 'First Aid', 'Distributing food', 25, 4),
('v14', 'Anika', 'A-', '019xxxxxxxx', 'Driving', 'Transport logistics', 30, 3),                                                 
('v15', 'Shafi', 'B+', '017xxxxxxxx', 'Logistics', 'Coordinating relief supplies', 28, 7),
('v16', 'Ayesha', 'AB-', '016xxxxxxxx', 'Swimming', 'Water rescue operations', 35, 4),
('v17', 'Hasib', 'O-', '015xxxxxxxx', 'First Aid', 'Medical assistance', 22, 2),
('v18', 'Nusrat', 'A+', '013xxxxxxxx', 'Driving', 'Transportation of goods', 27, 1),
('v19', 'Farhan', 'B-', '018xxxxxxxx', 'Logistics', 'Managing shelter arrangements', 31, 4),
('v20', 'Rifat', 'AB+', '017xxxxxxxx', 'Swimming', 'Flood rescue missions', 29, 12),
('v21', 'Rima', 'O+', '019xxxxxxxx', 'First Aid', 'Providing emergency healthcare', 24, 6),
('v22', 'Tonmoy', 'A-', '016xxxxxxxx', 'Driving', 'Delivering food supplies', 26, 8),
('v23', 'Pritam', 'B+', '014xxxxxxxx', 'First Aid', 'Assisting in shelters', 23, 10),
('v24', 'Jarin', 'O-', '015xxxxxxxx', 'Logistics', 'Monitoring supply chain', 34, 7);

Go
INSERT INTO Donor VALUES
('d1', 'Faiza', '017xxxxxxxx', 50000, '2024-11-20'),
('d2', 'Neha', '019xxxxxxxx', 100000, '2024-11-21'), 
('d3', 'Anni', '018xxxxxxxx', 75000, '2024-11-22'),
('d4', 'Rumi', '016xxxxxxxx', 120000, '2024-11-23'),
('d5', 'Tommy', '015xxxxxxxx', 30000, '2024-11-24'),
('d6', 'Lamia', '017xxxxxxxx', 45000, '2024-11-25'),
('d7', 'Sayma', '019xxxxxxxx', 200000, '2024-11-26'),
('d8', 'Farhan', '014xxxxxxxx', 100000, '2024-11-27'),
('d9', 'Nishat', '018xxxxxxxx', 50000, '2024-11-28'),
('d10', 'Hridi', '013xxxxxxxx', 25000, '2024-11-29'),
('d11', 'Kareena', '016xxxxxxxx', 90000, '2024-11-30'),
('d12', 'Spider man', '015xxxxxxxx', 150000, '2024-12-01');

Go
INSERT INTO Financial_Record VALUES
('fr1',  50000, '2024-11-20',  'Bank Transfer', 'Received', 'd7', 's1'),
('fr2',  100000, '2024-11-21',  'Cash', 'Pending', 'd2', 's2'),
('fr3',  150000, '2024-11-22',  'Check', 'Received', 'd1', 's3'),
('fr4',  75000, '2024-11-23', 'Bank Transfer', 'Received', 'd4', 's4'),
('fr5',  40000, '2024-11-24',  'Cash', 'Pending', 'd5', 's5'),
('fr6',  200000, '2024-11-25',  'Bank Transfer', 'Received', 'd9', 's6'),
('fr7',  30000, '2024-11-26',  'Check', 'Canceled', 'd8', 's7'),
('fr8',  50000, '2024-11-27',  'Cash', 'Received', 'd10', 's8'),
('fr9',  60000, '2024-11-28',  'Bank Transfer', 'Pending', 'd11', 's9'),
('fr10', 120000, '2024-11-29',  'Check', 'Received', 'd6', 's10'),
('fr11', 90000, '2024-11-30',  'Bank Transfer', 'Received', 'd3', 's11'),
('fr12', 110000, '2024-12-01', 'Cash', 'Pending', 'd7', 's12');

Go
INSERT INTO Shelter VALUES
('sl1', 1,'Dhaka',  '017xxxxxxxx', 200, 'Food, Medical Aid'),
('sl2', 2,'Chittagong',  '018xxxxxxxx', 150, 'Shelter, Food'),
('sl3', 3,'Sylhet',  '019xxxxxxxx', 100, 'Medical Aid, Water Purifying Tablet'),
('sl4', 4,'Khulna',  '016xxxxxxxx', 180, 'Shelter, Food'),
('sl5', 5,'Rajshahi', '015xxxxxxxx', 120, 'Food, Medical Aid, Water Purifying Tablet'),
('sl6', 6,'Barisal',  '017xxxxxxxx', 150, 'Shelter, Food'),
('sl7', 7,'Rangpur',  '018xxxxxxxx', 80, 'Medical Aid, Water Supply'),
('sl8', 8,'Mymensingh',  '014xxxxxxxx', 200, 'Shelter, Food, Water Purifying Tablet'),
('sl9', 9,'Feni',  '019xxxxxxxx', 300, 'Food, Medical Aid, Shelter'),
('sl10', 10,'Jessore',  '013xxxxxxxx', 110, 'Shelter, Water Purifying Tablet'),
('sl11', 11,'Comilla',  '016xxxxxxxx', 130, 'Food, Medical Aid'),
('sl12', 12,'Noakhali', '015xxxxxxxx', 170, 'Shelter, Food, Medical Aid');

Go
INSERT INTO Medical_Healthcare VALUES
('Paracetamol', 'Painkillers', 100, 'sl2', '2025-06-30'),
('Bandages', 'First Aid Supplies', 200, 'sl5', '2026-01-01'),
('Ibuprofen', 'Painkillers', 150, 'sl6', '2025-12-31'),
('Antibiotic Ointment', 'First Aid Supplies', 300, 'sl9', '2025-11-15'),
('Cough Syrup', 'Syrup', 250, 'sl4', '2026-03-01'),
('Disposable Gloves', 'First Aid Supplies', 500, 'sl1', '2026-07-15'),
('Saline Bags', 'Injection', 120, 'sl11', '2025-10-20'),
('Napa Syrup', 'Syrup', 200, 'sl3', '2026-05-01'),
('Thermometers', 'First Aid Supplies', 100,'sl9', '2027-01-01'),
('Pain Relief Spray', 'Painkillers', 180, 'sl7', '2025-09-30'),
('Surgical Masks', 'First Aid Supplies', 800, 'sl8', '2026-06-15'),
('Vitamins', 'Syrup', 220, 'sl9', '2025-08-10');

Go
INSERT INTO Coordination_Local_Leaders VALUES
('L1', 'Leader A', '017xxxxxxxx', 1, 'Food'),
('L2', 'Leader B', '019xxxxxxxx', 2, 'Medical Aid'),   
('L3', 'Leader C', '018xxxxxxxx', 3, 'Food'),
('L4', 'Leader D', '016xxxxxxxx', 4, 'Medical Aid'),
('L5', 'Leader E', '015xxxxxxxx', 5, 'Shelter'),
('L6', 'Leader F', '017xxxxxxxx', 6, 'Water Purifying Tablet'),
('L7', 'Leader G', '019xxxxxxxx', 7, 'Medical Aid, Food'),
('L8', 'Leader H', '014xxxxxxxx', 8, 'Shelter,Water Purifying Tablet'),
('L9', 'Leader I', '018xxxxxxxx', 9, 'Food, Medical Aid'),
('L10', 'Leader J', '016xxxxxxxx', 10, 'Food, Shelter'),
('L11', 'Leader K', '019xxxxxxxx', 11, 'Medical Aid, Shelter'),
('L12', 'Leader L', '017xxxxxxxx', 12, 'Food,Water Purifying Tablet');

Go
INSERT INTO Distribution_Records VALUES
('Dis1', '2024-11-23', 'Healthcare', 'Medicine', 'Van', 1,'w1', 10000),
('Dis2', '2024-11-24', 'Food',  'Food Packages', 'Truck',2,'w2', 20000),  
('Dis3', '2024-11-25', 'Food',  'Rice', 'Truck',3,'w3', 15000),
('Dis4', '2024-11-26', 'Healthcare',  'First Aid Kits', 'Van',4,'w4', 5000),
('Dis5', '2024-11-27', 'Shelter',  'Tents', 'Truck',5,'w5', 25000),
('Dis6', '2024-11-28', 'Water Purifying Tablet',  'Water Bottles', 'Van',6,'w6', 12000),
('Dis7', '2024-11-29', 'Medical Aid',  'Medical Masks', 'Van',7,'w7', 10000),
('Dis8', '2024-11-30', 'Food',  'Canned Food', 'Truck',8,'w8', 30000),
('Dis9', '2024-12-01', 'Shelter',  'Blankets', 'Van',9,'w9', 20000),
('Dis10', '2024-12-02', 'Healthcare',  'Bandages', 'Truck',10,'w10', 18000),
('Dis11', '2024-12-03', 'Food',  'Cooking Oil', 'Van',11,'w11', 5000),
('Dis12', '2024-12-04', 'Water Purifying Tablet',  'Water Purifier', 'Truck',12,'w12', 22000);

Go
INSERT INTO Guide VALUES
('v3','L2', '2024-11-23'),
('v6','L5', '2024-11-23'),
('v1','L12', '2024-11-23'),
('v8','L1', '2024-11-23'),
('v7','L10', '2024-11-23'),
('v2','L6', '2024-11-23'),
('v9','L3', '2024-11-23'),
('v4','L11', '2024-11-23'),
('v5','L9', '2024-11-23'),
('v12','L8', '2024-11-23'),
('v11','L7', '2024-11-23'),
('v10','L4', '2024-11-23')

Go
delete from Guide
where Volunteer_id in (select Volunteer_id from Volunteers
where Volunteer_name ='Toma')

Go
delete from Volunteers
where Volunteer_name ='Toma'

Go
select * from Affected_Area;

Go
select Item_category, count(*) from Relief_Goods
group by Item_category 

Go
select sum(Amount) as 'Pending Amount'  from Financial_Record 
where status ='Pending' 

Go
select Avg(donation_amount) as 'Average Donation' from donor;

Go
select Skills,COUNT(volunteer_id) from Volunteers
group by Skills

Go
Select  Volunteer_name, V_contact_number
from Volunteers
where blood_group= 'AB-'        ----rare bld grp 

Go
Select  Volunteer_name, V_contact_number
from Volunteers
where Skills= 'swimming'       ---for rescue

Go
select * from Financial_Record
where Status='Pending';

Go
select * from Affected_Area
order by Affected_level

Go
select Shelter_id, Affected_area_id, Capacity
from Shelter
order by Capacity DESC----ok



GO
select r.item_name, r.[Item_quantity], w.[Warehouse_location]
from relief_goods r
join warehouse w on r.warehouse_id = w.warehouse_id;

Go
select  d.donor_name, f.amount, f.transaction_date
from financial_record f
join donor d on f.donor_id = d.donor_id;

Go
update [dbo].[Relief_Goods]
set [Item_quantity] += 1200
where item_id = 'itm2';

Go
update Financial_Record
set status = 'Received'
where Donor_id ='d5'---for update

Go
update Volunteers
set [V_contact_number]= '01722191822'
where volunteer_id in (select Volunteer_id from Volunteers
where Volunteer_name ='Asif');

Go
select * from Affected_Area
where Resources_distributed like '%Food%';

Go
select * from Volunteers
where Volunteer_name like 'a%'

Go
select * from Relief_Goods
where expiry_date like '2026%'
