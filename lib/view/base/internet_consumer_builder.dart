import 'package:ams_garaihy/providers/internet_provider_provider.dart';
import 'package:ams_garaihy/view/screens/no_internet/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InternetConsumerBuilder extends StatefulWidget {
  const InternetConsumerBuilder({
    Key? key,
    required this.builder,
    this.onRestoreInternetConnection,
    this.noInternetScreen,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    InternetProvider internetProvider,
  ) builder;

  /// This method called when internet connection is restored after it was disconnected
  final void Function()? onRestoreInternetConnection;

  /// This widget shown when internet connection is offline.
  /// If [noInternetScreen] is null, the default widget will be shown
  final Widget Function(
    BuildContext context,
    InternetProvider internetProvider,
  )? noInternetScreen;

  @override
  State<InternetConsumerBuilder> createState() => _InternetConsumerBuilderState();
}

class _InternetConsumerBuilderState extends State<InternetConsumerBuilder> {
  late final InternetProvider _internetProvider;

  @override
  void initState() {
    super.initState();

    _internetProvider = Provider.of<InternetProvider>(context, listen: false);
    _internetProvider.init(mounted);
  }

  @override
  void dispose() {
    _internetProvider.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetProvider>(
      builder: (context, internetProvider, _) {
        if (internetProvider.noInternetConnection) {
          return widget.noInternetScreen != null
              ? widget.noInternetScreen!(context, internetProvider)
              : const NoInternetScreen();
        } else if (internetProvider.connectionRestored && widget.onRestoreInternetConnection != null) {
          debugPrint("internet connection restored ..");
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            internetProvider.onRestoreInternetConnectionCalled();
            widget.onRestoreInternetConnection?.call();
          });
        }

        return widget.builder(context, internetProvider);
      },
    );
  }
}
