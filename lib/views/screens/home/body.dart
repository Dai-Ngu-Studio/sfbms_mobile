import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/field_item.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final refreshController = RefreshController(initialRefresh: false);
  FieldViewModel? fieldViewModel;
  UserViewModel? userViewModel;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fieldViewModel = Provider.of<FieldViewModel>(context);
      userViewModel = Provider.of<UserViewModel>(context);
      _onRefresh();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<bool?> _onRefresh({bool isRefresh = false}) async {
    var result = await fieldViewModel!.getFields(
      idToken: (await userViewModel!.idToken)!,
      isRefresh: isRefresh,
    );

    if (result == null) {
      return null;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserViewModel, FieldViewModel>(
      builder: ((context, userVM, fieldVM, _) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            refreshController.resetNoData();
            var result = await _onRefresh(isRefresh: true);

            if (result!) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadFailed();
            }
          },
          onLoading: () async {
            final result = await _onRefresh();

            if (result == null) {
              refreshController.loadNoData();
            } else if (result) {
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          },
          header: const WaterDropHeader(),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            completeDuration: Duration(milliseconds: 500),
          ),
          child: ListView.builder(
            itemCount: fieldVM.fields.data?.fields?.length ?? 0,
            itemBuilder: (context, index) {
              if (fieldVM.fields.data == null) {
                return const Center(child: Text("No fields found!."));
              }
              return FieldItem(
                name: fieldVM.fields.data!.fields![index].name!,
                imageUrl: fieldVM.fields.data!.fields![index].imageUrl!,
                availableTime: fieldVM.fields.data!.fields![index].slots?.toList() ?? [],
              );
            },
          ),
        );
      }),
    );
  }
}
