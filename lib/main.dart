import 'package:flutter/material.dart';
import 'auth/LoginPage.dart';
import 'auth/SignupPage.dart';
import 'catalog.dart';
import 'description.dart';
import 'hotel/hotel.dart';
import 'hotel/hotelRegion.dart';
import 'restaurant/restaurant.dart';
import 'restaurant/restaurantType.dart';
import 'restaurant/RestaurantOrdersPage.dart';
import '../database_helper.dart';
import 'hotel/BookedHotelsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_dashboard.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(useMaterial3: true),
      initialRoute: '/login',
      routes: {
        '/': (context) => MainScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/beach': (context) => DescriptionPage(title: 'Beach'),
        '/cuisine': (context) => DescriptionPage(title: 'Cuisine'),
        '/Hiking': (context) => DescriptionPage(title: 'Hiking'),
        '/Ice': (context) => DescriptionPage(title: 'Ice'),
        '/desert': (context) => DescriptionPage(title: 'Desert'),
        '/old cities': (context) => DescriptionPage(title: 'Old Cities'),
        '/Historical places': (context) =>
            DescriptionPage(title: 'Historical Places'),
        '/River': (context) => DescriptionPage(title: 'River'),
        '/hotelRegion': (context) => HotelRegionPage(),
        '/hotels': (context) => HotelPage(
            region: ModalRoute.of(context)?.settings.arguments as String ??
                'Sahel'),
        '/restaurantType': (context) => RestaurantTypePage(),
        '/restaurant': (context) => RestaurantPage(
            type: ModalRoute.of(context)?.settings.arguments as String ??
                'Modern'),
        '/bookedHotels': (context) => BookedHotelsPage(),
        '/OredersPage': (context) => RestaurantOrdersPage(),
        '/userDashboard': (context) => UserDashboard(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _loggedInUsername;

  @override
  void initState() {
    super.initState();
    _getLoggedInUsername();
  }

  Future<void> _getLoggedInUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loggedInUsername = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 100, 182),
        toolbarHeight: 60,
        elevation: 20,
        title: Image.asset(
          'assets/images/logo.png', 
          height: 40,  
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Hotels'),
              onTap: () {
                Navigator.pushNamed(context, '/hotelRegion');
              },
            ),
            ListTile(
              title: const Text('Booked Hotels'),
              onTap: () {
                Navigator.pushNamed(context, '/bookedHotels');
              },
            ),
            ListTile(
              title: const Text('Restaurant Orders'),
              onTap: () {
                Navigator.pushNamed(context, '/OredersPage');
              },
            ),
            ListTile(
              title: const Text('Restaurants'),
              onTap: () {
                Navigator.pushNamed(context, '/restaurantType');
              },
            ),
            if (_loggedInUsername == 'admin')
              ListTile(
                title: const Text('Admin Dashboard'),
                onTap: () {
                  Navigator.pushNamed(context, '/userDashboard');
                },
              ),
          ],
        ),
      ),
      body: Catalog(),
    );
  }
}
