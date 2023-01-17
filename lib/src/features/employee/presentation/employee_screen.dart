import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transisi/src/core/constants/constants.dart';
import 'package:transisi/src/core/widgets/default_app_bar.dart';
import 'package:transisi/src/core/widgets/other/list_tile_card.dart';
import 'package:transisi/src/core/widgets/texts/title_text.dart';
import 'package:transisi/src/features/employee/domain/entities/employee.dart';
import 'package:transisi/src/features/employee/presentation/bloc/employee_list_bloc.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(label: "Contacts").appBar,
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is EmployeeListLoadFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is EmployeeListLoadSuccess) {
            List<Employee> items = state.items;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Employee em = items[index];
                  return _buildContactCard(em, onTap: () {
                    context.go('/detail/${em.id}');
                  });
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContactCard(Employee em, {Function()? onTap}) => ListTileCard(
        title: em.fullName,
        onTap: onTap,
        leading: em.avatar != null
            ? _buildAvatarCard(em.avatar!)
            : _buildInitialCard(
                em.firstName?.substring(0, 1).toUpperCase() ?? ''),
        subtitle: em.email ?? '',
        trailing: const Icon(Icons.star_outline_rounded),
      ).child;

  Widget _buildAvatarCard(String initial) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
            image: DecorationImage(
                image: NetworkImage(initial), fit: BoxFit.cover)),
        alignment: Alignment.center,
      );

  Widget _buildInitialCard(String initial) => Container(
        width: 80,
        height: 80,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: primaryColor),
        alignment: Alignment.center,
        child: TitleText(
          text: initial,
          color: Colors.white,
        ).child,
      );
}
