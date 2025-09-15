import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_bump_app/extension.dart';

const double LOADMORE_INDICATOR_SIZE = 24;
const double HEIGHT_LOADMORE_WIDGET = 80;

class LoadMoreDelegateCustom extends LoadMoreDelegate {
  const LoadMoreDelegateCustom();

  double widgetHeight(LoadMoreStatus status) =>
      status == LoadMoreStatus.loading ? HEIGHT_LOADMORE_WIDGET : 0;

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 30.w,
                height: 20.w,
                child: const SpinKitFadingCircle(
                  color: Colors.black,
                  size: 30,
                  duration: Duration(milliseconds: 800),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }
}
