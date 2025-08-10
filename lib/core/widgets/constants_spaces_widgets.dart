import 'package:flutter/material.dart';

class LargeSpace extends StatelessWidget {
  const LargeSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
    );
  }
}

class SmallSpace extends StatelessWidget {
  const SmallSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
    );
  }
}

class MediumSpace extends StatelessWidget {
  const MediumSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
