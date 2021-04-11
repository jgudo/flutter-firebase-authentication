import 'package:flutter/material.dart';
import 'package:mobily/model/user.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static String route = '/home';

  Widget userItem(BuildContext context, UserModel user) {
    return ListTile(
      leading: Hero(
        tag: user.email,
        child: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(user.picture['medium']),
          backgroundColor: Colors.grey[200],
        )
      ),
      title: Text('${user.name['first']} ${user.name['last']}',
            style: TextStyle(
              fontSize: 20
            )
          ),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (ctx) => UserDetails(user))
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: FutureBuilder<List<UserModel>>(
        future: Provider.of<UserProvider>(context, listen: false).getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return userItem(context, snapshot.data![index]);
              }
            );
          }
          return Center(
            child: CircularProgressIndicator()
          );
        }
      )
    );
  }
}

class UserDetails extends StatelessWidget {
  final UserModel user;

  UserDetails(this.user);

  Widget userAvatar(UserModel user) {
    return Hero(
      tag: user.email,
      child: CircleAvatar(
        backgroundImage: NetworkImage(user.picture['medium']),
        backgroundColor: Colors.grey[200],
        radius: 50,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName)
      ),
      body: Container(
        color: Colors.grey[200],
        height: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userAvatar(user),
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
}