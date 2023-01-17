import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:transisi/src/core/widgets/default_app_bar.dart';
import 'package:transisi/src/core/widgets/image_network_wrapper.dart';
import 'package:transisi/src/core/widgets/other/list_tile_card.dart';
import 'package:transisi/src/core/widgets/texts/title_text.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';

import 'bloc/employee_list_bloc.dart';

class EmployeeDetailScreen extends StatelessWidget {
  const EmployeeDetailScreen({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Employee em = context.select<EmployeeListBloc, Employee>((bloc) =>
        (bloc.state as EmployeeListLoadSuccess)
            .items
            .firstWhere((element) => element.id == id));
    return Scaffold(
      appBar: DefaultAppBar(label: "Employee Detail", actions: [
        IconButton(
            onPressed: () {
              context.go('/edit/$id');
            },
            icon: const Icon(Icons.edit))
      ]).appBar,
      body: ListView(
        children: [
          Container(
            height: size.height * 0.3,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                em.avatar == null
                    ? Icon(
                        Icons.person,
                        size: size.width * 0.4,
                        color: Colors.white,
                      )
                    : ImageNetworkWrapper(
                        imageUrl: em.avatar,
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                      ),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                TitleText(
                  text: em.fullName,
                  color: Colors.white,
                ).child
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          ListTileCard(
                  title: em.phone ?? 'unknown phone number',
                  leading: _buildLeading(Icons.phone),
                  subtitle: "Phone number")
              .child,
          ListTileCard(
                  title: em.email ?? "unknown email address",
                  leading: _buildLeading(Icons.email),
                  subtitle: "Email address")
              .child,
          ListTileCard(
                  title: em.website ?? "unknown website",
                  leading: _buildLeading(Icons.web),
                  subtitle: "Website")
              .child
        ],
      ),
    );
  }

  Widget _buildLeading(IconData icon) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.2), shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 28,
      ),
    );
  }
}
