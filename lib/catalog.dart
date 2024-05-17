import 'package:flutter/material.dart';

class Catalog extends StatelessWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.992,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Image.asset(
                'assets/images/header.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildItem(context, "beach",
                          icon: Icons.beach_access,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 245, 148, 177)),
                      const SizedBox(height: 0),
                      _buildItem(context, "cuisine",
                          icon: Icons.restaurant,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 255, 147, 81)),
                      const SizedBox(height: 0),
                      _buildItem(context, "Hiking",
                          icon: Icons.hiking,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 0, 193, 55)),
                      const SizedBox(height: 0),
                      _buildItem(context, "Ice",
                          icon: Icons.ac_unit,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 56, 66, 255)),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildItem(context, "desert",
                          icon: Icons.desk,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 209, 73, 255)),
                      const SizedBox(height: 0),
                      _buildItem(context, "old cities",
                          icon: Icons.castle,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 255, 217, 27)),
                      const SizedBox(height: 0),
                      _buildItem(context, "Historical places",
                          icon: Icons.history,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 148, 255, 90)),
                      const SizedBox(height: 0),
                      _buildItem(context, "River",
                          icon: Icons.water,
                          textColor: Colors.white,
                          boxColor: Color.fromARGB(255, 96, 234, 255)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title,
      {Color textColor = Colors.black,
      required IconData icon,
      required Color boxColor}) {
    return GestureDetector(
      onTap: () {
         Navigator.pushNamed(context, '/$title');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 19, color: textColor),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: boxColor,
          ),
          height: 140,
        ),
      ),
    );
  }
}
