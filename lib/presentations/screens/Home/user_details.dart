import 'package:api_fetch_appscrip/data/models/user.dart';
import 'package:api_fetch_appscrip/globals/extensions.dart';
import 'package:api_fetch_appscrip/globals/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
        backgroundColor: Colors.grey.shade600,
        title: Text("User Details",
            style:
                s3.copyWith(color: context.colorScheme.surface, fontSize: 25)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: context.colorScheme.surface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.user.name,
              style: s3.copyWith(color: Colors.pink.shade800),
              textAlign: TextAlign.center,
            ),
            const Gap(10),
            _buildUserInfoCard('Email:', widget.user.email, Icons.email),
            _buildUserInfoCard('Phone:', widget.user.phone, Icons.phone),
            _buildUserInfoCard(
                'Username:', widget.user.userName, Icons.account_circle),
            _buildUserInfoCard('Website:', widget.user.website, Icons.language),
            _buildSectionTitle('Address'),
            _buildUserInfoCard('Street:', widget.user.street),
            _buildUserInfoCard('Suite:', widget.user.suite),
            _buildUserInfoCard('City:', widget.user.city),
            _buildUserInfoCard('Zipcode:', widget.user.zipcode),
            _buildSectionTitle('Company'),
            _buildUserInfoCard('Company Name:', widget.user.companyName),
            _buildUserInfoCard('Catchphrase:', widget.user.catchPhrase),
            _buildUserInfoCard('BS:', widget.user.bs),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String value, [IconData? icon]) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: Colors.blueAccent.shade100, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$title $value',
                style: h4.copyWith(color: Colors.indigo),
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
      child: Text(title, style: s4.copyWith(color: Colors.blueAccent.shade700)),
    );
  }
}
