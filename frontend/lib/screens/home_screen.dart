import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tide_provider.dart'; // Tide Provider import

class TideScreen extends ConsumerWidget {
  const TideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tideAsyncValue = ref.watch(tideProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tide Data'),
      ),
      body: tideAsyncValue.when(
        data: (tideData) => ListView.builder(
          itemCount: tideData.length,
          itemBuilder: (context, index) {
            final tideItem = tideData[index];
            final meta = tideItem['meta'];
            final data = tideItem['data'] as List;

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(meta['obsPostName'] ?? 'Unknown Observatory'),
                subtitle: Text('Date: ${meta['date']}'),
                children: data.map((entry) {
                  return ListTile(
                    leading: Icon(
                      entry['hl_code'] == '고조'
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color:
                          entry['hl_code'] == '고조' ? Colors.blue : Colors.red,
                    ),
                    title: Text('Tide Level: ${entry['tph_level']}'),
                    subtitle: Text('Time: ${entry['tph_time']}'),
                  );
                }).toList(),
              ),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
