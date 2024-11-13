import 'package:api_fetch_appscrip/data/models/user.dart';
import 'package:api_fetch_appscrip/globals/text_styles.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final User user;
  const UserDetails({super.key, required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade400,
        title: Text("User Details", style: s3.copyWith(color: Colors.white,fontSize: 25),),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildUserInfo('Email:', widget.user.email, Icons.email),
            _buildUserInfo('Phone:', widget.user.phone, Icons.phone),
            _buildUserInfo('Username:', widget.user.userName, Icons.account_circle),
            _buildUserInfo('Website:', widget.user.website, Icons.language),

            _buildSectionTitle('Address'),
            _buildUserInfo('Street:', widget.user.street),
            _buildUserInfo('Suite:', widget.user.suite),
            _buildUserInfo('City:', widget.user.city),
            _buildUserInfo('Zipcode:', widget.user.zipcode),

            _buildSectionTitle('Company'),
            _buildUserInfo('Company Name:', widget.user.companyName),
            _buildUserInfo('Catchphrase:', widget.user.catchPhrase),
            _buildUserInfo('BS:', widget.user.bs),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String title, String value, [IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 10,
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: Colors.brown.shade600, size: 20),
            const SizedBox(width: 10),
            SizedBox(
              width: 295,
              child: Text(
                '$title $value',
                style: TextStyle(fontSize: 18, color: Colors.brown.shade600),
                 overflow: TextOverflow.ellipsis,
                  maxLines: 2, 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.brown.shade700,
        ),
      ),
    );
  }
}
