module ProcGroup
  include ProcSettingModule

  source_r_file(__dir__, File.basename(__FILE__ , ".rb") + ".R")
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR" , required: true)
  validate_option("out", is_a: ["SymbolR", "String"], as: "String" , required: false)
  finalizer_enabled()

  def setting_for_group_by( setting )
    setting.libname = nil
    setting.envname = "sts_group"
    setting.func_name = "wrap_group_by"
    setting.main_arg_and_how_to_treat = [ "vars", :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_mutate( setting )
    setting.libname = nil
    setting.envname = "sts_group"
    setting.func_name = "wrap_mutate"
    setting.main_arg_and_how_to_treat = ["params", :read_named_args_as_named_strvec, :no_nil]
    setting.runtime_args = {"data" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_summarize( setting )
    setting.libname = nil
    setting.envname = "sts_group"
    setting.func_name = "wrap_summarize"
    setting.main_arg_and_how_to_treat = ["params", :read_named_args_as_named_strvec, :no_nil]
    setting.runtime_args = {"data" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_assign_to( setting )
    setting.libname = nil
    setting.envname = "sts_group"
    setting.func_name = "assign_to"
    setting.main_arg_and_how_to_treat = ["var", :read_as_strvec, :no_nil]
    setting.runtime_args = {"df" => previous_or( param("data") ) }
    setting.store_result = true
    setting.print_opt = false
  end

  def setting_for_finalizer( setting )
    setting.libname = nil
    setting.envname = "sts_group"
    setting.func_name = "finalizer"
    setting.main_arg_and_how_to_treat = [ nil , nil , :allow_nil ]
    setting.runtime_args = {"df" => previous_or( RBridge::r_nil()), "last_inst" => previous_inst_name(), "out" => param("out")}
    setting.store_result = false
    setting.print_opt = false
  end
end

