-- Kotlin-specific settings and keymaps
-- This file is automatically loaded when opening Kotlin files

-- Set Kotlin-specific options
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.textwidth = 120
vim.opt_local.colorcolumn = "120"

-- Kotlin-specific abbreviations for common patterns
vim.cmd([[
  iabbrev <buffer> fun fun (): {<cr>}<up><end><left><left><left><left><left>
  iabbrev <buffer> main fun main() {<cr>}<up><end>
  iabbrev <buffer> println println()<left>
  iabbrev <buffer> print print()<left>
  iabbrev <buffer> fori for (i in 0 until ) {<cr>}<up><end><left><left><left><left><left><left><left><left><left>
  iabbrev <buffer> fore for ( in ) {<cr>}<up><end><left><left><left><left><left><left><left>
  iabbrev <buffer> ife if () {<cr>}<up><end><left><left><left>
  iabbrev <buffer> tryc try {<cr>} catch (e: Exception) {<cr>}<up><up><end>
  iabbrev <buffer> class class  {<cr>}<up><end><left><left><left>
  iabbrev <buffer> data data class ()<cr>
  iabbrev <buffer> companion companion object {<cr>}<up><end>
]])

-- Kotlin-specific keymaps (only active in Kotlin buffers)
local opts = { noremap = true, silent = true, buffer = true }

-- Auto-detect project type and set appropriate build commands
local function detect_kotlin_project_type()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. "/build.gradle.kts") == 1 or vim.fn.filereadable(cwd .. "/build.gradle") == 1 then
    return "gradle"
  elseif vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
    return "maven"
  else
    return "simple"
  end
end

local project_type = detect_kotlin_project_type()

-- Enhanced project-specific build commands
if project_type == "gradle" then
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!./gradlew run<cr>", opts)
  vim.keymap.set("n", "<leader>kb", "<cmd>!./gradlew build<cr>", opts)
  vim.keymap.set("n", "<leader>kr", "<cmd>!./gradlew run<cr>", opts)
  vim.keymap.set("n", "<leader>kt", "<cmd>!./gradlew test<cr>", opts)
  vim.keymap.set("n", "<leader>kc", "<cmd>!./gradlew clean<cr>", opts)
  vim.keymap.set("n", "<leader>kd", "<cmd>!./gradlew dependencies<cr>", opts)
elseif project_type == "maven" then
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!mvn compile exec:java<cr>", opts)
  vim.keymap.set("n", "<leader>kb", "<cmd>!mvn compile<cr>", opts)
  vim.keymap.set("n", "<leader>kr", "<cmd>!mvn exec:java<cr>", opts)
  vim.keymap.set("n", "<leader>kt", "<cmd>!mvn test<cr>", opts)
  vim.keymap.set("n", "<leader>kc", "<cmd>!mvn clean<cr>", opts)
  vim.keymap.set("n", "<leader>kd", "<cmd>!mvn dependency:tree<cr>", opts)
else
  -- Simple Kotlin compilation
  vim.keymap.set("n", "<F5>", "<cmd>w<cr><cmd>!kotlinc % -include-runtime -d %:r.jar && java -jar %:r.jar<cr>", opts)
end

-- Universal Kotlin keymaps
-- Quick compile and run (fallback to simple compilation)
vim.keymap.set("n", "<leader>kR", "<cmd>w<cr><cmd>!kotlinc % -include-runtime -d %:r.jar && java -jar %:r.jar<cr>", opts)

-- Open Kotlin documentation
vim.keymap.set("n", "<leader>kD", "<cmd>!firefox https://kotlinlang.org/docs/<cr>", opts)

-- Enhanced project creation
-- Create Gradle Kotlin project structure
vim.keymap.set("n", "<leader>kgp", function()
  local project_name = vim.fn.input("Kotlin Gradle Project name: ")
  if project_name ~= "" then
    vim.fn.system("mkdir -p " .. project_name .. "/src/main/kotlin")
    vim.fn.system("mkdir -p " .. project_name .. "/src/test/kotlin")
    vim.fn.system("mkdir -p " .. project_name .. "/src/main/resources")
    
    -- Create basic build.gradle.kts
    local gradle_content = [[
plugins {
    kotlin("jvm") version "1.9.10"
    application
}

group = "com.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    testImplementation(kotlin("test"))
    testImplementation("org.junit.jupiter:junit-jupiter:5.9.2")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(17)
}

application {
    mainClass.set("com.example.MainKt")
}
]]
    vim.fn.writefile(vim.split(gradle_content, '\n'), project_name .. "/build.gradle.kts")
    vim.cmd("cd " .. project_name)
    print("Created Kotlin Gradle project: " .. project_name)
  end
end, opts)

-- Create Kotlin Main file template
vim.keymap.set("n", "<leader>km", function()
  local main_template = [[
package com.example

fun main() {
    println("Hello, Kotlin!")
}
]]
  
  local filename = "Main.kt"
  vim.fn.writefile(vim.split(main_template, '\n'), filename)
  vim.cmd("edit " .. filename)
end, opts)

-- Create Kotlin class template
vim.keymap.set("n", "<leader>kclass", function()
  local class_name = vim.fn.input("Kotlin Class name: ", vim.fn.expand("%:t:r"))
  local class_template = string.format([[
package com.example

class %s {
    
}
]], class_name)
  
  local filename = class_name .. ".kt"
  vim.fn.writefile(vim.split(class_template, '\n'), filename)
  vim.cmd("edit " .. filename)
end, opts)

-- Create Kotlin data class template
vim.keymap.set("n", "<leader>kdata", function()
  local class_name = vim.fn.input("Data Class name: ")
  local data_template = string.format([[
package com.example

data class %s(
    
)
]], class_name)
  
  local filename = class_name .. ".kt"
  vim.fn.writefile(vim.split(data_template, '\n'), filename)
  vim.cmd("edit " .. filename)
end, opts)
