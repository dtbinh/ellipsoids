Previously the system parameters were specified via ellOptions structure. Now this structure is no longer used and the system is configured via xml files available via a set of command-line utilities:

```
elltool.editconf %used for editing the existing configuration, 
%run elltool.editconf('default') to open the configuration named 'default' in Matlab text editor.
elltool.setconf %sets the configuration based on its name
%
%run elltool.setconf('mynewconf') to load all the settings from 'mynewconf'. By default, upon the system initialization all the paramters are loaded from the configuration named 'default'
%
elltool.copyconf %creates a copy of the specified configuration saving it on disk under the some other specified name
%run elltool.copyconf('default','mynewconf') creates a new configuration named 'mynewconf' as a copy of the configuration named 'default'
```
Once the configuration is loaded, the system parameters are available via elltool.conf.Properties static class via getters. Some of the parameters can be changed in run-time via setters.

```
%
elltool.conf.Properties.getAbsTol(); %would return a current value of absolute tolerance.
%
elltool.conf.Properties.setVerbosity(true); %would set the verbosity level of the system to the maximum level.
```