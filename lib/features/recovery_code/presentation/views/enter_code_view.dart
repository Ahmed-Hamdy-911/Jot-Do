import 'package:flutter/material.dart';
import 'widgets/app_bar_enter_code.dart';
import 'widgets/enter_code_widget.dart';
import 'widgets/scan_qr_code_widget.dart';

class EnterCodeView extends StatefulWidget {
  const EnterCodeView({super.key});

  @override
  State<EnterCodeView> createState() => _EnterCodeViewState();
}

class _EnterCodeViewState extends State<EnterCodeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            setState(() {});
          }
        });
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 35),
            child: AppBarEnterCode(tabController: tabController),
          ),
          body: TabBarView(
            controller: tabController,
            children: const [
              EnterCodeWidget(),
              ScanQRCodeWidget(),
            ],
          ),
        );
      }),
    );
  }
}
