import 'package:args/command_runner.dart';

import '../../repositories/studenty_dio_repository.dart';
import '../../repositories/studenty_repository.dart';
import 'subcommands/delete_command.dart';
import 'subcommands/find_all.dart';
import 'subcommands/find_by_id.dart';
import 'subcommands/insert_command.dart';
import 'subcommands/update_command.dart';

class StudentsCommands extends Command {
  @override
  String get description => 'students Operations';

  @override
  String get name => 'students';

  StudentsCommands() {
    final studentyRepository = StudentyDioRepository();
    addSubcommand(FindAllCommand(studentyRepository));
    addSubcommand(FindByIdCommand(studentyRepository));
    addSubcommand(InsertCommand(studentyRepository));
    addSubcommand(UpdateCommand(studentyRepository));
    addSubcommand(DeleteCommand(studentyRepository));
  }
}
