# Java Development Setup for Neovim

Your Neovim configuration has been successfully configured for Java development! Here's what's been added:

## 🚀 Features Added

### 1. **Java LSP Support**
- **jdtls** (Java Development Tools Language Server) configured
- Auto-completion, go-to-definition, error checking
- Automatic imports organization
- Code navigation and refactoring

### 2. **Java Debugging**
- Java debugging support through nvim-dap
- Debug configurations for both attach and launch modes
- Integration with Mason for easy debug adapter installation

### 3. **Enhanced Syntax Highlighting**
- Tree-sitter parser for Java with full syntax highlighting
- Support for Java 11, 17, and 21 features
- Proper indentation (4 spaces) for Java files

### 4. **Java-Specific Key Mappings**

#### Global Mappings:
- `<F5>` or `<leader>r` - Compile and run current Java file
- `<leader>jf` - Create new Java file from template

#### Java File Mappings (only active in .java files):
- `<leader>jo` - Organize imports
- `<leader>jv` - Extract variable
- `<leader>jc` - Extract constant  
- `<leader>jm` - Extract method
- `<leader>jt` - Run tests for current class
- `<leader>jn` - Run nearest test method
- `<leader>jd` - Open Java documentation
- `<leader>jb` - Gradle build
- `<leader>jB` - Maven build

### 5. **Java Abbreviations**
When editing Java files, you can use these abbreviations:
- `sout` → `System.out.println();`
- `souf` → `System.out.printf();`
- `psvm` → `public static void main(String[] args) {}`
- `fori` → `for (int i = 0; i < ; i++) {}`
- `fore` → `for ( : ) {}`
- `ife` → `if () {}`
- `tryc` → `try {} catch (Exception e) {}`

### 6. **Project Management**
- Auto-detection of Maven/Gradle projects
- Support for project navigation
- Integration with Telescope for file searching

### 7. **Code Snippets**
- Ready-to-use snippets for common Java patterns
- Class, method, constructor, getter/setter templates
- JUnit test templates

### 8. **Testing Support**
- Neotest integration for running Java tests
- Support for JUnit and other testing frameworks

## 🔧 How to Use

### Running Java Code:
1. Open a Java file in Neovim
2. Press `<F5>` or `<leader>r` to compile and run
3. The code will be compiled with `javac` and executed with `java`

### Creating New Java Files:
1. Press `<leader>jf`
2. Enter the class name (without .java extension)
3. A template file will be created with proper structure

### Working with Projects:
1. Navigate to your Java project directory
2. Open Neovim - it will automatically detect Maven/Gradle projects
3. LSP features will be available automatically

## 📁 Files Modified/Created:

1. **Plugins Added:**
   - `nvim-jdtls` - Java LSP client
   - `neotest` + `neotest-java` - Testing framework
   - `project.nvim` - Project management

2. **Configuration Files:**
   - `lua/plugins/java.lua` - Java-specific plugin configuration
   - `lua/plugins/lsp-config.lua` - Updated with Java LSP settings
   - `lua/plugins/debugging.lua` - Java debugging configuration
   - `lua/plugins/treesitter.lua` - Java syntax highlighting
   - `ftplugin/java.lua` - Java file-specific settings
   - `templates/java_class.java` - Template for new Java files
   - `snippets/java.snippets` - Java code snippets

## 🛠 Requirements Met:
- ✅ Java compilation and execution
- ✅ Syntax highlighting and LSP support
- ✅ Code completion and navigation
- ✅ Debugging support
- ✅ Project management for Maven/Gradle
- ✅ Easy file creation and templates
- ✅ Testing framework integration

Your Neovim is now fully equipped for Java development! 🎉

## 🔄 Next Steps:
1. Try creating a new Java file with `<leader>jf`
2. Test the compile and run feature with `<F5>`
3. Explore LSP features like go-to-definition (`<leader>gd`)
4. Set up a Maven or Gradle project to test full project support

Happy Java coding in Neovim! ☕
