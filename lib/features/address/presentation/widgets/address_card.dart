import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/theme/theme_extension.dart';
import 'package:flower_app/features/address/domain/entities/address_response_entity.dart';
import 'package:flower_app/features/address/presentation/view_model/address_state.dart';
import 'package:flower_app/features/address/presentation/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});
  final AddressEntity address;
  @override
  Widget build(BuildContext context) {
    var theme = context.appTheme;
    return Container(
      decoration: _cardDecoration(theme),
      padding: const EdgeInsets.all(16),

      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 2,
            children: [
              const Icon(Icons.location_on_outlined),
              Text(address.city ?? "Cairo", style: theme.medium16),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: theme.error,
                onPressed: () {
                  if (address.id != null) {
                    context.read<AddressViewModel>().doIntent(
                      DeleteAddressEvent(address.id!),
                    );
                  }
                },
              ),
              const Icon((Icons.edit)),
            ],
          ),
          Text(
            address.street ?? "Streat",
            style: theme.regular14.copyWith(fontSize: 13, color: theme.grey),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(AppThemeExtension theme) => BoxDecoration(
    color: theme.secondary,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: theme.surface.withValues(alpha: 0.15),
        blurRadius: 6,
        spreadRadius: 0,
        offset: const Offset(0, 4),
      ),

      BoxShadow(
        color: theme.surface.withValues(alpha: 0.15),
        blurRadius: 6,
        spreadRadius: 0,

        offset: const Offset(4, 0),
      ),
    ],
  );
}
