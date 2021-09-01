import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/payment/payment_bloc.dart';
import 'package:stripe_app/views/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PaymentBloc()),
      ],
      child: MaterialApp(
        title: 'Stripe App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => HomeView(),
          'payment_completed': (_) => PaymentCompletedView(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xff284879),
          scaffoldBackgroundColor: Color(0xff21242A),
        ),
      ),
    );
  }
}


// pk_test_51JUlJsDnjqlUYqXk65rH0whg0Q1Ey1mGMXDFp50xPTvl865dMexxThEdPw2pvdFCADwCh4dhZyi2QtHKSoRDXBMx00L2n6T8xx