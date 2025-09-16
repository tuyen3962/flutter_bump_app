#!/bin/bash

# Flutter Screen Generator Script
# Usage: ./generate_screen.sh <screen_name> [template_type]
# Template types: basic, no_appbar, primary_appbar

if [ $# -eq 0 ]; then
    echo "Usage: ./generate_screen.sh <screen_name> [template_type]"
    echo "Template types:"
    echo "  basic (default) - Basic screen with app bar"
    echo "  no_appbar - Screen without app bar"
    echo "  primary_appbar - Screen with primary styled app bar"
    echo ""
    echo "Example: ./generate_screen.sh home basic"
    exit 1
fi

SCREEN_NAME=$1
TEMPLATE_TYPE=${2:-basic}

echo "🚀 Generating Flutter screen: $SCREEN_NAME"
echo "📋 Template type: $TEMPLATE_TYPE"
echo ""

# Run the Dart generator
dart generate_screen.dart "$SCREEN_NAME" "$TEMPLATE_TYPE"

# Make the script executable
chmod +x generate_screen.sh

echo ""
echo "🎉 Screen generation completed!"
echo ""
echo "💡 Pro tip: Add this to your PATH or create an alias:"
echo "   alias gen-screen='./generate_screen.sh'"
