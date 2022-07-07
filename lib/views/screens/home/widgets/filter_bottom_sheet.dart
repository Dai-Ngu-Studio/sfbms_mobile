import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/models/category.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:sfbms_mobile/data/providers/filter.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/category_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isInit = true;

  List<int>? categoryIDs;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
        Provider.of<CategoryViewModel>(context, listen: false).getCategories(idToken: idToken!);
      });
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<Filter>(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: 210,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.4),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const Text(
            'Field Filters',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
          ),
          const Divider(color: Colors.black45),
          Expanded(
            child: Consumer<CategoryViewModel>(
              builder: (context, catVM, child) {
                switch (catVM.categories.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:
                    return Column(
                      children: [
                        SmartSelect<int>.multiple(
                          title: 'Categories',
                          modalType: S2ModalType.popupDialog,
                          selectedValue: filter.categories,
                          choiceItems: S2Choice.listFrom<int, Category>(
                            source: catVM.categories.data ?? [],
                            value: (index, item) => item.id!,
                            title: (index, item) => item.name!,
                          ),
                          onChange: (selected) {
                            setState(() => categoryIDs = selected?.value ?? []);
                          },
                          tileBuilder: (context, state) => S2Tile.fromState(state, isTwoLine: true),
                        ),
                      ],
                    );
                  case Status.ERROR:
                    return const Center(child: Text('Error fetching data'));
                  default:
                    return const Center(child: Text('Unknown error'));
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey.shade300, elevation: 0),
                  child: const Text('Reset'),
                  onPressed: () {
                    filter.reset();
                    categoryIDs = [];
                    Navigator.of(context).pop(categoryIDs);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(onPrimary: Colors.white, elevation: 0),
                  child: const Text('Set Filter'),
                  onPressed: () {
                    Navigator.of(context).pop(categoryIDs);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
