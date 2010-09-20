Nubular - Gems for .NET
=======
**Nu will automatically download and install specified library packages into your lib folder, along with all their dependencies.**

*IMPORTANT: This is so alpha its omega...*

For more information, check out the project wiki: [http://nu.wikispot.org/][1]

Inspired by bundler for ruby:
[http://yehudakatz.com/2009/11/03/using-the-new-gem-bundler-today/][2]

# USAGE
	Usage:
	    nu -h/--help
	    nu -v/--version
	    nu COMMAND [arguments...] [options...]

	Options and Switches:
	    -v, --version VERSION            Specify version of package to install
	    -r, --report                     Report on the packages currently installed in the lib folder. When called as a switch it will run the report AFTER executing the requested command.
	    -V, --verbose
	    -q, --quiet
	        --json                       Run in JSON mode. All outputs will be in JSON, status messages silenced.
	    -h, --help                       Display this screen

###Examples

  * `nu install log4net` - Install the most current version of log4net in your gem cache, downloading it if required.
  * `nu install log4net --version 1.2.3` - Install version 1.2.3 of log4net, downloading it if required.
  * `nu install log4net --report` - Install log4net and then output a list of all the packages in the lib folder.
  * `nu report` - Just output a list of all the packages in the lib folder.
  * `nu config lib.location ./third_party`
  * `nu config lib.use_long_names true`

# COMMANDS

The following commands are available:

  * `install PACKAGE [options...]` - Installs the specified package into the folder configured in `lib.location`. The `--version VERSION` switch can be used to specify a specific version of the package.
  * `report` - Outputs a report listing the currently installed packages in the lib folder.
  * `propose PACKAGE [options...]` - Analyzes what installing the proposed package would do to your lib folder. The `--version VERSION` switch can be used to specify a specific version of the package.
  * `config OPTION_NAME VALUE` - Stores the specified value for the specified configuration option.
  * `config OPTION_NAME` - Displays the current value for the specified configuration option.

# CONFIG

The `config` command works a lot like Git's. You can pass in any string and the value will be stored. If there is code that cares about the value you set, it will be affected, otherwise nothing will happen.

These are the current active config values:

  * `lib.location` - The path to the library folder Nu will be placing the packages into. Defaults to `./lib`
  * `lib.use_long_names` - If `true` Nu will place the packages in folders that include the version number. i.e. `log4net-1.2.3`. Defaults to `false`. (Note: this option can make it difficult to upgrade packages in the future as all the project references will have to be adjusted if the version changes.)

And, coming soon:

  * `platform` - Specifies the specific .net platform to target. (When a package cares.)

# API/Integration

The `--json` switch is useful for integrating with `nu`. Passing `--json` will cause chatty stuff to be silenced and normal output to be JSON structures.

For debugging, using `--json --verbose` will cause debug logging to `nu.log`

**Hint:** Use the `--report` with `--json` to have nu update with the final state of the folder.

The plan is that each new feature will be made available via JSON as well as through the normal CLI interface.

*`--version`, to get the version of nu, does not work with the `--json` switch. `--version` as an option to INSTALL does though.*

# LICENSE
Apache 2.0 - see docs\legal (just LEGAL in the zip folder)

# REQUIREMENTS
* Ruby 1.8.7 - Windows users can install it easily: [http://rubyforge.org/frs/download.php/72085/rubyinstaller-1.8.7-p302.exe][3]

# CREDITS
see legal\CREDITS

[1]: http://nu.wikispot.org/
[2]: http://yehudakatz.com/2009/11/03/using-the-new-gem-bundler-today/
[3]: http://rubyforge.org/frs/download.php/72085/rubyinstaller-1.8.7-p302.exe