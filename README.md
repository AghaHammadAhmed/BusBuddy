<<<<<<< HEAD
# busbuddy

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
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
- **Frontend**: Flutter (for cross-platform mobile app development)  
- **Backend**: Firebase (Authentication, Firestore, and Realtime Database)  
- **Database**: Firebase Firestore  
- **APIs**: Google Maps API, Payment Gateway Integration  
- **AI System**: Intelligent route optimization and traffic predictions.  

---

## **Installation Instructions**

### **Requirements**
- Flutter SDK (latest version)  
- Firebase account with enabled services (Firestore, Authentication)  
- Git  

### **Steps**
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/BusBuddy.git
   cd BusBuddy
   ```
2. Set up Firebase:
   - Create a new project on [Firebase Console](https://console.firebase.google.com/).  
   - Enable Firestore, Authentication, and Realtime Database.  
   - Download the `google-services.json` file and place it in the `android/app` directory.  
   - For iOS, download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory.  

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
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

## **License**
This project is licensed under the MIT License.  

---

## **Contact**
For any queries or feedback, please contact:  
- **Email**: support@busbuddy.com  
- **GitHub**: [https://github.com/yourusername/BusBuddy](https://github.com/yourusername/BusBuddy)  
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
