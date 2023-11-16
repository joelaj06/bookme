import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal(
      {required this.isLoading,
      required this.child,
      required this.isSuccess,
      super.key});

  final bool isLoading;
  final Widget child;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return _buildLoadingModal(context);
  }

  Widget _buildLoadingModal(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 2,
                        right: 10,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.clear)),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: isLoading
                                  ? const CircularProgressIndicator.adaptive()
                                  : isSuccess
                                      ? const Icon(
                                          Icons.check_circle_outline,
                                          size: 50,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.cancel_outlined,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            child
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
