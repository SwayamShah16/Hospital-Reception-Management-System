<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
HttpSession session1 = request.getSession(false);

if (session1 == null || session1.getAttribute("user_id") == null) {
	response.sendRedirect("login.jsp");
	return;
}

int userId = (int) session1.getAttribute("user_id");
String username = (String) session1.getAttribute("username");
String role = (String) session1.getAttribute("role");
%>
<%
if (!("Admin".equals(role) || "Staff".equals(role))) {
	response.sendRedirect("unauthorized.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ambulance Service Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Angular CDN -->
<script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
<style>
:root {
	--sidebar-width: 250px;
	--primary: #dc3545;
	--primary-dark: #c82333;
	--success: #198754;
	--warning: #ffc107;
	--danger: #dc3545;
	--info: #0dcaf0;
	--light: #f8f9fa;
	--dark: #212529;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: cursive;
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	min-height: 100vh;
}

.sidebar {
	width: var(--sidebar-width);
	height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	overflow-y: auto;
	background: linear-gradient(135deg, #dc3545, #c82333);
	background-size: cover;
	background-position: center;
	min-height: 100vh;
	color: white;
	transition: all 0.3s;
	z-index: 1000;
	scrollbar-width: medium;
	scroll-behavior: smooth;
}

.main-content {
	margin-left: var(--sidebar-width) !important;
	min-height: 100vh;
	transition: margin-left 0.3s ease;
	background-color: #f8f9fc;
	padding: 2rem 1rem;
}

@media ( max-width : 768px) {
	.sidebar {
		transform: translateX(-100%);
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.main-content {
		margin-left: 0 !important;
	}
}

.sidebar-overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 999;
}

.sidebar-overlay.show {
	display: block;
}

.sidebar-header {
	padding: 1.5rem;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-menu .nav-link {
	color: rgba(255, 255, 255, 0.8);
	padding: 0.75rem 1.5rem;
	margin-bottom: 0.5rem;
	border-left: 3px solid transparent;
	text-decoration: none;
}

.sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active {
	color: white;
	background-color: rgba(255, 255, 255, 0.1);
	border-left: 3px solid white;
}

.sidebar-menu .nav-link i {
	margin-right: 10px;
	font-size: 1.1rem;
	width: 20px;
}

/* Ambulance Stats Cards */
.stat-card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	transition: all 0.4s ease;
	overflow: hidden;
	height: 120px;
	position: relative;
}

.stat-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.stat-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
}

.stat-primary::before {
	background: linear-gradient(90deg, var(--primary), #fd7e14);
}

.stat-success::before {
	background: linear-gradient(90deg, var(--success), #20c997);
}

.stat-warning::before {
	background: linear-gradient(90deg, var(--warning), #e83e8c);
}

.stat-info::before {
	background: linear-gradient(90deg, var(--info), #6610f2);
}

.stat-number {
	font-size: 2.5rem;
	font-weight: 700;
	line-height: 1;
}

.stat-icon {
	width: 60px;
	height: 60px;
	border-radius: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	opacity: 0.9;
}

.alert-section {
	background: white;
	border-radius: 15px;
	padding: 1.5rem;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	margin-bottom: 1rem;
	height: 100%;
}

.alert-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.75rem 0;
	border-bottom: 1px solid #eee;
	font-size: 0.9rem;
}

.alert-item:last-child {
	border-bottom: none;
}

.status-badge {
	font-size: 0.7rem;
	padding: 0.25rem 0.5rem;
}

.table-card {
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.table thead th {
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	color: white;
	border: none;
	font-weight: 600;
	padding: 1.25rem 1rem;
}

.fade-in {
	animation: fadeIn 0.6s ease-in;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Ambulance Status Colors */
.status-available {
	background-color: #d4edda;
	color: #155724;
}

.status-busy {
	background-color: #fff3cd;
	color: #856404;
}

.status-maintenance {
	background-color: #f8d7da;
	color: #721c24;
}
</style>
</head>
<body ng-app="AmbulanceApp">
	<!-- Sidebar Overlay -->
	<div class="sidebar-overlay" id="sidebarOverlay"></div>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0 text-white">Ambulance Dashboard</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href="dashboard">
						<i class="fas fa-tachometer-alt"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link" href="patient"> <i
						class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link" href="doctor"> <i
						class="fas fa-user-md"></i> Doctor
				</a></li>
				<li class="nav-item"><a class="nav-link" href="appointment">
						<i class="fas fa-calendar-check"></i> Appointments
				</a></li>
				<li class="nav-item"><a class="nav-link" href="emergency">
						<i class="fas fa-calendar-check"></i> Emergency Cases
				</a></li>
				<li class="nav-item"><a class="nav-link" href="room"> <i
						class="fas fa-bed"></i> Rooms
				</a></li>
				<li class="nav-item"><a class="nav-link" href="payment"> <i
						class="fas fa-money-bills"></i> Payment
				</a></li>
				<li class="nav-item"><a class="nav-link" href="staff"> <i
						class="fas fa-id-badge"></i> Staff
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Medicine.jsp">
						<i class="fas fa-boxes"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="Ambulance.jsp"> <i class="fas fa-ambulance"></i>
						Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link" href="chatbot"> <i
						class="fas fa-robot"></i> Chatbot
				</a></li>
				<li class="nav-item"><a class="nav-link" href="about.jsp">
						<i class="bi bi-info-circle"></i> About
				</a></li>
				<li class="nav-item"><a class="nav-link" href="contact.jsp">
						<i class="bi bi-person-rolodex"></i> Contact Us
				</a></li>
				<li class="nav-item"><a class="nav-link" href="DiseaseInfo.jsp">
						<i class="fa fa-book-medical"></i> Disease Info
				</a></li>
			</ul>
		</div>
	</div>

	<!-- Main Content -->
	<div class="main-content" ng-controller="DashboardController">
		<nav class="navbar">
			<div class="container-fluid text-center text-dark">
				<a class="navbar-brand text-dark" href="dashboard"> Hospital ERP
				</a> <span class="me-3 text-dark">Logged in: <b
					class="bi bi-person"><%=username%> (<%=role%>) </b></span>
				<form action="UserServlet" method="get">
					<input type="hidden" name="action" value="logout">
					<button class="btn btn-warning btn-sm">Logout</button>
				</form>

			</div>
		</nav>
		<div class="container-fluid pt-5">
			<!-- Stats Cards -->
			<div class="row g-4 mb-5 fade-in">
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-primary text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Total Ambulances</h6>
								<div class="stat-number">{{totalAmbulances}}</div>
							</div>
							<div class="stat-icon bg-white bg-opacity-20">
								<i class="fas fa-ambulance"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-success text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Available</h6>
								<div class="stat-number">{{availableAmbulances}}</div>
							</div>
							<div class="stat-icon bg-success bg-opacity-20 text-success">
								<i class="fas fa-check-circle"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-warning text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Active Calls</h6>
								<div class="stat-number">{{activeCalls}}</div>
							</div>
							<div class="stat-icon bg-warning bg-opacity-20 text-warning">
								<i class="fas fa-phone"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-info text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Today's Trips</h6>
								<div class="stat-number">{{todayTrips}}</div>
							</div>
							<div class="stat-icon bg-info bg-opacity-20 text-info">
								<i class="fas fa-road"></i>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Alerts & Live Status -->
			<div class="row g-4 mb-5">
				<div class="col-lg-6 fade-in">
					<div class="alert-section h-100">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h6>
								<i class="fas fa-exclamation-triangle text-warning me-2"></i>Emergency
								Calls
							</h6>
							<span class="badge bg-danger">{{pendingCalls}} Pending</span>
						</div>
						<div ng-repeat="call in recentCalls track by $index"
							class="alert-item">
							<div>
								<strong>{{call.location}}</strong>
								<div class="text-muted small">{{call.type}}</div>
							</div>
							<span class="status-badge bg-warning text-dark">{{call.time}}</span>
						</div>
					</div>
				</div>
				<div class="col-lg-6 fade-in">
					<div class="alert-section h-100">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h6>
								<i class="fas fa-ambulance text-primary me-2"></i>Ambulance
								Status
							</h6>
							<span class="badge bg-success">{{availableAmbulances}}
								Ready</span>
						</div>
						<div ng-repeat="ambulance in ambulances track by ambulance.id"
							class="alert-item">
							<div>
								<strong>{{ambulance.name}}</strong>
								<div class="text-muted small">{{ambulance.driver}}</div>
							</div>
							<span class="badge {{ambulance.statusClass}}">{{ambulance.status}}</span>
						</div>
					</div>
				</div>
			</div>

			<!-- Tables & Charts -->
			<div class="row g-4">
				<div class="col-lg-6">
					<div class="card table-card fade-in">
						<div class="card-header">
							<h5 class="mb-0">
								<i class="fas fa-list me-2"></i>Recent Dispatches
							</h5>
						</div>
						<div class="card-body p-0">
							<div class="table-responsive">
								<table class="table mb-0">
									<thead>
										<tr>
											<th>Ambulance</th>
											<th>Call</th>
											<th>Status</th>
											<th>ETA</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="dispatch in recentDispatches track by $index">
											<td><i class="fas fa-ambulance text-primary me-2"></i>{{dispatch.ambulance}}</td>
											<td>{{dispatch.call}}</td>
											<td><span class="badge bg-success">En Route</span></td>
											<td>{{dispatch.eta}}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="card table-card fade-in">
						<div class="card-header">
							<h5 class="mb-0">
								<i class="fas fa-users me-2"></i>Driver Status
							</h5>
						</div>
						<div class="card-body p-0">
							<div class="table-responsive">
								<table class="table mb-0">
									<thead>
										<tr>
											<th>Driver</th>
											<th>Ambulance</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="driver in drivers track by $index">
											<td>{{driver.name}}</td>
											<td>{{driver.ambulance}}</td>
											<td><span class="badge {{driver.statusClass}}">{{driver.status}}</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

				<!-- Response Time Chart -->
				<div class="col-12">
					<div class="card table-card fade-in">
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<h5 class="mb-0">
								<i class="fas fa-chart-line me-2"></i>Response Times (Last 24h)
							</h5>
							<select class="form-select form-select-sm" style="width: 120px;">
								<option>Today</option>
								<option>7 Days</option>
								<option>30 Days</option>
							</select>
						</div>
						<div class="card-body p-2">
							<canvas id="responseChart" height="200"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Angular Controller & Sidebar Toggle -->
	<script>
        // Sidebar Toggle
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.getElementById('sidebar');
            const sidebarToggle = document.getElementById('sidebarToggle');
            const sidebarOverlay = document.getElementById('sidebarOverlay');

            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('show');
            });

            sidebarOverlay.addEventListener('click', function() {
                sidebar.classList.remove('active');
                sidebarOverlay.classList.remove('show');
            });
        });

        // Angular App
        angular.module('AmbulanceApp', [])
        .controller('DashboardController', ['$scope', '$interval', function($scope, $interval) {
            // Initial data
            $scope.totalAmbulances = 25;
            $scope.availableAmbulances = 12;
            $scope.activeCalls = 3;
            $scope.todayTrips = 18;
            $scope.pendingCalls = 2;

            // Ambulance Status
            $scope.ambulances = [
                {id: 1, name: 'AMB-001', driver: 'John Doe', status: 'Available', statusClass: 'status-available'},
                {id: 2, name: 'AMB-002', driver: 'Jane Smith', status: 'En Route', statusClass: 'status-busy'},
                {id: 3, name: 'AMB-003', driver: 'Mike Johnson', status: 'Maintenance', statusClass: 'status-maintenance'}
            ];

            // Recent Calls
            $scope.recentCalls = [
                {location: 'City Hospital', type: 'Heart Attack', time: '2 min ago'},
                {location: 'Main Street 123', type: 'Accident', time: '5 min ago'},
                {location: 'Park Avenue', type: 'Fall', time: '8 min ago'}
            ];

            // Recent Dispatches
            $scope.recentDispatches = [
                               {ambulance: 'AMB-001', call: 'Heart Attack - City Hospital', status: 'En Route', eta: '5 min'},
                {ambulance: 'AMB-002', call: 'Accident - Main Street', status: 'Arrived', eta: '0 min'},
                {ambulance: 'AMB-003', call: 'Fall - Park Avenue', status: 'En Route', eta: '3 min'}
            ];

            // Drivers
            $scope.drivers = [
                {name: 'John Doe', ambulance: 'AMB-001', status: 'Available', statusClass: 'bg-success'},
                {name: 'Jane Smith', ambulance: 'AMB-002', status: 'Busy', statusClass: 'bg-warning'},
                {name: 'Mike Johnson', ambulance: 'AMB-003', status: 'Maintenance', statusClass: 'bg-danger'}
            ];

            // Live Updates Simulation
            $interval(function() {
                // Simulate live ambulance status changes
                const statuses = ['Available', 'En Route', 'Maintenance'];
                const statusClasses = ['status-available', 'status-busy', 'status-maintenance'];
                
                $scope.ambulances.forEach(function(ambulance) {
                    const randomStatus = Math.floor(Math.random() * 3);
                    ambulance.status = statuses[randomStatus];
                    ambulance.statusClass = statusClasses[randomStatus];
                });

                // Update counters
                $scope.availableAmbulances = Math.floor(Math.random() * 15) + 8;
                $scope.activeCalls = Math.floor(Math.random() * 5) + 1;
                
                // Update available count based on ambulances
                const availableCount = $scope.ambulances.filter(a => a.status === 'Available').length;
                $scope.availableAmbulances = availableCount;
            }, 5000); // Update every 5 seconds

            // Chart Data
            $scope.initChart = function() {
                const ctx = document.getElementById('responseChart');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '23:59'],
                        datasets: [{
                            label: 'Avg Response Time (min)',
                            data: [8.2, 7.5, 6.8, 9.1, 7.2, 8.5, 6.9],
                            borderColor: 'rgba(220, 53, 69, 1)',
                            backgroundColor: 'rgba(220, 53, 69, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 12,
                                ticks: { stepSize: 2 }
                            }
                        },
                        plugins: {
                            legend: { display: false }
                        }
                    }
                });
            };

            // Initialize chart after DOM ready
            setTimeout($scope.initChart, 100);
        }]);
    </script>
</body>
</html>