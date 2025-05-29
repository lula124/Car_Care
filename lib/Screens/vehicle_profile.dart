import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
     appBar: PreferredSize(
  preferredSize: Size.fromHeight(65),
  child: AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(top: 8, left: 5),
      child: IconButton(
        icon: Icon(Icons.arrow_back, size: 38, color: Color(0xFFFFC107)),
        onPressed: () {
          // Navigate back
        },
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 15, left: 0),
      child: Text(
        "Vehicle Profile",
        style: TextStyle(
          color: Color(0xFFF5F5F5),
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    backgroundColor: Color(0xFF252525),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 6, right: 15),
        child: PopupMenuButton<String>(
          icon: Icon(Icons.menu, size: 40, color: Color(0xFFFFC107)),
          onSelected: (value) {
            if (value == 'logout') {
              // Handle logout logic here
              print('User logged out');
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    ],
  ),
),

      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Center(child: Text("CBB - 4183", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                SizedBox(height: 5,),
                Center(child: Text("Toyota Land Cruiser V8 - 2020", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),

               
              
                
                Center(child: Text("Diesel / Autometic Transmission", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                Center(child: Text("4L V8 - Twin Turbo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                SizedBox(height: 30,),
                
                // Round vehicle image
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 30),
                    child: CircleAvatar(
                      radius: 130,
                      backgroundImage: AssetImage("assets/vehicle.jpeg"), // <-- Add your image path here
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
               
                SizedBox(height: 10,),
                Center(child: Text("Owner Details", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                SizedBox(height: 5,),
                Center(child: Text("Mr. Pradeep Sandaruwan", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                Center(child: Text("077 2596024", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                Center(child: Text("45/6, Kandy road, Gampaha", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                SizedBox(height: 40,)
                
               
              ],
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      
                      label: const Text(
                        "Update",
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFFFFC107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      
                      label: const Text(
                        "History",
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFFFFC107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              "$label ",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Expanded(
            child: Text(": $value", style: const TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }
}
