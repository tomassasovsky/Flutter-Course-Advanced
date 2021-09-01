part of 'views.dart';

final List<CreditCardModel> cards = <CreditCardModel>[
  CreditCardModel(
    cardNumberHidden: '4242',
    cardNumber: '4242424242424242',
    brand: 'visa',
    cvv: '213',
    expiryDate: '01/25',
    cardHolderName: 'Fernando Herrera',
  ),
  CreditCardModel(
    cardNumberHidden: '5555',
    cardNumber: '5555555555554444',
    brand: 'mastercard',
    cvv: '213',
    expiryDate: '01/25',
    cardHolderName: 'Melissa Flores',
  ),
  CreditCardModel(
    cardNumberHidden: '3782',
    cardNumber: '378282246310005',
    brand: 'american express',
    cvv: '2134',
    expiryDate: '01/25',
    cardHolderName: 'Eduardo Rios',
  ),
];

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              showLoading(context);
              await Future.delayed(Duration(seconds: 1));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            top: 200,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              physics: BouncingScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                final card = cards[index];
                return GestureDetector(
                  onTap: () {
                    context.read<PaymentBloc>().add(PaymentSelectCardEvent(card));
                    Navigator.push(context, navigateFadeIn(context, CardView()));
                  },
                  child: Hero(
                    tag: card.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: card.cardNumber,
                      cardHolderName: card.cardHolderName,
                      cvvCode: card.cvv,
                      expiryDate: card.expiryDate,
                      showBackView: false,
                    ),
                  ),
                );
              },
            ),
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
