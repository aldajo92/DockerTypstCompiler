# Docker Typst Compiler

This project provides a Docker container that uses [Typst](https://typst.app/) to compile modern documents. Typst is a new markup-based typesetting system that is designed to be an alternative to LaTeX. Typst projects should be organized as subfolders within the [`ws_typst`](./ws_typst/) directory.

## Prerequisites

- Docker installed on your system.
- Basic knowledge of Typst document structure (see [Typst Documentation](https://typst.app/docs/)).

## Setup

1. **Clone the repository with submodules:**
   ```bash
   git clone --recurse-submodules https://github.com/aldajo92/DockerTypstCompiler.git
   ```
   
   Or if you already cloned it, initialize submodules:
   ```bash
   git submodule update --init --recursive
   ```

2. **Build the Docker container** (Required only once or if [Dockerfile](./Dockerfile) is modified):
   ```bash
   ./scripts/build.sh
   ```

3. **(Optional) Enable the `compile_typst` command globally:**

   Source the [`setup.bash`](./setup.bash) script to make the `compile_typst` command available from any directory:
   ```bash
   source ~/DockerTypstCompiler/setup.bash
   ```

   To load it automatically on every new terminal, add the line above to your `~/.bashrc` or `~/.zshrc`.

## Project Structure

### Templates Folder

The [`templates`](./templates/) directory contains reusable Typst templates from GitHub repositories. These templates can be referenced in your projects using relative paths:

```typst
#import "../../templates/diatypst/lib.typ": *
```

**Available templates:**
- `diatypst` - Professional presentation template with modern styling (added as git submodule)

To add more templates from GitHub, use git submodules:
```bash
git submodule add <repository-url> templates/<template-name>
```

### Workspace Folder

The [`ws_typst`](./ws_typst/) directory is where you create your Typst projects. Each project should be in its own subfolder and can import templates from the templates folder.

## Usage

### Basic Compilation

1. **Create your Typst project** in the [`ws_typst`](./ws_typst/) directory
    ```
    ws_typst/
    ├── your_project/
    │   ├── main.typ          # Main Typst file (*.typ)
    │   ├── references.bib    # Bibliography file (optional)
    │   ├── images/           # Images directory (optional)
    │   └── ...              # Other Typst files
    ```
2. **Compile your project:**
   ```bash
   ./scripts/compile.sh your_project
   ```
   
   Or with the full path:
   ```bash
   ./scripts/compile.sh ws_typst/your_project
   ```

### Using `compile_typst` (from any directory)

If you sourced [`setup.bash`](./setup.bash) (see [Setup step 3](#setup)), you can compile from anywhere:

```bash
# From inside a project folder (e.g., ws_typst/your_project/)
compile_typst .

# From any directory, using the project name
compile_typst your_project

# Nested projects work too
compile_typst IVV_SteerAI/IVV_Way
```

## Examples

### Basic Document
Compiling the test project:
```bash
./scripts/compile.sh test
```
Or with `compile_typst`:
```bash
compile_typst test
```

### Presentation with Template
Compiling the presentation example (uses diatypst template):
```bash
./scripts/compile.sh presentation_example
```
Or with `compile_typst`:
```bash
compile_typst presentation_example
```

## About Typst

Typst is a modern markup-based typesetting system that offers:
- **Fast compilation** - Near-instant feedback
- **Clean syntax** - More intuitive than LaTeX
- **Modern features** - Built-in support for modern typography
- **Great error messages** - Easy to debug

Learn more at [typst.app](https://typst.app/)

## License

This project is licensed under a custom Academic/Personal Use License. See the [LICENSE](./LICENCE) file for details.

## Author

**Alejandro Daniel José Gómez Flórez**  
[LinkedIn](http://linkedin.com/in/aldajo92) | [GitHub](https://github.com/aldajo92)