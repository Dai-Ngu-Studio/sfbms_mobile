import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/feedback_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/feedback_item.dart';

class FeedbackBox extends StatefulWidget {
  const FeedbackBox({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  State<FeedbackBox> createState() => _FeedbackBoxState();
}

class _FeedbackBoxState extends State<FeedbackBox> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
        Provider.of<FeedbackViewModel>(context, listen: false).getFeedbacksByFieldID(
          idToken: idToken!,
          fieldID: widget.fieldID,
        );
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(
            height: 40,
            indent: mediaQuery.size.width * 0.2,
            endIndent: mediaQuery.size.width * 0.2,
            thickness: 1,
            color: Colors.black12,
          ),
          Text('Feedback', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          Consumer<FeedbackViewModel>(
            builder: (context, feedbackVM, child) {
              switch (feedbackVM.feedbacks.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  if (feedbackVM.feedbacks.data?.isEmpty ?? false) {
                    return const Center(child: Text('No feedback yet'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feedbackVM.feedbacks.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return FeedbackItem(feedback: feedbackVM.feedbacks.data![index]);
                    },
                  );
                case Status.ERROR:
                  return const Center(child: Text('Error fetching data'));
                default:
                  return const Center(child: Text('No feedback yet'));
              }
            },
          ),
        ],
      ),
    );
  }
}
