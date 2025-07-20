# Student Expense Tracker 💰

A comprehensive Flutter mobile application designed specifically for students to manage their finances, track expenses, set budgets, and achieve savings goals.

## 📱 Features

### Core Features
- **Expense Tracking**: Log and categorize daily expenses with detailed descriptions
- **Budget Management**: Set monthly budgets for different categories with overspending alerts
- **Savings Goals**: Create and track progress towards financial goals
- **Visual Reports**: Interactive charts and graphs showing spending patterns
- **Offline Storage**: All data stored locally using SQLite for offline access

### Additional Features
- **Smart Notifications**: Budget alerts and savings reminders
- **Category-based Organization**: Pre-defined categories with custom icons
- **Time-based Filtering**: View expenses by week, month, or custom date ranges
- **Progress Tracking**: Visual progress indicators for budgets and savings goals
- **Data Export**: Generate reports and summaries

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   \`\`\`bash
   git clone https://github.com/yourusername/student-expense-tracker.git
   cd student-expense-tracker
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   flutter pub get
   \`\`\`

3. **Run the app**
   \`\`\`bash
   flutter run
   \`\`\`

### Building APK
\`\`\`bash
flutter build apk --release
\`\`\`

The APK file will be generated in `build/app/outputs/flutter-apk/app-release.apk`

## 📁 Project Structure

\`\`\`
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── expense.dart
│   ├── budget.dart
│   └── savings_goal.dart
├── services/                 # Business logic services
│   ├── database_service.dart
│   └── notification_service.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── expenses_screen.dart
│   ├── budget_screen.dart
│   ├── savings_screen.dart
│   └── reports_screen.dart
├── widgets/                  # Reusable UI components
│   ├── expense_card.dart
│   ├── budget_progress_card.dart
│   └── savings_goal_card.dart
└── utils/                    # Utility functions
    ├── app_theme.dart
    ├── constants.dart
    └── helpers.dart
\`\`\`



## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language
- **SQLite**: Local database for offline storage
- **fl_chart**: Beautiful charts and graphs
- **Material Design 3**: Modern UI design system

### Key Dependencies
\`\`\`yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0              # SQLite database
  path: ^1.8.3                 # Path manipulation
  intl: ^0.19.0                # Internationalization
  fl_chart: ^0.68.0            # Charts and graphs
  shared_preferences: ^2.2.2    # Simple data persistence
  flutter_local_notifications: ^17.1.2  # Local notifications
  permission_handler: ^11.3.1   # Permission management
\`\`\`

## 📊 Database Schema

### Expenses Table
\`\`\`sql
CREATE TABLE expenses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  amount REAL NOT NULL,
  category TEXT NOT NULL,
  date INTEGER NOT NULL,
  description TEXT
);
\`\`\`

### Budgets Table
\`\`\`sql
CREATE TABLE budgets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  category TEXT NOT NULL,
  amount REAL NOT NULL,
  month INTEGER NOT NULL,
  isActive INTEGER NOT NULL DEFAULT 1
);
\`\`\`

### Savings Goals Table
\`\`\`sql
CREATE TABLE savings_goals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  targetAmount REAL NOT NULL,
  currentAmount REAL NOT NULL DEFAULT 0,
  targetDate INTEGER NOT NULL,
  createdDate INTEGER NOT NULL,
  isCompleted INTEGER NOT NULL DEFAULT 0
);
\`\`\`

## 🎯 Key Features Implementation

### 1. Expense Categories
- Food & Dining 🍽️
- Transportation 🚗
- Books & Supplies 📚
- Entertainment 🎬
- Health & Fitness 💪
- Shopping 🛍️
- Bills & Utilities 💡
- Education 🎓
- Other 📦

### 2. Budget Alerts
- Automatic notifications when spending exceeds 80% of budget
- Visual indicators for budget status (green/orange/red)
- Monthly budget tracking and rollover

### 3. Savings Goals
- Progress tracking with visual indicators
- Target date monitoring
- Achievement celebrations
- Flexible contribution amounts

### 4. Reports & Analytics
- Category-wise spending breakdown
- Monthly spending trends
- Visual charts and graphs
- Export capabilities

## 🔧 Configuration

### Notification Setup
The app uses local notifications for budget alerts and savings reminders. Permissions are automatically requested on first launch.

### Theme Customization
Modify `lib/utils/app_theme.dart` to customize the app's appearance:
\`\`\`dart
static const Color primaryColor = Color(0xFF6366F1);
static const Color secondaryColor = Color(0xFF10B981);
\`\`\`

## 🚀 Performance Optimizations

- **Lazy Loading**: Expenses loaded on-demand
- **Database Indexing**: Optimized queries for better performance
- **Memory Management**: Proper disposal of controllers and streams
- **Efficient Widgets**: Use of const constructors and widget optimization

## 🧪 Testing

Run tests using:
\`\`\`bash
flutter test
\`\`\`

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- 🔄 Web (In development)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Community contributors and testers

## 📞 Support

If you encounter any issues or have questions:
1. Check the [Issues](https://github.com/yourusername/student-expense-tracker/issues) page
2. Create a new issue with detailed description
3. Contact the maintainer directly

---

**Made with ❤️ for students by students**
