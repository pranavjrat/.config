-- Java-specific settings and keymaps
-- This file is automatically loaded when opening Java files

-- Set Java-specific options
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 120
vim.opt_local.colorcolumn = "120"

-- Java-specific abbreviations for common patterns
vim.cmd([[
  iabbrev <buffer> sout System.out.println();<left><left>
  iabbrev <buffer> souf System.out.printf();<left><left>
  iabbrev <buffer> psvm public static void main(String[] args) {<cr>}<up><end>
  iabbrev <buffer> fori for (int i = 0; i < ; i++) {<cr>}<up><end><left><left><left><left><left><left><left><left><left>
  iabbrev <buffer> fore for ( : ) {<cr>}<up><end><left><left><left><left><left><left><left>
  iabbrev <buffer> ife if () {<cr>}<up><end><left><left><left>
  iabbrev <buffer> tryc try {<cr>} catch (Exception e) {<cr>}<up><up><end>
  iabbrev <buffer> jfxapp public class extends Application {<cr>@Override<cr>public void start(Stage primaryStage) {<cr>}<cr>}<up><up><up><end><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
  iabbrev <buffer> test @Test<cr>public void test() {<cr>}<up><end><left><left><left><left><left><left><left><left>
  iabbrev <buffer> junit @Test<cr>public void () {<cr>// Arrange<cr><cr>// Act<cr><cr>// Assert<cr>}<up><up><up><up><up><up><end><left><left><left><left>
]])

-- Auto-detect project type and set appropriate settings
local function detect_project_type()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. "/build.gradle") == 1 or vim.fn.filereadable(cwd .. "/build.gradle.kts") == 1 then
    return "gradle"
  elseif vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
    return "maven"
  else
    return "simple"
  end
end

local project_type = detect_project_type()

-- Java-specific keymaps (only active in Java buffers)
local opts = { noremap = true, silent = true, buffer = true }

-- Enhanced project-specific build commands
if project_type == "gradle" then
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!./gradlew run<cr>", opts)
  vim.keymap.set("n", "<leader>jb", "<cmd>!./gradlew build<cr>", opts)
  vim.keymap.set("n", "<leader>jr", "<cmd>!./gradlew run<cr>", opts)
  vim.keymap.set("n", "<leader>jt", "<cmd>!./gradlew test<cr>", opts)
  vim.keymap.set("n", "<leader>jc", "<cmd>!./gradlew clean<cr>", opts)
  vim.keymap.set("n", "<leader>jd", "<cmd>!./gradlew dependencies<cr>", opts)
  -- JavaFX specific
  vim.keymap.set("n", "<leader>jfx", "<cmd>!./gradlew javafx:run<cr>", opts)
elseif project_type == "maven" then
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!mvn compile exec:java<cr>", opts)
  vim.keymap.set("n", "<leader>jb", "<cmd>!mvn compile<cr>", opts)
  vim.keymap.set("n", "<leader>jr", "<cmd>!mvn exec:java<cr>", opts)
  vim.keymap.set("n", "<leader>jt", "<cmd>!mvn test<cr>", opts)
  vim.keymap.set("n", "<leader>jc", "<cmd>!mvn clean<cr>", opts)
  vim.keymap.set("n", "<leader>jd", "<cmd>!mvn dependency:tree<cr>", opts)
  -- JavaFX specific
  vim.keymap.set("n", "<leader>jfx", "<cmd>!mvn javafx:run<cr>", opts)
else
  -- Simple Java compilation
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!javac % && java %:r<cr>", opts)
end

-- Universal Java keymaps
-- Quick compile and run (fallback to simple compilation)
vim.keymap.set("n", "<leader>jR", "<cmd>w<cr><cmd>!javac % && java %:r<cr>", opts)

-- Open Java documentation
vim.keymap.set("n", "<leader>jd", "<cmd>!firefox https://docs.oracle.com/en/java/javase/17/docs/api/<cr>", opts)

-- Enhanced JDTLS keymaps
-- Generate getter/setter
vim.keymap.set("n", "<leader>jg", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return string.match(action.title, "Generate")
    end,
    apply = true
  })
end, opts)

-- Organize imports
vim.keymap.set("n", "<leader>jo", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return string.match(action.title, "Organize imports")
    end,
    apply = true
  })
end, opts)

-- Extract variable/method/constant
vim.keymap.set("n", "<leader>je", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return string.match(action.title, "Extract")
    end,
    apply = false
  })
end, opts)

-- Create test class
vim.keymap.set("n", "<leader>jtc", function()
  local current_file = vim.fn.expand("%:t:r")
  local test_file = current_file .. "Test.java"
  local test_path = "src/test/java/" .. test_file
  
  -- Create test directory if it doesn't exist
  vim.fn.system("mkdir -p src/test/java")
  
  -- Template for test class
  local test_template = string.format([[
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api.Assertions.*;

class %sTest {
    
    private %s %s;
    
    @BeforeEach
    void setUp() {
        %s = new %s();
    }
    
    @AfterEach
    void tearDown() {
        %s = null;
    }
    
    @Test
    void test%s() {
        // Arrange
        
        // Act
        
        // Assert
        fail("Test not implemented");
    }
}
]], current_file, current_file, string.lower(current_file), string.lower(current_file), current_file, string.lower(current_file), current_file)
  
  vim.fn.writefile(vim.split(test_template, '\n'), test_path)
  vim.cmd("edit " .. test_path)
end, opts)

-- Enhanced project creation
-- Create Maven project structure
vim.keymap.set("n", "<leader>jmp", function()
  local project_name = vim.fn.input("Maven Project name: ")
  local group_id = vim.fn.input("Group ID (com.example): ", "com.example")
  if project_name ~= "" then
    vim.cmd("!mvn archetype:generate -DgroupId=" .. group_id .. " -DartifactId=" .. project_name .. " -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false")
  end
end, opts)

-- Create Gradle project structure
vim.keymap.set("n", "<leader>jgp", function()
  local project_name = vim.fn.input("Gradle Project name: ")
  if project_name ~= "" then
    vim.fn.system("mkdir -p " .. project_name .. "/src/main/java")
    vim.fn.system("mkdir -p " .. project_name .. "/src/test/java")
    vim.fn.system("mkdir -p " .. project_name .. "/src/main/resources")
    
    -- Create basic build.gradle with JavaFX support
    local gradle_content = [[
plugins {
    id 'application'
    id 'org.openjfx.javafxplugin' version '0.1.0'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.openjfx:javafx-controls:21'
    implementation 'org.openjfx:javafx-fxml:21'
    
    testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

javafx {
    version = '21'
    modules = ['javafx.controls', 'javafx.fxml']
}

application {
    mainClass = 'com.example.Main'
}

test {
    useJUnitPlatform()
}
]]
    vim.fn.writefile(vim.split(gradle_content, '\n'), project_name .. "/build.gradle")
    vim.cmd("cd " .. project_name)
    print("Created Gradle project: " .. project_name)
  end
end, opts)

-- Create JavaFX Application template
vim.keymap.set("n", "<leader>jfxa", function()
  local app_name = vim.fn.input("JavaFX Application name: ", "MainApp")
  local javafx_template = string.format([[
package com.example;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class %s extends Application {
    
    @Override
    public void start(Stage primaryStage) {
        Label label = new Label("Hello JavaFX!");
        StackPane root = new StackPane(label);
        
        Scene scene = new Scene(root, 300, 250);
        
        primaryStage.setTitle("JavaFX Application");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    
    public static void main(String[] args) {
        launch(args);
    }
}
]], app_name)
  
  local filename = app_name .. ".java"
  vim.fn.writefile(vim.split(javafx_template, '\n'), filename)
  vim.cmd("edit " .. filename)
end, opts)
