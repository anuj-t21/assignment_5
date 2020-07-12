import './edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart' show Users;

class UserProfile extends StatelessWidget {
  static const routeName = '/user-profile';
  Widget _buildListTile(String head, String sub) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(head),
          subtitle: Text(sub),
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context).items;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    userData[0].imageUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
//                Positioned(
//                  top: 10,
//                  left: 10,
//                  child: IconButton(
//                      icon: Icon(Icons.arrow_back),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      }),
//                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.black54,
                    child: Text(
                      userData[0].name,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            _buildListTile('About', userData[0].about),
            _buildListTile('Age', userData[0].age),
            _buildListTile('Contact', userData[0].contact),
            _buildListTile('Address', userData[0].address),
            _buildListTile('Membership', userData[0].membership),
          ],
        ),
      ),
    );
  }
}
