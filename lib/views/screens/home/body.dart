import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/field_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<bool?> _onRefresh({
    bool isRefresh = false,
    required FieldViewModel fieldVM,
    required UserViewModel userVM,
  }) async {
    var result = await fieldVM.getFields(idToken: (await userVM.idToken)!, isRefresh: isRefresh);

    if (result == null) return null;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);

    return Consumer2<UserViewModel, FieldViewModel>(
      builder: ((context, userVM, fieldVM, _) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            refreshController.resetNoData();
            var result = await _onRefresh(isRefresh: true, fieldVM: fieldVM, userVM: userVM);

            if (result!) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadFailed();
            }
          },
          onLoading: () async {
            final result = await _onRefresh(fieldVM: fieldVM, userVM: userVM);

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
                fieldID: fieldVM.fields.data!.fields![index].id!,
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
