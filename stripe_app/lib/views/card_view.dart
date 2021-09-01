part of 'views.dart';

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        centerTitle: true,
        leading: IconButton(
          icon: Platform.isIOS ? Icon(Icons.arrow_back_ios) : Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PaymentBloc>().add(PaymentUnselectCardEvent());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return Hero(
                tag: state.card?.cardNumber ?? '',
                child: CreditCardWidget(
                  cardNumber: state.card?.cardNumber ?? '',
                  cardHolderName: state.card?.cardHolderName ?? '',
                  cvvCode: state.card?.cvv ?? '',
                  expiryDate: state.card?.expiryDate ?? '',
                  showBackView: false,
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
