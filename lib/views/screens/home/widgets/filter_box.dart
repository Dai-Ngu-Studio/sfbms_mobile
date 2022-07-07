import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/providers/filter.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/filter_bottom_sheet.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({Key? key, required this.refresh}) : super(key: key);

  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fields',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          ElevatedButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const FilterBottomSheet(),
            ).then((result) {
              if (result != null) {
                Provider.of<Filter>(context, listen: false).setCategory(result);
                refresh();
              }
            }),
            style: TextButton.styleFrom(primary: Colors.white),
            icon: const Icon(Icons.filter_alt_outlined),
            label: const Text('Filter'),
          ),
        ],
      ),
    );
  }
}
