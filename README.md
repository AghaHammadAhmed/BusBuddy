### **README for BusBuddy**

---

# **BusBuddy - Intelligent Van Tracking and Management System**

**BusBuddy** is a safe, efficient, and user-friendly solution designed to revolutionize daily commuting for parents, students, and employees. With real-time tracking, optimized routes, and smart notifications, BusBuddy ensures reliable and secure transportation management.

---

## **Features**

### **User Module (Parents/Students/Employees)**
- **Real-Time Van Tracking**: View live locations of vans on a map.  
- **Proximity Alerts**: Notifications 10–15 minutes before the van arrives.  
- **Driver and Van Information**: Basic details of the van and driver.  
- **Payment Reminders**: Alerts for upcoming payment dues.  
- **Safety Notifications**: Alerts for unusual detours or route deviations.  
- **Check-In/Check-Out**: Notifications when a child boards or exits the van.  
- **Emergency Alerts**: Panic button to notify admins and drivers.  

### **Driver Module**
- **Route Management**: Start and end routes, mark pickups, and track drop-offs.  
- **Optimized Routes**: AI-driven suggestions for faster, less congested paths.  
- **Emergency Notifications**: Quick alerts for breakdowns or delays.  

### **Admin Module**
- **User and Van Assignment**: Automatic suggestions based on proximity and schedules.  
- **Real-Time Monitoring**: Comprehensive dashboard for tracking all vans.  
- **Payment Management**: Overdue payment warnings and automated fee calculations.  
- **Analytics**: Monthly reports on efficiency, payments, and driver performance.

---

## **Tech Stack**
- **Frontend**: React Native (Mobile), React.js (Web)  
- **Backend**: Node.js, Express.js  
- **Database**: MongoDB  
- **APIs**: Google Maps API, Payment Gateway Integration  
- **AI System**: Intelligent route optimization and traffic predictions.  

---

## **Installation Instructions**

### **Requirements**
- Node.js (v14 or higher)
- MongoDB
- Git
- React Native CLI (for mobile development)

### **Steps**
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/BusBuddy.git
   cd BusBuddy
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up the database:
   - Start your MongoDB server.
   - Update the database connection string in `config.js`.

4. Start the backend server:
   ```bash
   npm run server
   ```
5. Start the frontend (React):
   ```bash
   cd client
   npm start
   ```
6. For the mobile app, navigate to the mobile app directory:
   ```bash
   cd mobile
   npm install
   npm run start
   ```

---

## **How to Use**
1. **Sign Up**: Users can register as parents, students, or employees.  
2. **Login**: Access the app to view real-time tracking and alerts.  
3. **Driver Dashboard**: Manage routes and pickups via the mobile app.  
4. **Admin Portal**: Manage users, drivers, vans, and generate reports.

---

## **Schema**

### **Admin**
- `adminID`, `name`, `email`, `password`

### **User**
- `userID`, `name`, `email`, `age`, `gender`, `phone`, `address`, `password`

### **Driver**
- `driverID`, `name`, `age`, `phone`, `drivingLicenseNumber`, `password`

### **Vans**
- `vanNumber`, `plateNumber`, `capacity`, `specifiedRoute`, `driverID`

### **Ride**
- `rideID`, `userID`, `busID`, `startLocation`, `endLocation`, `rideTime`, `status`

### **Payment**
- `paymentID`, `userID`, `rideID`, `amount`, `method`, `paymentDate`

---

## **Contributing**
We welcome contributions to improve BusBuddy!  
1. Fork the repository.  
2. Create a new branch for your feature: `git checkout -b feature-name`.  
3. Commit your changes: `git commit -m "Add feature description"`.  
4. Push to the branch: `git push origin feature-name`.  
5. Open a pull request.  

---


## **Contact**
For any queries or feedback, please contact:  
- **Email**: support@busbuddy.com  
