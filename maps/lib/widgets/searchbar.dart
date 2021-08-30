part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (!state.manualSelection) return _SearchBar();
        return Container();
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      child: SafeArea(
        child: GestureDetector(
          onTap: () async {
            final SearchResult? searchResult = await showSearch<SearchResult?>(context: context, delegate: SearchPlace());
            if (searchResult != null) handleResult(context, searchResult);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Text('Where to?', style: TextStyle(color: Colors.black87)),
                  Spacer(),
                  Icon(Icons.search, color: Colors.black87, size: 20),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleResult(BuildContext context, SearchResult result) {
    if (result.cancelled) return;
    if (result.manual) {
      context.read<SearchBloc>().add(ShowManualMarkerEvent());
    }
  }
}
