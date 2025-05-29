import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
     appBar: PreferredSize(
  preferredSize: Size.fromHeight(65), // 
  child: AppBar(
    title: Padding(
      padding: const EdgeInsets.only(top:15, left: 8),
      child: Text(
        "Technician Dashboard",
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
          child: Text('Logout', style: TextStyle(fontSize: 20),),
        ),
      ],
    ),
  ),
],

  ),
),

      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 30.0, right:30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Hello Kasun! 👋 ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold ))),
                Center(child: Text("Ready for today's tasks?",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                SizedBox(height: 60,)
              ,
                Center(
                  child: Text("Find Vehicle", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Center(
      child: Text(
        "Enter a vehicle number to view or update records.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0XFF252525),
        ),
      ),
    ),
  ],
),

                Center(
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "CBK-1200", hintStyle: TextStyle(
                          fontSize: 20
                        ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          width: 2.5,
                          color: Color(0xFF252525)
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color(0xFF252525)
                          )
                        ),
                        prefixIcon: null,
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 120,
                    height: 60,
                    padding: EdgeInsets.only(top: 15.00),
                    child: ElevatedButton(onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFFFC107),
                      foregroundColor: Color(0xFF252525),
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                      )
                    ),
                    
                     child: Text("Search")),
                  ),
                ),
              ],
            ),
        
        
            SizedBox(height: 60),
        
        
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Add New Vehicle", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF252525),
                  ),),
                ),
                Center(
                  child: Text("Add a new vehicle to the system.", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF252525,)
                  ),),
                ),
                Center(
                  child: Container(
                    width: 120,
                    height: 60,
                    padding: EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFFFFC107),
                      foregroundColor: Color(0xFF252525),
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      )
                    )
                    ,child: Text("Add")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
