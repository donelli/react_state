part of '../../react_state.dart';

abstract class ReactStateful extends StatefulWidget with ReactState {
  ReactStateful({super.key});

  Widget build(BuildContext context);

  void initState() {}

  @override
  State<ReactStateful> createState() => _ReactStatefulState();
}

class _ReactStatefulState extends State<ReactStateful> {
  @override
  void initState() {
    super.initState();
    widget.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @pragma('vm:prefer-inline')
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
