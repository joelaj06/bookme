import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/features/bookme/presentation/agents/getx/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utitls/app_assets.dart';
import '../../../../../core/presentation/widgets/app_loading_box.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
class AgentsScreen extends GetView<AgentsController> {
  const AgentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agents'),
      ),
      body:  AppLoadingBox(
        loading: controller.isLoading.value,
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 5),
                        spreadRadius: -16,
                        blurRadius: 20,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )
                    ]),
                child: _buildItemSearchField(
                  color: Colors.black54,
                  hintColor: Colors.black54,
                  prefixIconColor: Colors.black54,
                ),
              ),
              const AppSpacing(v: 10,),
              Flexible(
                child: _buildAgentListTile(
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildItemSearchField({
    Color color = Colors.white,
    Color prefixIconColor = Colors.white,
    Color hintColor = Colors.white54,
  }) {
    return TextFormField(
      controller: controller.searchQueryTextEditingController.value,
      onFieldSubmitted: (String? value) {
        controller.onSearchServiceQuerySubmit(value);
      },
      style: TextStyle(
        color: color,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () => controller.clearSearchField(),
            icon: const Icon(Icons.cancel_outlined),
          ),
          prefixIcon: Icon(
            IconlyBroken.search,
            color: prefixIconColor,
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(color: hintColor)),
    );
  }

  Widget _buildAgentListTile(BuildContext context) {
   // final double width = MediaQuery.of(context).size.width;
    return PagedListView<int, User>.separated(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<User>(
        itemBuilder: (BuildContext context, User agent, int index) {
          return _buildAgentCard(context,agent);
        },
        firstPageErrorIndicatorBuilder: (BuildContext context) =>
            ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.refresh(),
            ),
        noItemsFoundIndicatorBuilder: (BuildContext context) =>
        const EmptyListIndicator(),
        newPageProgressIndicatorBuilder: (BuildContext context) =>
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        firstPageProgressIndicatorBuilder: (BuildContext context) =>
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      //padding: AppPaddings.lA,
      separatorBuilder: (BuildContext context, int index) =>
      const SizedBox.shrink(),
    );
  }

  Widget _buildAgentCard(BuildContext context, User agent,){
    final String image = agent.image ?? '';
    return GestureDetector(
      onTap: (){
        controller.navigateToServiceAgentScreen(agent);
      },
      child: SizedBox(
        child: Padding(
          padding: AppPaddings.mV,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: image.isEmpty
                          ? Image.asset(AppImageAssets.blankProfilePicture,)
                          : Image.memory(
                        fit: BoxFit.cover,
                        Base64Convertor().base64toImage(
                          image,
                        ),
                      ),
                    ),
                  ),
                  const AppSpacing(h: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${agent.firstName} ${agent.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      Text(agent.jobTitle ?? ''),
                    ],
                  ),
                ],
              ),
              const AppSpacing(v:5),
              const Divider(height: 1,),
            ],
          ),
        ),
      ),
    );
  }
}
