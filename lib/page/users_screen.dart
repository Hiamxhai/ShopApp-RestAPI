import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/model/users_model.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widget/user_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Persion'),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getALlUsers(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Text('An Error ${snapshot.hasError}'),
            );
          }
          else if (snapshot.data == null) {
            return Text('No Product');
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: UsersWidget());
              }));
        }
        ),

    );
  }
}
