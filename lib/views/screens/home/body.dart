import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/data/providers/filter.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/field_item.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/filter_box.dart';
import 'package:sfbms_mobile/views/widgets/error_dialog.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.refreshController}) : super(key: key);

  final RefreshController refreshController;

  Future<bool?> _onRefresh({
    bool isRefresh = false,
    required FieldViewModel fieldVM,
    required UserViewModel userVM,
    required Filter filter,
  }) async {
    var result = await fieldVM.getFields(
      idToken: (await userVM.idToken)!,
      isRefresh: isRefresh,
      categoryIds: filter.categories,
      searchString: filter.searchValue,
    );

    if (result == null) return null;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<Filter>(context);

    return Consumer2<UserViewModel, FieldViewModel>(
      builder: ((context, userVM, fieldVM, child) {
        return SmartRefresher(
          physics: const BouncingScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            try {
              refreshController.resetNoData();
              var result = await _onRefresh(
                isRefresh: true,
                fieldVM: fieldVM,
                userVM: userVM,
                filter: filter,
              );

              if (result!) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            } catch (e) {
              showErrorDialog(context: context, message: e.toString());
              refreshController.refreshFailed();
            }
          },
          onLoading: fieldVM.fields.data?.fields?.isEmpty ?? true
              ? refreshController.loadNoData
              : () async {
                  try {
                    final result =
                        await _onRefresh(fieldVM: fieldVM, userVM: userVM, filter: filter);

                    if (result == null) {
                      refreshController.loadNoData();
                    } else if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  } catch (e) {
                    showErrorDialog(context: context, message: e.toString());
                    refreshController.loadFailed();
                  }
                },
          header: const WaterDropHeader(),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            completeDuration: Duration(milliseconds: 500),
          ),
          child: (fieldVM.fields.data?.fields?.isEmpty ?? true)
              ? Column(
                  children: [
                    child!,
                    const Expanded(
                      child: Center(
                        child: Text("No fields found!", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      child!,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fieldVM.fields.data?.fields?.length ?? 0,
                        itemBuilder: (context, index) {
                          return FieldItem(
                            fieldID: fieldVM.fields.data!.fields![index].id!,
                            name: fieldVM.fields.data!.fields![index].name!,
                            imageUrl: fieldVM.fields.data!.fields![index].imageUrl,
                            availableTime:
                                fieldVM.fields.data!.fields![index].slots?.toList() ?? [],
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      }),
      child: FilterBox(refresh: refreshController.requestRefresh),
    );
  }
}
