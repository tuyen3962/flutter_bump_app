import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivySignPage extends StatefulWidget {
  const PrivySignPage({super.key});

  @override
  State<PrivySignPage> createState() => _PrivySignPageState();
}

class _PrivySignPageState extends State<PrivySignPage> {
  late final WebViewController _controller;
  String? _status;
  bool hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    // Load the local HTML file as string
    // final htmlData =
    //     await rootBundle.loadString('assets/html/privy_signer.html');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..
      ..addJavaScriptChannel(
        'PrivyFlutterChannel',
        onMessageReceived: (msg) {
          setState(() => _status = msg.message);
        },
      )
      ..loadRequest(Uri.parse('https://sponsordotfun.vercel.app/'));
    hasLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Privy Session Signer')),
      body: Column(
        children: [
          Expanded(
            child: hasLoaded && _status == null
                ? WebViewWidget(controller: _controller)
                : _status == null
                    ? Center(child: const CircularProgressIndicator())
                    : Center(
                        child: Text(
                          _status!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
