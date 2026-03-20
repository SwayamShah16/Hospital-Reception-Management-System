<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard - Hospital Management</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>🏥 Hospital</h2>
            <div class="nav-item active" onclick="showSection('dashboard')">📊 Dashboard</div>
            <div class="nav-item" onclick="showSection('appointments')">📅 Appointments</div>
            <div class="nav-item" onclick="showSection('emergency')">🚨 Emergency Cases</div>
            <div class="nav-item" onclick="showSection('inventory')">📦 Inventory Stocks</div>
            <div class="nav-item" onclick="showSection('rooms')">🛏️ Room Availability</div>
            <div class="nav-item" onclick="showSection('staff')">👥 Staff</div>
            <div class="nav-item" onclick="showSection('doctors')">👨‍⚕️ Doctors</div>
            <div class="nav-item" onclick="showSection('patients')">👤 Patients</div>
            <div class="nav-item" onclick="showSection('payments')">💳 Payments</div>
        </div>
        
        <div class="main-content">
            <div class="header">
                <h1>Receptionist Dashboard</h1>
                <div class="user-info">
                    <span>👤 Receptionist Name</span>
                    <button class="logout-btn" onclick="logout()">Logout</button>
                </div>
            </div>
            
            <!-- Dashboard Section -->
            <div id="dashboard" class="section active">
                <h2 class="section-title">Dashboard Overview</h2>
                <div class="cards-grid">
                    <div class="card" onclick="showSection('appointments')">
                        <div class="card-icon">📅</div>
                        <h3>Today's Appointments</h3>
                        <div class="card-value">12</div>
                    </div>
                    <div class="card" onclick="showSection('emergency')">
                        <div class="card-icon">🚨</div>
                        <h3>Emergency Cases</h3>
                        <div class="card-value">3</div>
                    </div>
                    <div class="card" onclick="showSection('rooms')">
                        <div class="card-icon">🛏️</div>
                        <h3>Available Rooms</h3>
                        <div class="card-value">8/15</div>
                    </div>
                    <div class="card" onclick="showSection('patients')">
                        <div class="card-icon">👤</div>
                        <h3>Total Patients</h3>
                        <div class="card-value">245</div>
                    </div>
                    <div class="card" onclick="showSection('payments')">
                        <div class="card-icon">💳</div>
                        <h3>Pending Payments</h3>
                        <div class="card-value">₹45,000</div>
                    </div>
                    <div class="card" onclick="showSection('inventory')">
                        <div class="card-icon">📦</div>
                        <h3>Low Stock Items</h3>
                        <div class="card-value">5</div>
                    </div>
                </div>
            </div>
            
            <!-- Appointments Section -->
            <div id="appointments" class="section">
                <h2 class="section-title">Manage Appointments</h2>
                <div class="form-group">
                    <label>Patient Name:</label>
                    <input type="text" placeholder="Enter patient name">
                </div>
                <div class="form-group">
                    <label>Appointment Date & Time:</label>
                    <input type="datetime-local">
                </div>
                <div class="form-group">
                    <label>Doctor:</label>
                    <select>
                        <option>Select Doctor</option>
                        <option>Dr. Raj Kumar</option>
                        <option>Dr. Priya Singh</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Department:</label>
                    <select>
                        <option>General</option>
                        <option>Cardiology</option>
                        <option>Orthopedics</option>
                    </select>
                </div>
                <button class="submit-btn">Book Appointment</button>
                
                <h3 style="margin-top: 30px; margin-bottom: 15px;">Upcoming Appointments</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Doctor</th>
                            <th>Date & Time</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>Dr. Raj Kumar</td>
                            <td>2024-01-15 10:00 AM</td>
                            <td><span class="status-badge" style="background-color: #d4edda; color: #155724;">Confirmed</span></td>
                            <td>
                                <button class="action-btn btn-edit">Edit</button>
                                <button class="action-btn btn-delete">Cancel</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Emergency Cases Section -->
            <div id="emergency" class="section">
                <h2 class="section-title">Emergency Cases</h2>
                <div class="form-group">
                    <label>Patient Name:</label>
                    <input type="text" placeholder="Enter patient name">
                </div>
                <div class="form-group">
                    <label>Emergency Type:</label>
                    <select>
                        <option>Accident</option>
                        <option>Heart Attack</option>
                        <option>Stroke</option>
                        <option>Severe Injury</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Description:</label>
                    <textarea placeholder="Enter emergency details"></textarea>
                </div>
                <button class="submit-btn">Register Emergency</button>
                
                <h3 style="margin-top: 30px; margin-bottom: 15px;">Active Emergency Cases</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Case Type</th>
                            <th>Admitted Time</th>
                            <th>Priority</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Jane Smith</td>
                            <td>Heart Attack</td>
                            <td>2024-01-15 02:30 PM</td>
                            <td><span class="status-badge status-emergency">Critical</span></td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Inventory Section -->
            <div id="inventory" class="section">
                <h2 class="section-title">Inventory Stocks</h2>
                <div class="form-group">
                    <label>Item Name:</label>
                    <input type="text" placeholder="Enter item name">
                </div>
                <div class="form-group">
                    <label>Quantity:</label>
                    <input type="number" placeholder="Enter quantity">
                </div>
                <button class="submit-btn">Add Stock</button>
                
                <h3 style="margin-top: 30px; margin-bottom: 15px;">Current Inventory</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Min. Level</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Medical Gloves</td>
                            <td>150</td>
                            <td>100</td>
                            <td><span class="status-badge status-available">Normal</span></td>
                            <td>
                                <button class="action-btn btn-edit">Edit</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Syringes</td>
                            <td>45</td>
                            <td>100</td>
                            <td><span class="status-badge status-emergency">Low Stock</span></td>
                            <td>
                                <button class="action-btn btn-edit">Edit</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Room Availability Section -->
            <div id="rooms" class="section">
                <h2 class="section-title">Room Availability</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Room Number</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Current Patient</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>101</td>
                            <td>General Ward</td>
                            <td><span class="status-badge status-available">Available</span></td>
                            <td>-</td>
                            <td>
                                <button class="action-btn btn-view">Assign</button>
                            </td>
                        </tr>
                        <tr>
                            <td>102</td>
                            <td>ICU</td>
                            <td><span class="status-badge status-occupied">Occupied</span></td>
                            <td>Jane Smith</td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Staff Section -->
            <div id="staff" class="section">
                <h2 class="section-title">Staff Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Staff Name</th>
                            <th>Position</th>
                            <th>Department</th>
                            <th>Contact</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Nurse Maria</td>
                            <td>Nurse</td>
                            <td>General Ward</td>
                            <td>9876543210</td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Doctors Section -->
            <div id="doctors" class="section">
                <h2 class="section-title">Doctors Directory</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Doctor Name</th>
                            <th>Specialization</th>
                            <th>Contact</th>
                            <th>Availability</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Dr. Raj Kumar</td>
                            <td>Cardiology</td>
                            <td>9876543210</td>
                            <td><span class="status-badge status-available">Available</span></td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Patients Section -->
            <div id="patients" class="section">
                <h2 class="section-title">Patient Records</h2>
                <div class="form-group">
                    <label>Patient Name:</label>
                    <input type="text" placeholder="Enter patient name">
                </div>
                <div class="form-group">
                    <label>Contact Number:</label>
                    <input type="tel" placeholder="Enter contact number">
                </div>
                <button class="submit-btn">Add Patient</button>
                
                <h3 style="margin-top: 30px; margin-bottom: 15px;">Registered Patients</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Patient ID</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Last Visit</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>P001</td>
                            <td>John Doe</td>
                            <td>9876543210</td>
                            <td>2024-01-10</td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                                <button class="action-btn btn-edit">Edit</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Payments Section -->
            <div id="payments" class="section">
                <h2 class="section-title">Payment Management</h2>
                <div class="form-group">
                    <label>Patient Name:</label>
                    <input type="text" placeholder="Enter patient name">
                </div>
                <div class="form-group">
                    <label>Amount:</label>
                    <input type="number" placeholder="Enter amount">
                </div>
                <div class="form-group">
                    <label>Payment Method:</label>
                    <select>
                        <option>Cash</option>
                        <option>Card</option>
                        <option>UPI</option>
                        <option>Bank Transfer</option>
                    </select>
                </div>
                <button class="submit-btn">Record Payment</button>
                
                <h3 style="margin-top: 30px; margin-bottom: 15px;">Payment History</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Amount</th>
                            <th>Method</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>John Doe</td>
                            <td>₹5,000</td>
                            <td>Card</td>
                            <td>2024-01-15</td>
                            <td><span class="status-badge status-available">Completed</span></td>
                            <td>
                                <button class="action-btn btn-view">View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script>
        function showSection(sectionId) {
            // Hide all sections
            const sections = document.querySelectorAll('.section');
            sections.forEach(section => section.classList.remove('active'));
            
            // Remove active class from nav items
            const navItems = document.querySelectorAll('.nav-item');
            navItems.forEach(item => item.classList.remove('active'));
            
            // Show selected section
            document.getElementById(sectionId).classList.add('active');
            
            // Add active class to clicked nav item
            event.target.classList.add('active');
        }
        
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                // Add logout functionality
                alert('Logging out...');
            }
        }
    </script>
</body>
</html>