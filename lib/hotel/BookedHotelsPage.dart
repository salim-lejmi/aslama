import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BookingDetailsPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookedHotelsPage extends StatefulWidget {
  const BookedHotelsPage({Key? key}) : super(key: key);

  @override
  _BookedHotelsPageState createState() => _BookedHotelsPageState();
  void refreshBookedHotels() {
    final state = _BookedHotelsPageState();
    if (state.mounted) {
      state._loadBookedHotels();
    }
  }
}

class _BookedHotelsPageState extends State<BookedHotelsPage> {
  List<Map<String, dynamic>> _bookedHotels = [];

  @override
  void initState() {
    super.initState();
    _loadBookedHotels();
  }

  Future<void> _loadBookedHotels() async {
 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      final bookedHotels =
          await DatabaseHelper.instance.getBookedHotelsForUser(userId);
      setState(() {
        _bookedHotels = bookedHotels;
      });
    } else {
       print('User not logged in');
    }
  }

  void _cancelBooking(int id) async {
    await DatabaseHelper.instance.deleteBooking(id);
    _loadBookedHotels();
      Fluttertoast.showToast(msg: "Booking cancelled successfully");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Hotels'),
      ),
      body: ListView.builder(
        itemCount: _bookedHotels.length,
        itemBuilder: (context, index) {
          final booking = _bookedHotels[index];
       return Card(
  elevation: 2.0,
  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  child: ListTile(
    title: Text(booking['hotel_name']),
    subtitle: Text('Start Date: ${booking['start_date']}'),
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Deletion'),
              content: Text('Are you sure you want to delete this booking?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    _cancelBooking(booking['id']);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingDetailsPage(booking: booking),
        ),
      );
    },
  ),
);
        },
      ),
    );
  }
}
