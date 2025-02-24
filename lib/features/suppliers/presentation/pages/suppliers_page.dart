import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_case/features/suppliers/domain/entities/supplier_item.dart';
import 'package:master_case/features/suppliers/presentation/bloc/suppliers_bloc.dart';
import 'package:master_case/features/suppliers/presentation/widgets/supplier_button.dart';
import 'package:master_case/features/suppliers/presentation/widgets/supplier_target.dart';
import 'package:master_case/features/suppliers/presentation/widgets/supplier_timer.dart';
import 'package:master_case/injection_container.dart';

class SuppliersPage extends StatelessWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores de productos'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<SuppliersBloc> buildBody(BuildContext context) {
    List<SupplierItem> supplierItems = [];

    return BlocProvider(
        create: (BuildContext context) => sl<SuppliersBloc>(),
        child: Center(
          child: BlocBuilder<SuppliersBloc, SuppliersState>(
              builder: (BuildContext context, SuppliersState state) {
            if (state is SuppliersInitial) {
              BlocProvider.of<SuppliersBloc>(context).add(GetSuppliersEvent());
            }

            if (state is SuppliersLoading) {
              // print('estado de carga pagina de proveedores');
            }

            if (state is SuppliersLoaded) {
              supplierItems = state.supplierItems;

              return Column(
                children: [
                  const Text('Tiempo para la proxima fase'),
                  SupplierTimer(
                    startSeconds: 10, 
                    fontSize: 40, 
                    textColor: Colors.black
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Ajusta el número de columnas
                        childAspectRatio:
                            0.9, // Ajusta la proporción de la imagen y texto
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: supplierItems.length,
                      itemBuilder: (context, index) {
                        final item = supplierItems[index];
                        return SupplierTarget(item: item);
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is SuppliersError) {
              // print('estado de error pagina de proveedores');
            }

            return const CircularProgressIndicator();
          }),
        ));
  }
}
