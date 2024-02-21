import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                HeaderComponent(),
                Clockingcomponent(),
                SizedBox(height: 20.0),
                MetricsList(),
                SizedBox(height: 20.0),
                ActivityList()
              ],
            ),
          ),
        ),
      ), 
    );
  }
}



class Clockingcomponent extends StatelessWidget {
  const Clockingcomponent({super.key});
  @override
  Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(12),
      width: double.infinity, // Full width of the parent
      height: 250.0, // Set the height of the rectangle
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0)
      ),
    );   
   }
}


class MetricsList extends StatelessWidget {
  const MetricsList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
  // This line sets the scroll direction to horizontal.
  scrollDirection: Axis.horizontal,
  children: <Widget>[
    Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
    SizedBox(width: 8.0), // Add space between the items
    Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
    SizedBox(width: 8.0), // Add space between the items
    Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
    ),
  ],
),
    );
  }
}


class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text("Attendance History",textAlign: TextAlign.start,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
    );
  }
}


class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

final volume = 0.0;

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom:20.0),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning,",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey)),
              Text("Alain Cherubin",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black)),
            ],
          ),
          const Spacer(flex: 1),
           IconButton(
          icon: const Icon(Icons.account_circle_rounded,size:50.0),
          tooltip: 'Increase volume by 10',
          onPressed: () {},
        ),
        ],
      ),
    );
  }
}


class AttendanceDetailsCard extends StatelessWidget {
  const AttendanceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}