import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../splash/presentation/bloc/guest_bloc.dart';
import '../../../splash/presentation/bloc/guest_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GuestBloc, GuestState>(
          builder: (context, state){
            final guestSessionId = state.guestSessionId?.guestSessionId ?? 'Session ID not found';
            return Text(
              'Welcome to the Home Screen! Your Guest Session ID is: $guestSessionId',
            );
          },
        )
      ),
    );
  }
}
