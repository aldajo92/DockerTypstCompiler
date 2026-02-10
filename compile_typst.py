#!/usr/bin/env python3
"""
Typst document compilation automator
Usage: python compile_typst.py [directory]
Example: python compile_typst.py class01
"""

import os
import sys
import subprocess
import argparse
from pathlib import Path
import time

class TypstCompiler:
    def __init__(self, base_dir=None):
        # If no base_dir is provided, use current working directory
        # This allows the script to work both from host and inside container
        if base_dir:
            self.base_dir = Path(base_dir)
        else:
            self.base_dir = Path.cwd()
        
    def find_main_typ(self, target_dir):
        """Searches for main.typ file in the specified directory"""
        # Handle both relative and absolute paths
        if Path(target_dir).is_absolute():
            target_path = Path(target_dir)
        else:
            target_path = self.base_dir / target_dir
            
        typ_path = target_path / "main.typ"
        if typ_path.exists():
            return typ_path
        
        # If main.typ is not found, search for any .typ file
        typ_files = list(target_path.glob("*.typ"))
        if typ_files:
            print(f"⚠️  main.typ not found, using {typ_files[0].name}")
            return typ_files[0]
        
        return None
    
    def find_all_typ_files(self, target_dir):
        """Finds all .typ files in the specified directory"""
        if Path(target_dir).is_absolute():
            target_path = Path(target_dir)
        else:
            target_path = self.base_dir / target_dir
            
        return list(target_path.glob("*.typ"))
    
    def compile_typst(self, typ_file):
        """Compiles the Typst file to PDF"""
        print(f"📄 Compiling: {typ_file}")
        
        # Change to the file directory
        original_dir = Path.cwd()
        os.chdir(typ_file.parent)
        
        try:
            # Compile with typst
            # Set root to /home/dockeruser to allow access to both ws_typst and templates
            print("🔄 Running typst compile...")
            result = subprocess.run(
                ['typst', 'compile', '--root', '/home/dockeruser', typ_file.name],
                capture_output=True,
                text=True,
                encoding='utf-8',
                errors='replace',
                timeout=60
            )
            
            if result.returncode != 0:
                print(f"❌ Error during compilation")
                self._show_typst_errors(result)
                return False
            
            # Check if PDF was generated
            pdf_file = typ_file.with_suffix('.pdf')
            
            if pdf_file.exists():
                print(f"✅ Compilation successful: {pdf_file}")
                print(f"📊 PDF size: {pdf_file.stat().st_size:,} bytes")
                
                # Show any warnings if present
                if result.stderr:
                    print("⚠️  Warnings:")
                    print(result.stderr)
                
                return True
            else:
                print(f"❌ PDF file was not generated")
                self._show_typst_errors(result)
                return False
                
        except subprocess.TimeoutExpired:
            print("❌ Timeout: Compilation took more than 60 seconds")
            return False
        except FileNotFoundError:
            print("❌ Error: typst is not installed or not in PATH")
            return False
        finally:
            os.chdir(original_dir)
    
    def _show_typst_errors(self, result):
        """Shows Typst errors in a readable format"""
        if result.stderr:
            print("Error output:")
            print(result.stderr)
        if result.stdout:
            print("Standard output:")
            print(result.stdout)
    
    def compile_all(self, target_dir):
        """Compiles all .typ files in the directory"""
        typ_files = self.find_all_typ_files(target_dir)
        
        if not typ_files:
            print(f"❌ No .typ files found in '{target_dir}'")
            return False
        
        print(f"Found {len(typ_files)} Typst file(s) to compile")
        
        success_count = 0
        for typ_file in typ_files:
            print(f"\n{'='*60}")
            if self.compile_typst(typ_file):
                success_count += 1
        
        print(f"\n{'='*60}")
        print(f"✅ Successfully compiled {success_count}/{len(typ_files)} file(s)")
        
        return success_count == len(typ_files)
    
    def watch_and_compile(self, typ_file):
        """Watch mode: automatically recompiles when file changes"""
        print(f"👀 Watch mode activated for {typ_file}")
        print("Press Ctrl+C to exit")
        
        last_modified = typ_file.stat().st_mtime
        
        try:
            while True:
                current_modified = typ_file.stat().st_mtime
                if current_modified > last_modified:
                    print(f"\n🔄 File modified, recompiling...")
                    self.compile_typst(typ_file)
                    last_modified = current_modified
                time.sleep(1)
        except KeyboardInterrupt:
            print("\n👋 Watch mode terminated")

def main():
    parser = argparse.ArgumentParser(description='Automatic Typst compiler')
    parser.add_argument('directory', nargs='?', default='.', 
                       help='Directory containing the Typst file (default: current directory)')
    parser.add_argument('--all', '-a', action='store_true',
                       help='Compile all .typ files in the directory')
    parser.add_argument('--watch', '-w', action='store_true',
                       help='Watch mode: automatically recompile when file changes')
    
    args = parser.parse_args()
    
    compiler = TypstCompiler()
    
    if args.all:
        # Compile all .typ files in directory
        success = compiler.compile_all(args.directory)
        sys.exit(0 if success else 1)
    else:
        # Search for main Typst file
        typ_file = compiler.find_main_typ(args.directory)
        
        if not typ_file:
            print(f"❌ No .typ file found in '{args.directory}'")
            sys.exit(1)
        
        if args.watch:
            # Compile once first
            compiler.compile_typst(typ_file)
            # Then enter watch mode
            compiler.watch_and_compile(typ_file)
        else:
            # Single compilation
            success = compiler.compile_typst(typ_file)
            sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()

