import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ocassion_model.dart';

class TabControlerWidget extends StatelessWidget {


  List<OcassionModel>ocassionModel;
  TabControlerWidget(this.ocassionModel);
    @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: ocassionModel.length,
          child: TabBar(
            isScrollable: true,
            onTap: (index) {
            //// HomeCubit.get(context).changeSources(index) ;
            },
            indicator: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            tabs: ocassionModel
                .map((ocassionModel) => Tab(
                      child: Text(
                        ocassionModel.name ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),

      ],
    );
  }
}
