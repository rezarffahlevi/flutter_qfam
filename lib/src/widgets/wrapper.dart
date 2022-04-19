part of 'widgets.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    this.state,
    this.onLoading,
    this.onLoaded,
    this.onError,
  }) : super(key: key);

  final NetworkStates? state;
  final Widget? onLoading;
  final Widget? onLoaded;
  final Widget? onError;

  @override
  Widget build(BuildContext context) {
    if (state == NetworkStates.onLoading) {
      return onLoading ?? Container();
    } else if (state == NetworkStates.onLoaded) {
      return onLoaded ?? Container();
    } else {
      return onError ?? Container();
    }
  }
}
