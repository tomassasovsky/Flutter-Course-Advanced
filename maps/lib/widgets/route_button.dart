part of 'widgets.dart';

class RouteButton extends StatelessWidget {
  const RouteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black87),
          onPressed: () {
            final mapBloc = context.read<MapBloc>();
            mapBloc.add(MapToggleDrawHistoryEvent());
          },
        ),
      ),
    );
  }
}
