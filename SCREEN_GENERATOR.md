# Flutter Screen Generator

This tool automatically generates Flutter screen files following the project's established architecture pattern based on the splash screen structure.

## 🚀 Features

- **Consistent Architecture**: Follows the same pattern as existing screens (splash, signin)
- **Multiple Templates**: Support for different screen types
- **Auto-Generated Files**: Creates screen, cubit, and state files
- **Type Safety**: Proper imports and type annotations
- **Ready to Use**: Generated files are immediately functional

## 📁 Generated Structure

For each screen, the generator creates:
```
lib/screen/<screen_name>/
├── <screen_name>_screen.dart    # UI components and page setup
├── <screen_name>_cubit.dart     # Business logic and state management  
└── <screen_name>_state.dart     # State model with copyWith method
```

## 🎯 Usage

### Command Line (Dart)
```bash
dart generate_screen.dart <screen_name> [template_type]
```

### Shell Script (Recommended)
```bash
./generate_screen.sh <screen_name> [template_type]
```

### Examples
```bash
# Generate basic screen with app bar
./generate_screen.sh home basic

# Generate screen without app bar  
./generate_screen.sh onboarding no_appbar

# Generate screen with primary styled app bar
./generate_screen.sh dashboard primary_appbar
```

## 📋 Template Types

| Template | Description | Base Class |
|----------|-------------|------------|
| `basic` (default) | Standard screen with app bar | `BaseBlocPageState` |
| `no_appbar` | Screen without app bar | `BaseBlocNoAppBarPageState` |
| `primary_appbar` | Screen with primary styled app bar | `BaseBlocPrimaryAppBarPageState` |

## 📝 Generated File Structure

### Screen File (`*_screen.dart`)
- `@RoutePage()` annotated page class extending `BaseBlocProvider`
- StatefulWidget screen class
- State class extending appropriate base class
- Basic UI structure with customizable `buildBody` method

### Cubit File (`*_cubit.dart`)
- Business logic class extending `BaseCubit`
- AccountService integration
- Lifecycle methods (`onInit`, `onReady`)
- Example business logic method

### State File (`*_state.dart`)
- Immutable state class extending `BaseState`
- `copyWith` method for state updates
- Proper `props` implementation for Equatable

## 🔧 Post-Generation Steps

After generating a screen:

1. **Add Route**: Update `lib/router/app_route.dart` with the new route
2. **Generate Routes**: Run `dart run build_runner build`
3. **Implement Logic**: Add your specific business logic to the generated files
4. **Customize UI**: Modify the `buildBody` method to implement your screen design

## 💡 Tips

- Use snake_case for screen names (e.g., `user_profile`, `order_history`)
- The generator automatically converts to PascalCase for class names
- Generated files include helpful comments for customization
- All imports and dependencies are pre-configured

## 🛠️ Setup

Make the scripts executable:
```bash
chmod +x generate_screen.dart generate_screen.sh
```

Optional: Add to your shell profile for global access:
```bash
# Add to ~/.zshrc or ~/.bashrc
alias gen-screen='cd /path/to/your/project && ./generate_screen.sh'
```

## 🏗️ Architecture Pattern

The generated screens follow this architecture:

```
Page (BaseBlocProvider)
  └── Screen (StatefulWidget)
      └── ScreenState (BaseBlocPageState)
          ├── Cubit (BaseCubit)
          └── State (BaseState)
```

This ensures:
- ✅ Consistent code structure
- ✅ Proper state management with BLoC
- ✅ Lifecycle management
- ✅ Error handling patterns
- ✅ Loading states
- ✅ Type safety

## 🎨 Customization

After generation, you can customize:

- **UI**: Modify `buildBody` method in the screen state
- **Business Logic**: Add methods to the cubit class
- **State Properties**: Extend the state class with additional fields
- **Styling**: Use different base classes or override style methods

---

**Happy Coding!** 🎉
