module ProcPlot
  include ProcSettingModule
  add_setting_from( __dir__, "proc_common/dev_copy.rb" )

  source_r_file( __dir__, "common_utility.R" )
  source_r_file( __dir__, File.basename(__FILE__ , ".rb") + ".R")
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR" , required: true)

 def setting_for_legend( setting )
    setting.libname = nil
    setting.envname = "sts_plot"
    setting.func_name = "legend"
    setting.main_arg_and_how_to_treat = [ "legend" , :read_as_strvec, :no_nil]
    setting.runtime_args = nil 
    setting.store_result = false
    setting.print_opt = false
    setting.plot_opt = false
  end

  def setting_for_hist( setting )
    setting.libname = nil
    setting.envname = "sts_plot"
    setting.func_name = "hist"
    setting.main_arg_and_how_to_treat = [ "var" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data") }
    setting.store_result = false
    setting.print_opt = false
    setting.plot_opt = true
  end

  def setting_for_box( setting )
    setting.libname = nil
    setting.envname = "sts_plot"
    setting.func_name = "box"
    setting.main_arg_and_how_to_treat = [ "var" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data")}
    setting.store_result = false
    setting.print_opt = false
    setting.plot_opt = true
  end

  def setting_for_scatter( setting )
    setting.libname = nil
    setting.envname = "sts_plot"
    setting.func_name = "scatter"
    setting.main_arg_and_how_to_treat = [ "vars" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data")}
    setting.store_result = false
    setting.print_opt = false
    setting.plot_opt = true
  end

end

