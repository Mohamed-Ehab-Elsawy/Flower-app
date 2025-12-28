// import 'package:flower_app/core/di/di.dart';
// import 'package:flower_app/features/home/presentation/occasions/occasions_cubit.dart';
// import 'package:flower_app/features/home/presentation/occasions/occasions_events.dart';
// import 'package:flower_app/features/home/presentation/occasions/occasions_states.dart';
// import 'package:flower_app/features/home/presentation/view/occasions/tab_controler.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'ocassion_model.dart';
//
// class OccasionScreen extends StatefulWidget {
//   const OccasionScreen({super.key});
//
//   @override
//   State<OccasionScreen> createState() => _OccasionScreenState();
// }
//
// class _OccasionScreenState extends State<OccasionScreen> {
//   final occasionsCubit = getIt.get<OccasionsCubit>();
//   late List<OcassionModel> occasions;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     final args = ModalRoute.of(context)?.settings.arguments;
//     if (args != null && args is List<OcassionModel>) {
//       occasions = args;
//       print("Occasions length: ${occasions.length}"); // لازم يطبع 2
//     } else {
//       occasions = [];
//       print("No arguments received");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // occasionsCubit.occasionId = args.id! ;
//     return BlocProvider<OccasionsCubit>(
//       create: (context) => occasionsCubit
//         ..doIntent(
//           GetAllProductsByOccasionsEvents(
//             occasionId: occasionsCubit.occasionId,
//           ),
//         ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Occasion")),
//         body: Column(
//           children: [
//             TabControlerWidget(occasions),
//             BlocBuilder<OccasionsCubit, OccasionsStates>(
//               builder: (context, state) {
//                 if (state.productsStates?.errorMessage != null &&
//                     state.productsStates!.errorMessage!.isNotEmpty) {
//                   return Text(state.productsStates!.errorMessage!);
//                 } else if (!(state.productsStates?.isLoading ?? false) &&
//                     state.productsStates?.data != null &&
//                     state.productsStates!.data!.isNotEmpty) {
//                   return Expanded(
//                     child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemBuilder: (context, index) {
//                         final subject = state.productsStates?.data![index];
//                         return SizedBox(
//                           width: double.infinity,
//                           child: InkWell(
//                             onTap: () {},
//                             child: Text(subject!.title ?? ''),
//                           ),
//                         );
//                       },
//                       itemCount: state.productsStates?.data!.length,
//                     ),
//                   );
//                 } else if (!(state.productsStates?.isLoading ?? false) &&
//                     state.productsStates?.data != null &&
//                     state.productsStates!.data!.isEmpty) {
//                   return Text("AppStrings.noDate");
//                 } else {
//                   return const CircularProgressIndicator();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
