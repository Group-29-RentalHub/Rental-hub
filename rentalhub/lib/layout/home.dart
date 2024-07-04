import 'package:flutter/material.dart';
import 'package:rentalhub/models/house_model.dart';

// Sample data (replace with your actual data or fetch from API)
List<House> houses = [
  House(
    id: '2',
    title: 'Dream World Hostel',
    location: 'Makerere Kikoni',
    price: 'Ugx 800,000 per Semester',
    imageUrl: 'assets/room2.jpg',
  ),
  House(
    id: '3',
    title: 'Dream World Hostel',
    location: 'Makerere Kikoni',
    price: 'Ugx 800,000 per Semester',
    imageUrl: 'assets/room3.jpg',
  ),
  House(
    id: '4',
    title: 'Dream World Hostel',
    location: 'Makerere Kikoni',
    price: 'Ugx 800,000 per Semester',
    imageUrl: 'assets/room4.jpg',
  ),
  House(
    id: '5',
    title: 'Dream World Hostel',
    location: 'Makerere Kikoni',
    price: 'Ugx 800,000 per Semester',
    imageUrl: 'assets/room2.jpg',
  ),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: houses.length,
        itemBuilder: (context, index) {
          return HouseCard(house: houses[index]);
        },
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final House house;

  HouseCard({required this.house});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            child: Image.asset(
              house.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt, size: 20),
                        Text(
                          house.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        Text(house.location,
                            style: TextStyle(
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    SizedBox(height: 4.0),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      house.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [Icon(Icons.heart_broken), Text('72')],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  
                    backgroundColor:  Color.fromRGBO(70, 0, 119, 1),
                    elevation: 3.0,
                    textStyle: const TextStyle(color: Colors.white)),
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 20, color: Colors.white,),
                      Text('Details', style: TextStyle(color: Colors.white), )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
