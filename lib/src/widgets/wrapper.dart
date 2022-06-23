part of 'widgets.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    this.state,
    this.onLoading,
    this.onLoaded,
    this.onError,
    this.isGlobalLoading = false,
  }) : super(key: key);

  final NetworkStates? state;
  final dynamic onLoading;
  final Widget? onLoaded;
  final Widget? onError;
  final bool? isGlobalLoading;

  @override
  Widget build(BuildContext context) {
    if (state == NetworkStates.onLoaded) {
      return SafeArea(child: onLoaded ?? Container());
    } else if (state == NetworkStates.onError) {
      return SafeArea(child: onError ?? Container());
    } else {
      if (isGlobalLoading == true) return SafeArea(child: onLoaded ?? Container());
      return SafeArea(child: onLoading ?? Container());
    }
  }
}
