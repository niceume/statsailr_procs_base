# About statsailr_procs_base gem

This 'statsailr_procs_base' gem provides a collection of fundamental PROC settings and make PROCs available for StatSailr program. The 'statsailr' gem does not have PROC settings, and this gem is essential for StatSailr to provide a useful statistics system.

The reason why these basic PROC settings are separated as 'statsailr_procs_base' gem from the main 'statsailr' gem is maintainability. The StatSailr system (i.e. main system + PROCs) is still under development, and is updated frequently. PROCs and main system do not have specific release cycles yet. For those reasons, it is better to update them as separate gems.


## Installation

This gem is usually installed together with 'statsailr' gem, following the dependency setting in statsailr.gemspec. If you want to try the most up-to-date version, manually install it from Github.


## How each StatSailr's PROC functionality is defined

How each PROC block behaves or what instructions they have is defined as PROC settings. This gem provides those PROC settings. StatSailr calls PROCs providing gem's path_to_proc_setting method (StatSailr::ProcsBase::path_to_proc_setting in this gem), and uses the path information to access the gem's PROC settings. The method returns the base dicrectory path that contains PROC settings (a.k.a. lib/statsailr_procs_base/proc_setting directory). Based on the PROCs called from StatSailr, its corresponding setting files are identified and settings are loaded. Based on the settings, appropriate R functions are generated and executed.

Following these settings, StatSailr converts PROC block to a series of R functions. PROC settings are written in Ruby modules. Internally StatSailr creates a Ruby object for each block, and those objects extend their functionality by mixing-in corresponding PROC setting module. Currently, those files and module names are determined from PROC's command name. For example, if the block starts with 'PROC CAT', 'ProcCat' module written in 'proc_cat.rb' is the module to be used for functionality extension.


## Understanding PROC settings

The following is typical PROC setting and its explanation.

```
# proc_print.rb

module ProcPrint
  def setting_for_head( setting )
    setting.libname = "utils"
    setting.func_name = "head"
    setting.main_arg_and_how_to_treat =  [ "n", "read_as_intvec", "allow_nil"]
    setting.runtime_args = { "x" => param("data")}
    setting.store_result = false
    setting.print_opt = true
  end
end
```

* module ProcPrint
    + This module is setting for 'PROC PRINT' block.
* def setting_for_head
    + This function is setting for 'head' instruction.
* setting.libname
    + When libname is specified, the function is looked up from the package.
        + In the above example, it is equivalent to utils::head()
    + When libname is set nil, the function is looked up from environment or Global.
* setting.envname
    + When libname is set nil, and envname is specified, the function is looked up from this environment.
        + This enables R functions to be called with environment name, and each PROC can implement its own R functions within their environment, and prevents function name conflicts.
* setting.func_name
    + R's function name to be called.
        + package name or environment name can be specified as mentioned above.
* setting.main_arg_and_how_to_treat
    + This is spcified in Array of length 3.
    + The first element is R's function argument name to be passed to.
    + The second element of its value is how to treat the main argument.
    + The third element of its value is whether to allow not specifying main argument. "allow_nil" or "no_nil"
        + In the above example, value specified for main argument is interpreted as intvec, and is passed to R funcion's 'x' argument. 
        + "allow_nil" allows users to omit main argument, and default value of 6 is used. (See head documentation https://stat.ethz.ch/R-manual/R-devel/library/utils/html/head.html ) 
    + If the instruction does not take a main argument, nil or [nil, nil, nil] is specified.
* setting.runtime_args
    + This is specified in Hash or nil.
    + This setting is used to pass objects that are generated at runtime to R function.
        + The objects include objects spcified in PROC options and results of previous instructions within the same block.
    + To define, param(), result() and one_from() methods can be used. Details are described later.
* setting.store_result
    + true/false
        + If this setting is true, this instruction's result can be accessed via setting.runtime_args.
        + If set false, this instruction's result cannot be accessed.
* setting.print_opt
    + true/false
        + If this setting is true, the result is printed out using "print" function.
        + If set false, the result is not printed out.
    + String
        + If String value is set, the result is printed out using the name specified.
* setting.plot_opt
    + true/false
        + Under the situation where graphics device does not show on display and tries to output to a file, this setting is valid.
            + If true, StatSailr conducts dev.copy() at the end of this current instruction, and saves graphics device content to file.
        + If the current graphics device outputs to display, this setting is useless and ignored.


## More about main_arg_and_how_to_treat

The following methods can be used to parse and convert PROC instruction main argument to R object. This method name needs to be specified in String.

* read_as_formula
* read_as_strvec
* read_as_one_str
* read_as_numvec
* read_as_intvec
* read_as_realvec
* read_as_symbol
* read_symbols_as_strvec



## More about setting.runtime_args

This setting is used to access objects that are generated at runtime, and pass those objects to R function. These objects include objects that are spcified in PROC args, and results that are returned from previous instrutions within the same block.

* param() method
    + param() can access object specified in PROC option. 
      + (The reason why 'param' is used for this access is that PROC option parameter is managed by RBridge::ParamManager.)
    + For example, "x" => param("data") means that passing an object that is named as "data" in PROC option, and passing it to "x" argument of R function. 
* result() method
    + result() can access a result object of an instruction that is specified by instruction name.
    + If result() method takes multiple argument or multiple instruction names, it returns ResultNameArray object.
        + The last result from specified instruction results is used.
* Pointer to R object
    + R object that is statically generated can also be used. Usually this can be used as a default value.
* one_from() method
    + one_from() method can take ResultName, ResultNameAray, PramName or pointer to R object.
    + one_from() can take multiple arguments, and their order defines priority about which object to use.
    + (e.g.) 'setting.runtime_args = {"data" => one_from( result("factor", "numeric"), param("data")) }' means the following
        + If there are already instructions of "factor" or "numeric", use the last result of them.
        + If not, object that is specified by "data" in PROC options in used.


## Enable custom R function

StatSailr PROC instructions can also call custom R functions that are not defined in R's libraries. source_r_file() method does this work. ProcSettingModule is a module that provides source_r_file() method. source_r_file() method lets R function defined in the file available from R or StatSailr PROC instructions.

The following example enables functions in proc_scatter.R . ( The setting file name is proc_scatter.rb and File.basename(__FILE__ , ".rb") + ".R" replaces the extension with ".R".) Note that source_r_file()'s first argument takes absolute path for the directory containing the R file. This restriction prevents from loading unintentional files.

```
# proc_scatter.rb
module ProcScatter
  include ProcSettingModule
  ...
  source_r_file( __dir__, File.basename(__FILE__ , ".rb") + ".R")
  ...
  ...
end
```

## Validate PROC options

Each PROC option (i.e. option that follows PROC command) can be validated. Option name, option value type and option requirement can be checked, and types are converted appropriately if necessary.

For example, in many PROCs, data option is required. To guarantee the existence of data option, pass "data" with "required: true" to validate_option().

* validate_option() method takes the following arguments
    + option_name : option to validate
    + is_a : value assigned to the option should belong to type(s) specified.
        + "Float", "Integer", "String" or "SymbolR" can be specified.
        + Array can be used to allow some types.
    + as : value is finally dealt as this type specified.
    + required : PROC command requires the option or not

The following example specifies PROC PRINT requires 'data' option, SymbolR or String is accepted for its value, and the value is finally dealt as SymbolR.

```
module ProcPrint  
  include ProcSettingModule
  ...
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR", required: true)
```


## Share common settings with multiple settings

StatSailr PROC instruction settings can be shared by multiple setting modules. The shared setting can be included using add_setting_from() method defined in ProcSettingModule. The included file is also written in module, and the format is almost the same.

In thee following example, ProcScatter or ProPlot?????? include DevCopySetting which provides functionality of dev.copy() function. 


```
# proc_plot.rb
module ProcPlot
  include ProcSettingModule
  add_setting_from( __dir__, "proc_common/dev_copy.rb" )  # This file should have DevCopy module.
  ...
  ...
end

# proc_common/dev_copy.rb
module DevCopySetting
  def setting_for_dev_copy( setting )
    ...
    ...
  end
end
```

## Contributing

Bug reports are welcome on GitHub at https://github.com/niceume/statsailr_procs_base.


## License

The gem is available as open source under the terms of the [GPL v3 License](https://www.gnu.org/licenses/gpl-3.0.en.html).


