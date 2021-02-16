import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkConnectivity extends StatelessWidget {
  final Widget child;

  const NetworkConnectivity({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectivityResult connectionStatus =
        Provider.of<ConnectivityResult>(context);

    if (connectionStatus == ConnectivityResult.none) {
      return Stack(
        children: [
          child,
          Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "Отсутствует подключение к Интернету",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return child;
  }
}
