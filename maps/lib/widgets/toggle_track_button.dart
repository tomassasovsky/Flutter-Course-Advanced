part of 'widgets.dart';

class ToggleTrackButton extends StatelessWidget {
  const ToggleTrackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
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
              icon: Icon(state.trackLocation ? Icons.directions_run : Icons.accessibility_new, color: Colors.black87),
              onPressed: () {
                context.read<MapBloc>().add(MapToggleTrackLocationEvent());
              },
            ),
          ),
        );
      },
    );
  }
}
