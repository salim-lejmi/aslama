import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'hotel.dart';
import 'BookedHotelsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingModal extends StatefulWidget {
  final Hotel hotel;

  const BookingModal({Key? key, required this.hotel}) : super(key: key);

  @override
  _BookingModalState createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _adults = 1;
  int _children = 0;
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    if (_startDate != null && _endDate != null) {
      int nights = _endDate!.difference(_startDate!).inDays;
      _totalPrice = (widget.hotel.price * nights) * _adults +
          (widget.hotel.price / 2) * _children;
    } else {
      _totalPrice =
          widget.hotel.price * _adults + (widget.hotel.price / 2) * _children;
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _calculateTotalPrice();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        _calculateTotalPrice();
      });
    }
  }

  void _incrementAdults() {
    setState(() {
      _adults++;
      _calculateTotalPrice();
    });
  }

  void _decrementAdults() {
    if (_adults > 1) {
      setState(() {
        _adults--;
        _calculateTotalPrice();
      });
    }
  }

  void _incrementChildren() {
    setState(() {
      _children++;
      _calculateTotalPrice();
    });
  }

  void _decrementChildren() {
    if (_children > 0) {
      setState(() {
        _children--;
        _calculateTotalPrice();
      });
    }
  }

  void _bookHotel() async {
    if (_startDate != null && _endDate != null) {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');

      if (userId != null) {
        final booking = {
          'user_id': userId,
          'hotel_name': widget.hotel.name,
          'location': widget.hotel.location,
          'start_date': _startDate.toString(),
          'end_date': _endDate.toString(),
          'adults': _adults,
          'children': _children,
          'total_price': _totalPrice,
          'image_asset': widget.hotel.imageAsset, 
        };

        final id = await DatabaseHelper.instance.insertBooking(booking);
        print('Booking inserted with ID: $id');
      Fluttertoast.showToast(msg: "Hotel booked successfully");

         if (mounted) {
          final bookedHotelsPage =
              context.findAncestorWidgetOfExactType<BookedHotelsPage>();
          if (bookedHotelsPage != null) {
            bookedHotelsPage.refreshBookedHotels();
          }
        }

        Navigator.pop(context);
      } else {
         print('User not logged in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book ${widget.hotel.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           ListTile(
            title: const Text('Start Date'),
            trailing: Text(
              _startDate == null
                  ? 'Select Date'
                  : _startDate!.toString().split(' ')[0],
            ),
            onTap: () => _selectStartDate(context),
          ),
           ListTile(
            title: const Text('End Date'),
            trailing: Text(
              _endDate == null
                  ? 'Select Date'
                  : _endDate!.toString().split(' ')[0],
            ),
            onTap: () => _selectEndDate(context),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Adults'),
              Row(
                children: [
                  IconButton(
                    onPressed: _decrementAdults,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_adults'),
                  IconButton(
                    onPressed: _incrementAdults,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Children'),
              Row(
                children: [
                  IconButton(
                    onPressed: _decrementChildren,
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_children'),
                  IconButton(
                    onPressed: _incrementChildren,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _bookHotel,
          child: const Text('Book'),
        ),
      ],
    );
  }
}
