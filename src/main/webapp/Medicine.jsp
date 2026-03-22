<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" ng-app="MedicineApp">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hospital Medicine Inventory Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Angular CDN -->
<script src="https://cdn.jsdelivr.net/npm/angular@1.8.2/angular.min.js"></script>
<style>
/* YOUR EXACT ORIGINAL STYLES + SIDEBAR FIX */
:root {
	--sidebar-width: 250px;
	--primary: #0d6efd;
	--primary-dark: #0b5ed7;
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
	font-family: 'Inter', sans-serif;
	background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	min-height: 100vh;
}

.sidebar {
	width: var(--sidebar-width);
	height: 100vh;
	position: fixed;
	left: 0;
	top: 0;
	background: linear-gradient(135deg, #0f2027, #2c5364);
	z-index: 1000;
	transition: transform 0.3s ease;
}

.main-content {
	margin-left: var(--sidebar-width) !important;
	min-height: 100vh;
	transition: margin-left 0.3s ease;
	background-color: #f8f9fc;
	padding-top: 2rem;
	padding-bottom: 2rem;
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

/* YOUR EXACT ORIGINAL STYLES (unchanged) */
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

.stat-card .card-body {
	padding: 1.5rem;
	position: relative;
	z-index: 2;
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
	background: linear-gradient(90deg, var(--primary), #6610f2);
}

.stat-warning::before {
	background: linear-gradient(90deg, var(--warning), #fd7e14);
}

.stat-success::before {
	background: linear-gradient(90deg, var(--success), #20c997);
}

.stat-danger::before {
	background: linear-gradient(90deg, var(--danger), #e83e8c);
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

.chart-card {
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.chart-card .card-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
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

.alert-badge {
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

.table tbody td {
	padding: 1rem;
	vertical-align: middle;
	border-color: #f1f3f4;
}

.table-hover tbody tr:hover {
	background-color: #f8f9ff;
	transform: scale(1.01);
}

.modal-content {
	border-radius: 20px;
	border: none;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.sidebar-header {
	padding: 1.5rem;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-menu {
	padding: 1rem 0;
}

.sidebar-menu .nav-link {
	color: rgba(255, 255, 255, 0.8);
	padding: 0.75rem 1.5rem;
	margin-bottom: 0.5rem;
	border-left: 3px solid transparent;
}

.sidebar-menu .nav-link:hover, .sidebar-menu .nav-link.active {
	color: white;
	background-color: rgba(255, 255, 255, 0.1);
	border-left: 3px solid white;
}

.sidebar-menu .nav-link i {
	margin-right: 10px;
	font-size: 1.1rem;
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
</style>
</head>
<body>
	<!-- Sidebar Overlay -->
	<div class="sidebar-overlay" id="sidebarOverlay"></div>

	<!-- Sidebar (YOUR EXACT CONTENT) -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Inventory Dashboard</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div class="sidebar-menu">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-tachometer-alt"></i> Dashboard
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="Patient.jsp"> <i class="fas fa-user-injured"></i> Patient
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Doctor.jsp">
						<i class="fas fa-user-md"></i> Doctor
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-calendar-check"></i> Appointments
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-bed"></i> Rooms
				</a></li>
				<li class="nav-item"><a class="nav-link active" href="Medicine.jsp"> <i
						class="fas fa-boxes"></i> Medical Inventory
				</a></li>
				<li class="nav-item"><a class="nav-link" href="Ambulance.jsp"> <i
						class="fas fa-boxes"></i> Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link" href=""> <i
						class="fas fa-robot"></i> Chatbot
				</a></li>
			</ul>
		</div>
	</div>

	<!-- Main Content with Angular -->
	<div class="main-content" ng-controller="MedicineController">
		<div class="container-fluid pt-5">
			<!-- Stats Cards with LIVE ANGULAR DATA -->
			<div class="row g-4 mb-5 fade-in">
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-primary text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Total Medicines</h6>
								<div class="stat-number">{{totalMedicines}}</div>
							</div>
							<div class="stat-icon bg-white bg-opacity-20">
								<i class="fas fa-boxes"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-warning text-dark h-100">
						<div class="card-body p-3">
							<div class="row">
								<div class="col-6">
									<h6 class="mb-2">Low Stock</h6>
									<div class="stat-number">{{lowStock}}</div>
								</div>
								<div class="col-6">
									<h6 class="mb-2">No Stock</h6>
									<div class="stat-number text-danger">{{noStock}}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-success text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Total Value</h6>
								<div class="stat-number">{{totalValue | number:0}}</div>
							</div>
							<div class="stat-icon bg-white bg-opacity-20">
								<i class="fas fa-dollar-sign"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="card stat-card stat-danger text-dark h-100">
						<div
							class="card-body d-flex justify-content-between align-items-center">
							<div>
								<h6 class="mb-2 opacity-75">Expiring Soon</h6>
								<div class="stat-number">{{expiringSoon}}</div>
							</div>
							<div class="stat-icon bg-white bg-opacity-20">
								<i class="fas fa-clock"></i>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- LIVE Alerts with Angular -->
			<div class="row g-4 mb-5">
				<div class="col-lg-6 fade-in">
					<div class="alert-section h-100">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h6>
								<i class="fas fa-exclamation-triangle text-warning me-2"></i>Low
								Stock Alerts
							</h6>
							<span class="badge bg-warning">{{lowStock}} items</span>
						</div>
						<div ng-repeat="item in lowStockItems track by $index"
							class="alert-item">
							<span>{{item.name}}</span> <span
								class="alert-badge bg-warning text-dark">{{item.stock}}/{{item.total}}</span>
						</div>
					</div>
				</div>
				<div class="col-lg-6 fade-in">
					<div class="alert-section h-100">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h6>
								<i class="fas fa-clock text-danger me-2"></i>Expiring Soon
							</h6>
							<span class="badge bg-danger">{{expiringSoon}} items</span>
						</div>
						<div ng-repeat="exp in expiringItems track by $index"
							class="alert-item">
							<span>{{exp.name}}</span> <span>{{exp.expiry}}</span>
						</div>
					</div>
				</div>
			</div>

			<!-- YOUR EXACT TABLES with Angular -->
			<div class="row g-4">
				<div class="col-lg-6">
					<div class="card table-card fade-in">
						<div class="card-header">
							<h5 class="mb-0">
								<i class="fas fa-history me-2"></i>Recent Transactions
							</h5>
						</div>
						<div class="card-body p-0">
							<div class="table-responsive">
								<table class="table mb-0">
									<thead>
										<tr>
											<th>Medicine</th>
											<th>Type</th>
											<th>Qty</th>
											<th>Date</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="trans in recentTransactions track by $index">
											<td>{{trans.medicine}}</td>
											<td><span class="badge {{trans.typeClass}}">{{trans.type}}</span></td>
											<td>{{trans.qty}}</td>
											<td>{{trans.date}}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-6">
					<div class="card table-card fade-in">
						<div class="card-header d-flex justify-content-between">
							<h5 class="mb-0">
								<i class="fas fa-pills me-2"></i>Quick Actions
							</h5>
						</div>
						<div class="card-body p-0">
							<div class="table-responsive">
								<table class="table mb-0">
									<thead>
										<tr>
											<th>Medicine</th>
											<th>Stock</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="quick in quickActions track by $index">
											<td>{{quick.medicine}}</td>
											<td>{{quick.stock}}</td>
											<td><span class="badge {{quick.statusClass}}">{{quick.status}}</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

				<!-- LIVE Chart -->
				<div class="col-lg-6 mx-auto">
					<div class="card chart-card fade-in">
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<h5 class="mb-0">
								<i class="fas fa-chart-pie me-1"></i>Stock Status Overview
							</h5>
							<select class="form-select form-select-sm" style="width: 120px;"
								ng-model="chartPeriod">
								<option>Last 30 days</option>
								<option>Last 7 days</option>
								<option>Last month</option>
							</select>
						</div>
						<div class="card-body p-2">
							<canvas id="stockChart" height="200"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- YOUR EXACT MODAL (unchanged) -->
	<div class="modal fade" id="addStockModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header border-0">
					<h5 class="modal-title">
						<i class="fas fa-plus-circle text-success me-2"></i>Add New Stock
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label">Medicine Name</label> <select
									class="form-select">
									<option>Augmentin 625mg</option>
									<option>Paracetamol 500mg</option>
									<option>Metformin 500mg</option>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label">Batch Number</label> <input
									type="text" class="form-control">
							</div>
							<div class="col-md-4 mb-3">
								<label class="form-label">Quantity</label> <input type="number"
									class="form-control">
							</div>
							<div class="col-md-4 mb-3">
								<label class="form-label">Unit Price</label> <input
									type="number" class="form-control" step="0.01">
							</div>
							<div class="col-md-4 mb-3">
								<label class="form-label">Expiry Date</label> <input type="date"
									class="form-control">
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">Supplier</label> <select
								class="form-select">
								<option>GSK Pharmaceuticals</option>
								<option>Cipla Ltd</option>
								<option>Sun Pharma</option>
							</select>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- YOUR EXACT FOOTER -->
	<footer class="bg-dark text-white mt-5 py-4">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h6>
						<i class="fas fa-hospital me-2"></i>Hospital Inventory System
					</h6>
					<p class="opacity-75 mb-0">Advanced medicine management with
						real-time analytics</p>
				</div>
				<div class="col-md-6 text-md-end">
					<p class="mb-0 opacity-75">&copy; 2024 Hospital Inventory. All
						rights reserved.</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        // Sidebar Toggle (unchanged)
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

        // ANGULAR MEDICINE CONTROLLER - LIVE DATA
        angular.module('MedicineApp', [])
        .controller('MedicineController', ['$scope', '$interval', function($scope, $interval) {
            // Initial Data
            $scope.totalMedicines = 247;
            $scope.lowStock = 23;
            $scope.noStock = 12;
            $scope.totalValue = 145230;
            $scope.expiringSoon = 11;
            $scope.chartPeriod = 'Last 30 days';

            // Low Stock Items (LIVE)
            $scope.lowStockItems = [
                {name: 'Augmentin 625mg', stock: 8, total: 50},
                {name: 'Metformin 500mg', stock: 15, total: 75},
                {name: 'Paracetamol 500mg', stock: 45, total: 100}
            ];

            // Expiring Items (LIVE)
            $scope.expiringItems = [
                {name: 'Vitamin C 500mg', expiry: 'Aug 15, 2025'},
                {name: 'Amlodipine 5mg', expiry: 'Oct 20, 2025'}
            ];

            // Recent Transactions (LIVE)
            $scope.recentTransactions = [
                {medicine: 'Augmentin 625mg', type: 'Purchase', typeClass: 'bg-success', qty: 100, date: 'Today'},
                {medicine: 'Paracetamol 500mg', type: 'Issue', typeClass: 'bg-danger', qty: 25, date: '2 hrs ago'},
                {medicine: 'Metformin 500mg', type: 'Return', typeClass: 'bg-info', qty: 10, date: 'Yesterday'}
            ];

            // Quick Actions (LIVE)
            $scope.quickActions = [
                {medicine: 'Augmentin 625mg', stock: 8, status: 'Low Stock', statusClass: 'bg-danger'},
                {medicine: 'Paracetamol 500mg', stock: 45, status: 'Reorder', statusClass: 'bg-warning'},
                {medicine: 'Amlodipine 5mg', stock: 120, status: 'Available', statusClass: 'bg-success'}
            ];

            // LIVE UPDATES every 5 seconds
            $interval(function() {
                // Simulate stock changes
                $scope.lowStockItems.forEach(function(item) {
                    item.stock = Math.max(0, item.stock + (Math.random() > 0.7 ? 1 : -1));
                });

                // Update counters
                $scope.lowStock = $scope.lowStockItems.filter(item => item.stock < item.total * 0.2).length;
                $scope.noStock = Math.floor(Math.random() * 5) + 8;
                $scope.totalMedicines = 240 + Math.floor(Math.random() * 20);
                $scope.totalValue = 140000 + Math.floor(Math.random() * 10000);
                $scope.expiringSoon = 10 + Math.floor(Math.random() * 5);

                // Random transaction updates
                if (Math.random() > 0.8) {
                    $scope.recentTransactions.unshift({
                        medicine: 'Random Medicine',
                        type: Math.random() > 0.5 ? 'Purchase' : 'Issue',
                        typeClass: Math.random() > 0.5 ? 'bg-success' : 'bg-danger',
                        qty: Math.floor(Math.random() * 50) + 10,
                        date: 'Just now'
                    });
                    $scope.recentTransactions.pop(); // Keep 3 items
                }
            }, 5000);

            // Chart with Angular data
            $scope.initChart = function() {
                const ctx = document.getElementById('stockChart');
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Available ({{100 - lowStock - noStock}}%)', 'Low Stock ({{lowStock}}%)', 'Out of Stock ({{noStock}}%)'],
                        datasets: [{
                            data: [65 + Math.random() * 10, $scope.lowStock, $scope.noStock],
                            backgroundColor: [
                                'rgba(75, 192, 192, 0.8)',
                                'rgba(255, 206, 86, 0.8)',
                                'rgba(255, 99, 132, 0.8)'
                            ],
                            borderColor: [
                                'rgba(75, 192, 192, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(255, 99, 132, 1)'
                            ],
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { padding: 20, usePointStyle: true }
                            }
                        }
                    }
                });
            };

            // Re-init chart on data change
            $scope.$watch('lowStock + noStock', function() {
                if (window.stockChart) {
                    window.stockChart.destroy();
                    setTimeout($scope.initChart, 100);
                }
            });

            // Initialize
            setTimeout($scope.initChart, 100);
            window.stockChart = null;
        }]);

        // Custom Angular Filter for currency
        angular.module('MedicineApp').filter('number', function() {
            return function(input) {
                return input.toLocaleString();
            };
        });
    </script>
</body>
</html>