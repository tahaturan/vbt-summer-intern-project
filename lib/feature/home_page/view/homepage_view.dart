import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vbtsummerintern/core/base/base_view.dart';
import 'package:vbtsummerintern/core/constants/app_constants.dart';

import '../viewmodel/makeupmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MakeUpViewModel>(
        viewModel: MakeUpViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, MakeUpViewModel viewmodel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan.shade600,
              title: Row(
                children: const [Icon(Icons.view_headline), Text("MakeUp")],
              ),
              actions: const [
                Icon(Icons.search_rounded),
                SizedBox(width: 20),
                Icon(Icons.add_shopping_cart)
              ],
            ),
            body: Observer(builder: (_) {
              return viewmodel.isLoading
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 10,
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: viewmodel.productList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.network(
                                    viewmodel.productList?[index].imageLink ??
                                        ""),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                    viewmodel.productList?[index].name ?? "",
                                    style: ApplicationConstants.titleTextStyle),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(viewmodel.productList?[index].price ??
                                      ""),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.cyan),
                                    onPressed: () {},
                                    child: const Text(
                                      "Buy",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
            ),
          );
        });
    // Scaffold(
    //   appBar: AppBar(),
    //   body: Column(
    //     children: [Text('data')],
    //   ),
    // );
  }
}
