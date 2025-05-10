import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constant.dart';

import '../bloc/guest_bloc.dart';
import '../bloc/guest_envent.dart';
import '../bloc/guest_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GuestBloc>().add(GetGuestSessionEvent());
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<GuestBloc, GuestState>(
      listener: (context, state){
        if(state.status.isLoaded && state.guestSessionId != null){
            Navigator.pushReplacementNamed(context, '/home', arguments: state.guestSessionId);
        }else if(state.status.isError){
          print(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),

              backgroundColor: Colors.red,
            ),
          );
        }
      },

      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/images/splash/netflix_logo.png",
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),

    );
  }
}
