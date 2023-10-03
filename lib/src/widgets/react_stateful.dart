part of '../../react_state.dart';

abstract class ReactStateful extends StatefulWidget {
  const ReactStateful({super.key});

  Widget build(BuildContext context);

  void initState() {}

  void dispose() {}

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

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
