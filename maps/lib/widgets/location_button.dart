part of 'widgets.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      maxRadius: 25,
      child: IconButton(
        icon: Icon(Icons.my_location, color: Colors.black87),
        onPressed: () {
          final myLocation = context.read<LocationBloc>().state.location;
          if (myLocation != null) {
            context.read<MapBloc>().cameraTo(myLocation);
          }
        },
      ),
    );
  }
}
