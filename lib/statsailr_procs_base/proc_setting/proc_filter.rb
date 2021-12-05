module ProcFilter
  include ProcSettingModule

  source_r_file(__dir__, File.basename(__FILE__ , ".rb") + ".R")
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR" , required: true)
  validate_option("out", is_a: ["SymbolR", "String"], as: "String" , required: false)
  finalizer_enabled()

  def setting_for_cond( setting )
    setting.libname = nil
    setting.envname = "sts_filter"
    setting.func_name = "wrap_filter"
    setting.main_arg_and_how_to_treat = [ "cond", :read_as_one_str, :no_nil]
    setting.runtime_args = {"data" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_select( setting )
    setting.libname = nil
    setting.envname = "sts_filter"
    setting.func_name = "wrap_select"
    setting.main_arg_and_how_to_treat = ["cond", :read_symbols_or_functions_as_strvec, :no_nil]
    setting.runtime_args = {"data" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_assign_to( setting )
    setting.libname = nil
    setting.envname = "sts_filter"
    setting.func_name = "assign_to"
    setting.main_arg_and_how_to_treat = ["var", :read_as_strvec, :no_nil]
    setting.runtime_args = {"df" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_finalizer( setting )
    setting.libname = nil
    setting.envname = "sts_filter"
    setting.func_name = "finalizer"
    setting.main_arg_and_how_to_treat = [ nil , nil , :allow_nil ]
    setting.runtime_args = {"df" => previous_or( RBridge::r_nil()), "last_inst" => previous_inst_name(), "out" => param("out")}
    setting.store_result = false
    setting.print_opt = false
  end
end

