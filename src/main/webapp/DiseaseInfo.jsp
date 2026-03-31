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

<!DOCTYPE html>
<html>
<head>
<title>Disease Info Page</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="style.css">
<style>
.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 250px;
	height: 100vh;
	overflow-y: auto;
	overflow-x: hidden;
	padding-top: 20px;
	background: #1e1e2f;
}

body {
	background: #f8f9fa; /* light grey background */
	font-family: 'Segoe UI', sans-serif;
	color: #212529; /* dark text */
}

/* MAIN CONTENT */
.main-content {
	margin-left: 250px;
	padding: 20px;
	height: 100vh;
	overflow: hidden; /* since you only want sidebar scroll */
}

/* PAGE TITLE */
.page-title {
	font-size: 28px;
	font-weight: bold;
	color: #0d6efd; /* Bootstrap blue */
	margin-bottom: 20px;
}

/* CARDS */
.card-custom {
	background: #ffffff;
	border-radius: 12px;
	padding: 20px;
	border: 1px solid #dee2e6;
	transition: 0.3s;
	color: #212529;
}

.card-custom:hover {
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
}

/* FEATURES */
.feature-box {
	text-align: center;
	padding: 15px;
}

.feature-box i {
	font-size: 30px;
	color: #0d6efd;
	margin-bottom: 10px;
}

/* STATS */
.stats-box {
	background: #ffffff;
	border: 1px solid #dee2e6;
	padding: 15px;
	border-radius: 10px;
	text-align: center;
}

.stats-box h3 {
	color: #0d6efd;
}
/* MAIN CONTENT */
.main-content {
	margin-left: 250px;
	padding: 20px;
	height: 100vh;
	overflow-y: auto;
}

/* TITLE */
.page-title {
	font-size: 28px;
	font-weight: bold;
	color: #0d6efd;
	margin-bottom: 20px;
}

/* SEARCH BAR */
.search-box {
	max-width: 400px;
}

.disease-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
}

.disease-card {
	background: #ffffff;
	border-radius: 12px;
	border: 1px solid #dee2e6;
	padding: 15px;
	transition: 0.3s;
}

.disease-card:hover {
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
	transform: translateY(-3px);
}

.disease-card h6 {
	color: #0d6efd;
	font-weight: 600;
	margin-bottom: 10px;
}

.disease-card p {
	font-size: 14px;
	color: #212529;
	margin-bottom: 8px;
}
</style>

</head>
<body>
	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="sidebar-header d-flex justify-content-between align-items-center">
			<h4 class="mb-0">Disease Information</h4>
			<button class="btn btn-sm btn-outline-light d-md-none"
				id="sidebarToggle">
				<i class="bi bi-x"></i>
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
				<li class="nav-item"><a class="nav-link" href="Ambulance.jsp">
						<i class="fas fa-ambulance"></i> Ambulance Service
				</a></li>
				<li class="nav-item"><a class="nav-link" href="chatbot"> <i
						class="fas fa-robot"></i> Chatbot
				</a></li>
				<li class="nav-item"><a class="nav-link"
					href="about.jsp"> <i class="bi bi-info-circle"></i> About
				</a></li>
				<li class="nav-item"><a class="nav-link" href="contact.jsp">
						<i class="bi bi-person-rolodex"></i> Contact Us
				</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="DiseaseInfo.jsp"> <i class="fa fa-book-medical"></i>
						Disease Info
				</a></li>
			</ul>
		</div>
	</div>
	<div class="main-content">

		<!-- PAGE TITLE -->
		<div class="page-title my-2">
			<i class="bi bi-heart-pulse"></i> Disease Information
		</div>

		<!-- SEARCH -->
		<input type="text" id="searchInput" class="form-control search-box"
			placeholder="Search disease...">

		<!-- SINGLE CONTAINER GRID -->
		<div class="disease-grid my-3" id="diseaseContainer">

			<!-- Disease Card Example -->
			<div class="disease-card disease-item">
				<h6>Diabetes</h6>
				<p>
					<strong>Symptoms:</strong> Increased thirst, frequent urination,
					fatigue.
				</p>
				<p>Diabetes is a chronic condition that affects how your body
					converts food into energy. Over time, high blood sugar can lead to
					heart disease, kidney damage, vision problems, and other
					complications.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Hypertension</h6>
				<p>
					<strong>Symptoms:</strong> Headaches, dizziness, shortness of
					breath.
				</p>
				<p>Hypertension, or high blood pressure, occurs when the force
					of blood against artery walls is too high. If untreated, it can
					increase the risk of heart attack, stroke, and kidney problems.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Dengue</h6>
				<p>
					<strong>Symptoms:</strong> High fever, severe headache, joint pain,
					rash.
				</p>
				<p>Dengue is a mosquito-borne viral infection common in tropical
					regions. Severe cases can cause bleeding, low blood pressure, and
					organ failure.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>COVID-19</h6>
				<p>
					<strong>Symptoms:</strong> Fever, cough, fatigue, loss of taste or
					smell.
				</p>
				<p>COVID-19 is a contagious respiratory illness caused by
					SARS-CoV-2. It can range from mild symptoms to severe respiratory
					distress, sometimes requiring hospitalization.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Asthma</h6>
				<p>
					<strong>Symptoms:</strong> Shortness of breath, wheezing, chest
					tightness.
				</p>
				<p>Asthma is a condition in which airways become inflamed and
					narrow. Triggers can include allergens, exercise, or respiratory
					infections, and symptoms vary from mild to severe attacks.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Heart Disease</h6>
				<p>
					<strong>Symptoms:</strong> Chest pain, fatigue, shortness of
					breath, palpitations.
				</p>
				<p>Heart disease refers to various conditions affecting the
					heart, such as coronary artery disease. Risk factors include high
					blood pressure, smoking, obesity, and diabetes.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Cancer</h6>
				<p>
					<strong>Symptoms:</strong> Unexplained weight loss, fatigue, lumps,
					persistent pain.
				</p>
				<p>Cancer is a group of diseases characterized by uncontrolled
					cell growth. It can affect almost any organ, and early detection is
					crucial for effective treatment.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Tuberculosis</h6>
				<p>
					<strong>Symptoms:</strong> Persistent cough, weight loss, fever,
					night sweats.
				</p>
				<p>Tuberculosis is a bacterial infection that primarily affects
					the lungs. It spreads through the air and requires long-term
					antibiotic treatment.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Hepatitis</h6>
				<p>
					<strong>Symptoms:</strong> Jaundice, fatigue, abdominal pain,
					nausea.
				</p>
				<p>Hepatitis is inflammation of the liver, often caused by viral
					infections. Chronic hepatitis can lead to liver damage, cirrhosis,
					or liver cancer.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Kidney Disease</h6>
				<p>
					<strong>Symptoms:</strong> Swelling, fatigue, changes in urination,
					high blood pressure.
				</p>
				<p>Chronic kidney disease occurs when the kidneys lose function
					over time. It can result from diabetes, hypertension, or other
					conditions, potentially leading to kidney failure.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Influenza</h6>
				<p>
					<strong>Symptoms:</strong> Fever, cough, sore throat, body aches,
					fatigue.
				</p>
				<p>Influenza, or the flu, is a contagious respiratory illness
					caused by influenza viruses. It can cause mild to severe illness
					and lead to hospitalization, especially in the elderly or
					immunocompromised.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Arthritis</h6>
				<p>
					<strong>Symptoms:</strong> Joint pain, swelling, stiffness, reduced
					range of motion.
				</p>
				<p>Arthritis is inflammation of the joints, which can be caused
					by autoimmune disease, wear and tear, or infection. It may affect
					mobility and quality of life if untreated.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Thyroid Disorder</h6>
				<p>
					<strong>Symptoms:</strong> Weight changes, fatigue, hair loss,
					temperature sensitivity.
				</p>
				<p>Thyroid disorders occur when the thyroid gland produces too
					much or too little hormone. Conditions include hypothyroidism,
					hyperthyroidism, and goiter, affecting metabolism and energy.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Stroke</h6>
				<p>
					<strong>Symptoms:</strong> Sudden numbness, confusion, trouble
					speaking, loss of balance.
				</p>
				<p>Stroke occurs when blood flow to part of the brain is
					interrupted or reduced. Quick medical intervention is crucial to
					prevent permanent damage or death.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Skin Allergy</h6>
				<p>
					<strong>Symptoms:</strong> Redness, itching, rash, swelling.
				</p>
				<p>Skin allergies occur when the immune system reacts to
					substances like pollen, food, or chemicals. Treatments include
					antihistamines and avoiding triggers.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Migraine</h6>
				<p>
					<strong>Symptoms:</strong> Severe headache, nausea, sensitivity to
					light/sound.
				</p>
				<p>Migraine is a neurological condition characterized by
					intense, recurring headaches. Triggers vary and can include stress,
					diet, or hormonal changes.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Eye Infection</h6>
				<p>
					<strong>Symptoms:</strong> Redness, itching, discharge, blurred
					vision.
				</p>
				<p>Eye infections can be caused by bacteria, viruses, or fungi.
					They may affect the cornea, conjunctiva, or eyelids and require
					proper treatment to avoid complications.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Ear Infection</h6>
				<p>
					<strong>Symptoms:</strong> Ear pain, fluid drainage, hearing loss,
					fever.
				</p>
				<p>Ear infections are common in children and can affect the
					middle or outer ear. They often result from bacteria or viruses and
					may require antibiotics.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Gastritis</h6>
				<p>
					<strong>Symptoms:</strong> Stomach pain, nausea, bloating,
					indigestion.
				</p>
				<p>Gastritis is inflammation of the stomach lining, often caused
					by infection, alcohol, or medications. Chronic gastritis can lead
					to ulcers or digestive issues.</p>
			</div>

			<div class="disease-card disease-item">
				<h6>Malaria</h6>
				<p>
					<strong>Symptoms:</strong> Fever, chills, sweating, headache,
					fatigue.
				</p>
				<p>Malaria is a mosquito-borne infectious disease caused by
					Plasmodium parasites. Severe malaria can damage organs and be fatal
					if untreated.</p>
			</div>

		</div>

	</div>

	<!-- Search Script -->
	<script>
document.getElementById("searchInput").addEventListener("keyup", function () {
    let filter = this.value.toLowerCase();
    let items = document.querySelectorAll(".disease-item");
    items.forEach(item => {
        let text = item.innerText.toLowerCase();
        item.style.display = text.includes(filter) ? "block" : "none";
    });
});
</script>
	<!-- FOOTER FIXED -->
	<div>
		<footer class="text-center mt-4 pb-3"> &copy; 2026 Hospital
			Reception ERP System. All rights reserved. </footer>
	</div>
	<script>
document.getElementById("searchInput").addEventListener("keyup", function () {
	let value = this.value.toLowerCase();
	let items = document.querySelectorAll(".disease-item");

	items.forEach(item => {
		let text = item.innerText.toLowerCase();
		item.style.display = text.includes(value) ? "block" : "none";
	});
});
</script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
		integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
		crossorigin="anonymous"></script>

	</div>
</body>
</html>
