import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/screens/home/widgets/pick_date_to_view.dart';

import '../../bloc/home/home_bloc.dart';
import 'widgets/task_card.dart';
import 'widgets/view_dropdown.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final homeBloc = context.read<HomeBloc>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple[100],
              leading: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/image/logo.png'),
                ),
              ),
              title: const Text(
                'My Task Daily',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: PickDateToView(bloc: homeBloc)),
                    ViewDropdown(bloc: homeBloc),
                  ],
                ),
                Expanded(
                  child: state.status == TaskStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state.tasks.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TaskCard(
                                    task: state.tasks[index],
                                    bloc: context.read<HomeBloc>(),
                                    key: ValueKey(state.tasks[index].id),
                                ),
                              );
                            },
                          )
                        : const Center(child: Text("Empty")),
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  context.read<HomeBloc>().add(const HomeAddTask());
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .endFloat,
          );
        },
      ),
    );
  }
}
