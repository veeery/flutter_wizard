import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wizard/common/responsive.dart';

import '../../common/app_curve_size.dart';
import 'app_button.dart';
import 'app_loading.dart';

class AppLoadMore extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  final Future Function()? onLoadmore;
  final bool isLastPage;
  final Widget child;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final String noMoreText;
  final TextStyle? noMoreTextStyle;
  final Color colorIndicator;

  AppLoadMore({
    required this.child,
    required this.isLastPage,
    this.onRefresh,
    this.shrinkWrap = false,
    this.physics,
    this.noMoreText = "",
    this.colorIndicator = Colors.black,
    this.noMoreTextStyle,
    this.onLoadmore,
  });

  @override
  _AppLoadMoreState createState() => _AppLoadMoreState();
}

class _AppLoadMoreState extends State<AppLoadMore> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  late ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        setState(() {
          _isLoading = true;
        });

        if (widget.onLoadmore != null) {
          await widget.onLoadmore!();
        }

        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = NotificationListener(
      onNotification: (_) => true,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        controller: _scrollController,
        children: <Widget>[
          widget.child,
          _isLoading
              ? SizedBox()
              : Container(
                  color: Colors.transparent,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: AppButton(
                      title: 'Load more...',
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        if (widget.onLoadmore != null) {
                          await widget.onLoadmore!();
                        }

                        setState(() {
                          _isLoading = false;
                        });
                      }),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: _isLoading
                    ? Platform.isAndroid
                        ? Container(
                            width: 5.w,
                            height: 5.w,
                            alignment: Alignment.topCenter,
                            child: AppLoading(),
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            height: MediaQuery.of(context).size.height / 2,
                            child: CupertinoActivityIndicator(radius: CurveSize.mediumCurve))
                    : Text(
                        widget.isLastPage ? widget.noMoreText : '',
                        style: widget.noMoreTextStyle ??
                            TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
              )
            ],
          ),
        ],
      ),
    );

    if (widget.onRefresh == null) {
      return Scrollbar(child: mainWidget);
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: widget.colorIndicator,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: mainWidget,
    );
  }
}
