# Docker Typst Compiler

This project provides a Docker container that uses [Typst](https://typst.app/) to compile modern documents. Typst is a new markup-based typesetting system that is designed to be an alternative to LaTeX. Typst projects should be organized as subfolders within the [`ws_typst`](./ws_typst/) directory.

## Prerequisites

- Docker installed on your system.
- Basic knowledge of Typst document structure (see [Typst Documentation](https://typst.app/docs/)).

## Setup

Build the Docker container (Required only once or if [Dockerfile](./Dockerfile) is modified):
   ```bash
   ./scripts/build.sh
   ```

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

## Examples

Compiling the test project:
```bash
./scripts/compile.sh test
```

Compiling the test project (alternative):
```bash
./scripts/compile.sh ws_typst/test
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