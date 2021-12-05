module ProcGgplot
  include ProcSettingModule

  source_r_file( __dir__, File.basename(__FILE__ , ".rb") + ".R")
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR" , required: true)
  finalizer_enabled()

 def setting_for_mapping( setting )
    setting.libname = nil
    setting.envname = "sts_ggplot"
    setting.func_name = "mapping"
    setting.main_arg_and_how_to_treat = [ "assoc" , :read_named_args_as_named_strvec, :no_nil]
    setting.runtime_args = {"data" => previous_or(param("data")) }
    setting.store_result = true
    setting.print_opt = false
    setting.plot_opt = false
  end

  def setting_for_geom_point( setting )
    setting.libname = nil
    setting.envname = "sts_ggplot"
    setting.func_name = "geom_point_wrapper"
    setting.main_arg_and_how_to_treat = [ "params" , :read_named_args_as_named_strvec, :allow_nil]
    setting.runtime_args = {"gg" => previous_or(RBridge::r_nil()) }
    setting.store_result = true
    setting.print_opt = false
    setting.plot_opt = false
  end

  def setting_for_geom_histogram( setting )
    setting.libname = nil
    setting.envname = "sts_ggplot"
    setting.func_name = "geom_histogram_wrapper"
    setting.main_arg_and_how_to_treat = [ "params" , :read_named_args_as_named_strvec, :allow_nil]
    setting.runtime_args = {"gg" => previous_or(RBridge::r_nil()) }
    setting.store_result = true
    setting.print_opt = false
    setting.plot_opt = false
  end

  def setting_for_finalizer( setting )
    setting.libname = nil
    setting.envname = "sts_ggplot"
    setting.func_name = "finalizer"
    setting.main_arg_and_how_to_treat = [ nil, nil , :allow_nil]
    setting.runtime_args = {"gg" => previous_or(RBridge::r_nil()) }
    setting.store_result = false
    setting.print_opt = false
    setting.plot_opt = true
  end

end

