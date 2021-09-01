part of 'widgets.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('\$25 USD', style: TextStyle(fontSize: 20)),
            ],
          ),
          _PayButton(),
        ],
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  const _PayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          icon(context),
          Text('  Pay', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  Widget icon(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.isSelected) return Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white);

        if (Platform.isIOS)
          return Icon(FontAwesomeIcons.apple, color: Colors.white);
        else
          return Icon(FontAwesomeIcons.google, color: Colors.white);
      },
    );
  }
}
