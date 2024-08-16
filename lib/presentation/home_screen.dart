import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/state/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 237, 246),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 234, 237, 246),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(
              "You",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.notifications_none, size: 30,),
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.message, size: 30)
          ),
          const SizedBox(width: 15,)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Icon(
                Icons.logout,
                size: 35,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    await context.read<AuthCubit>().logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Logout', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet,),
              label: 'Active funds'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people,),
              label: 'Payees'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz,),
              label: 'More'
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        selectedIconTheme: IconThemeData(
          color: Colors.blue
        ),
        unselectedIconTheme: IconThemeData(
            color: Colors.grey
        ),
        unselectedItemColor: Colors.grey,
        onTap: (number){},
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }
}
