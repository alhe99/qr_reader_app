import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return Center(
      child: ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.redAccent,
          ),
          onDismissed: (DismissDirection direction) async {
            await Provider.of<ScanListProvider>(context, listen: false)
                .deleteScanById(scans[i].id);
          },
          child: ListTile(
            leading: Icon(
                type == 'http' ? Icons.map_outlined : Icons.home_outlined,
                color: Theme.of(context).primaryColor),
            title: Text(scans[i].value),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[i]),
          ),
        ),
      ),
    );
  }
}
