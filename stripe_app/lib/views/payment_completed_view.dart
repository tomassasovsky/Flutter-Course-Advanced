part of 'views.dart';

class PaymentCompletedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Completed'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.star, color: Colors.white54, size: 100),
            SizedBox(height: 20),
            Text('Payment Completed', style: TextStyle(color: Colors.white, fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
