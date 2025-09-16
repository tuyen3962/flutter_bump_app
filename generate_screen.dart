#!/usr/bin/env dart

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart generate_screen.dart <screen_name> [template_type]');
    print('Template types: basic (default), no_appbar, primary_appbar');
    print('Example: dart generate_screen.dart home basic');
    exit(1);
  }

  final screenName = args[0].toLowerCase();
  final templateType = args.length > 1 ? args[1].toLowerCase() : 'basic';
  final screenNameCamelCase = _toCamelCase(screenName);
  final screenNamePascalCase = _toPascalCase(screenName);

  // Validate template type
  final validTemplates = ['basic', 'no_appbar', 'primary_appbar'];
  if (!validTemplates.contains(templateType)) {
    print('❌ Invalid template type: $templateType');
    print('Valid templates: ${validTemplates.join(', ')}');
    exit(1);
  }

  // Create screen directory
  final screenDir = Directory('lib/screen/$screenName');
  if (screenDir.existsSync()) {
    print('Screen "$screenName" already exists!');
    exit(1);
  }

  screenDir.createSync(recursive: true);
  print('Created directory: ${screenDir.path}');

  // Generate screen files
  _generateScreenFile(screenDir.path, screenName, screenNameCamelCase,
      screenNamePascalCase, templateType);
  _generateCubitFile(
      screenDir.path, screenName, screenNameCamelCase, screenNamePascalCase);
  _generateStateFile(
      screenDir.path, screenName, screenNameCamelCase, screenNamePascalCase);

  print(
      '✅ Successfully generated screen files for "$screenNamePascalCase" with "$templateType" template!');
  print('');
  print('Generated files:');
  print('- ${screenDir.path}/${screenName}_screen.dart');
  print('- ${screenDir.path}/${screenName}_cubit.dart');
  print('- ${screenDir.path}/${screenName}_state.dart');
  print('');
  print('Next steps:');
  print('1. Add the route to lib/router/app_route.dart');
  print('2. Run "dart run build_runner build" to generate routes');
  print('3. Implement your screen logic in the generated files');
}

void _generateScreenFile(
    String dirPath,
    String screenName,
    String screenNameCamelCase,
    String screenNamePascalCase,
    String templateType) {
  final content = '''import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/screen/$screenName/${screenName}_cubit.dart';

import '${screenName}_state.dart';

@RoutePage()
class ${screenNamePascalCase}Page extends BaseBlocProvider<${screenNamePascalCase}State, ${screenNamePascalCase}Cubit> {
  const ${screenNamePascalCase}Page({super.key});

  @override
  Widget buildPage() {
    return const ${screenNamePascalCase}Screen();
  }

  @override
  ${screenNamePascalCase}Cubit createCubit() {
    return ${screenNamePascalCase}Cubit();
  }
}

class ${screenNamePascalCase}Screen extends StatefulWidget {
  const ${screenNamePascalCase}Screen({super.key});

  @override
  State<${screenNamePascalCase}Screen> createState() => ${screenNamePascalCase}ScreenState();
}

${_getScreenStateClass(templateType, screenNamePascalCase)} {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  String get title => '${screenNamePascalCase}';

  @override
  Widget ${_getBuildMethodName(templateType)}(BuildContext context, ${screenNamePascalCase}Cubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${screenNamePascalCase} Screen',
            style: AppStyle.bold24(),
          ),
          const SizedBox(height: 16),
          Text(
            'This is the ${screenName} screen',
            style: AppStyle.regular16(),
          ),
        ],
      ),
    );
  }
}
''';

  final file = File('$dirPath/${screenName}_screen.dart');
  file.writeAsStringSync(content);
  print('Generated: ${file.path}');
}

void _generateCubitFile(String dirPath, String screenName,
    String screenNameCamelCase, String screenNamePascalCase) {
  final content =
      '''import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import '${screenName}_state.dart';

class ${screenNamePascalCase}Cubit extends BaseCubit<${screenNamePascalCase}State> {
  late final AccountService accountService = locator.get();

  ${screenNamePascalCase}Cubit() : super(${screenNamePascalCase}State());

  @override
  void onInit() {
    super.onInit();
    // Add your initialization logic here
  }

  @override
  void onReady() {
    super.onReady();
    // Add your ready logic here
  }

  // Add your business logic methods here
  void doSomething() {
    // Example method
    emit(state.copyWith(isLoading: true));
    
    // Simulate async operation
    Future.delayed(const Duration(seconds: 1), () {
      if (!isClose) {
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
''';

  final file = File('$dirPath/${screenName}_cubit.dart');
  file.writeAsStringSync(content);
  print('Generated: ${file.path}');
}

void _generateStateFile(String dirPath, String screenName,
    String screenNameCamelCase, String screenNamePascalCase) {
  final content =
      '''import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class ${screenNamePascalCase}State extends BaseState {
  final String? errorMessage;
  final dynamic data; // Replace with your specific data type

  const ${screenNamePascalCase}State({
    this.errorMessage,
    this.data,
    super.isLoading = false,
  });

  ${screenNamePascalCase}State copyWith({
    bool? isLoading,
    String? errorMessage,
    dynamic data, // Replace with your specific data type
  }) {
    return ${screenNamePascalCase}State(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        data,
      ];
}
''';

  final file = File('$dirPath/${screenName}_state.dart');
  file.writeAsStringSync(content);
  print('Generated: ${file.path}');
}

String _toCamelCase(String input) {
  if (input.isEmpty) return input;
  final words = input.split('_');
  if (words.length == 1) return input.toLowerCase();

  return words.first.toLowerCase() +
      words.skip(1).map((word) => _capitalize(word)).join('');
}

String _toPascalCase(String input) {
  if (input.isEmpty) return input;
  final words = input.split('_');
  return words.map((word) => _capitalize(word)).join('');
}

String _capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String _getScreenStateClass(String templateType, String screenNamePascalCase) {
  switch (templateType) {
    case 'no_appbar':
      return 'class ${screenNamePascalCase}ScreenState extends BaseBlocNoAppBarPageState<${screenNamePascalCase}Screen, ${screenNamePascalCase}State, ${screenNamePascalCase}Cubit>';
    case 'primary_appbar':
      return 'class ${screenNamePascalCase}ScreenState extends BaseBlocPrimaryAppBarPageState<${screenNamePascalCase}Screen, ${screenNamePascalCase}State, ${screenNamePascalCase}Cubit>';
    default:
      return 'class ${screenNamePascalCase}ScreenState extends BaseBlocPageState<${screenNamePascalCase}Screen, ${screenNamePascalCase}State, ${screenNamePascalCase}Cubit>';
  }
}

String _getBuildMethodName(String templateType) {
  switch (templateType) {
    case 'no_appbar':
      return 'buildBody';
    default:
      return 'buildBody';
  }
}
