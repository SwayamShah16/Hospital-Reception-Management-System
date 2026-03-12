# Hospital Reception Management System

A comprehensive Java-based desktop application designed to streamline hospital reception operations, including patient registration, appointment scheduling, and receptionist management.

## Overview

The Hospital Reception Management System is a robust application that automates and manages various reception-related tasks in a hospital environment. It provides an intuitive interface for receptionists to efficiently handle patient check-ins, maintain patient records, schedule appointments, and manage billing information.

## Features

### 1. **Patient Management**
   - Register new patients with comprehensive personal and medical information
   - Maintain and update patient records
   - Search and retrieve patient information quickly
   - Track patient contact details and medical history

### 2. **Appointment Scheduling**
   - Schedule appointments with doctors
   - View appointment availability
   - Manage appointment cancellations and rescheduling
   - Generate appointment reminders
   - Calendar-based appointment tracking

### 3. **Receptionist Management**
   - Add and manage receptionist profiles
   - Track receptionist schedules and shifts
   - Maintain receptionist credentials and contact information
   - Role-based access control

### 4. **Billing & Payment**
   - Generate invoices for services rendered
   - Track payment status
   - Manage patient billing records
   - Generate financial reports

### 5. **Department Management**
   - Manage hospital departments
   - Assign doctors to departments
   - Track department information

### 6. **User Authentication**
   - Secure login system
   - Role-based access control (Admin, Receptionist, Doctor)
   - Password management

## Technology Stack

- **Language**: Java
- **IDE**: Eclipse IDE
- **Database**: MySQL/SQL
- **GUI Framework**: Swing (Java GUI components)
- **Architecture**: Object-Oriented Programming (OOP)

## Project Structure

```
Hospital-Reception-Management-System/
├── src/
│   └── main/
│       ├── Patient.java
│       ├── Receptionist.java
│       ├── Appointment.java
│       ├── Doctor.java
│       ├── Department.java
│       ├── Billing.java
│       ├── Invoice.java
│       ├── User.java
│       ├── LoginFrame.java
│       ├── MainWindow.java
│       └── [Other GUI and utility classes]
├── .classpath
├── .project
├── .settings/
└── README.md
```

## Getting Started

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- MySQL Server
- Eclipse IDE (or any Java IDE)
- JDBC driver for MySQL

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/SwayamShah16/Hospital-Reception-Management-System.git
   cd Hospital-Reception-Management-System
   ```

2. **Import Project in Eclipse**
   - Open Eclipse IDE
   - File → Import → Existing Projects into Workspace
   - Select the cloned repository folder
   - Click Finish

3. **Database Setup**
   - Create a MySQL database for the hospital system
   - Update database connection details in the configuration file
   - Run database initialization scripts to create necessary tables

4. **Configure Database Connection**
   - Update database credentials (host, username, password, database name)
   - Ensure MySQL JDBC driver is added to project classpath

5. **Compile and Run**
   - Build the project (Project → Build Project)
   - Run the application (Run → Run)
   - Login with default credentials

## Usage

### For Receptionists

1. **Patient Registration**
   - Open the application and login with receptionist credentials
   - Navigate to Patient Management
   - Click "Register New Patient"
   - Fill in patient details and save

2. **Schedule Appointments**
   - Go to Appointment Scheduling
   - Select patient from list
   - Choose available doctor and time slot
   - Confirm appointment

3. **Check-in Patient**
   - Search for patient by ID or name
   - Verify appointment details
   - Process check-in

### For Administrators

1. **Manage Receptionists**
   - Add/edit/delete receptionist accounts
   - Assign shifts and schedules

2. **Generate Reports**
   - View appointment statistics
   - Generate billing reports
   - Track system usage

## Key Classes

- **Patient**: Stores patient information and medical history
- **Receptionist**: Manages receptionist profiles and credentials
- **Appointment**: Handles appointment scheduling and management
- **Doctor**: Stores doctor information and specializations
- **Department**: Manages department details
- **Billing**: Processes patient billing and payments
- **LoginFrame**: Handles user authentication
- **MainWindow**: Main application interface

## Database Schema

The system uses the following main tables:
- `patients` - Patient records
- `receptionists` - Receptionist information
- `appointments` - Appointment records
- `doctors` - Doctor details
- `departments` - Department information
- `billing` - Billing and invoice information
- `users` - User accounts and credentials

## System Requirements

- **RAM**: Minimum 2 GB
- **Storage**: Minimum 500 MB
- **OS**: Windows/Linux/Mac with Java support
- **Network**: For database connectivity

## Future Enhancements

- Patient portal for self-service appointment booking
- SMS/Email notifications for appointments
- Mobile application for appointment scheduling
- Integration with payment gateways
- Advanced analytics and reporting
- Telemedicine capabilities

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

**Swayam Shah**

GitHub: [@SwayamShah16](https://github.com/SwayamShah16)

## Support

For issues, bugs, or feature requests, please open an issue on the GitHub repository.

## Acknowledgments

- Hospital management best practices
- Java Swing documentation and tutorials
- Open-source community for valuable resources