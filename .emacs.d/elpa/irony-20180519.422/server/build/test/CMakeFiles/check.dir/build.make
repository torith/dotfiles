# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.12.1/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.12.1/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build

# Utility rule file for check.

# Include the progress variables for this target.
include test/CMakeFiles/check.dir/progress.make

test/CMakeFiles/check:
	cd /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build/test && /usr/local/Cellar/cmake/3.12.1/bin/ctest --output-on-failure

check: test/CMakeFiles/check
check: test/CMakeFiles/check.dir/build.make

.PHONY : check

# Rule to build all files generated by this target.
test/CMakeFiles/check.dir/build: check

.PHONY : test/CMakeFiles/check.dir/build

test/CMakeFiles/check.dir/clean:
	cd /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build/test && $(CMAKE_COMMAND) -P CMakeFiles/check.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/check.dir/clean

test/CMakeFiles/check.dir/depend:
	cd /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/test /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build/test /Users/torith/Project/dotfiles/.emacs.d/elpa/irony-20180519.422/server/build/test/CMakeFiles/check.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/check.dir/depend

