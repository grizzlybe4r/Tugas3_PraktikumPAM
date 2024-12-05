import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({required this.username});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeader(username),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white),
                      onPressed: () => _logout(context),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          1, // 1 kolom agar card memenuhi lebar layar
                      childAspectRatio:
                          2.5, // Sesuaikan rasio tinggi-lebar card
                      mainAxisSpacing: 16.0, // Spasi antar card secara vertikal
                    ),
                    itemCount: 3, // Jumlah item
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return _buildMenuCard(
                            context,
                            'News',
                            'Latest space flight news and updates',
                            Icons.newspaper,
                            'articles',
                          );
                        case 1:
                          return _buildMenuCard(
                            context,
                            'Blogs',
                            'Space-related blog posts',
                            Icons.create,
                            'blogs',
                          );
                        case 2:
                          return _buildMenuCard(
                            context,
                            'Reports',
                            'Detailed space mission reports',
                            Icons.description,
                            'reports',
                          );
                        default:
                          return SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hai, $username',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Explore the wonders of space!',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, String subtitle,
      IconData icon, String endpoint) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 6.0,
      shadowColor: Colors.black38,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(
                title: title,
                endpoint: endpoint,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                child: Icon(
                  icon,
                  size: 32.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}
