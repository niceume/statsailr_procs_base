module ProcTwo
  include ProcSettingModule

  source_r_file(__dir__, File.basename(__FILE__ , ".rb") + ".R")
  validate_option("data", is_a: ["SymbolR", "String"], as: "SymbolR" , required: true)

  def setting_for_t_test( setting )
    setting.libname = nil
    setting.envname = "sts_two"
    setting.func_name = "t_test"
    setting.main_arg_and_how_to_treat = [ "vars" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data")}
    setting.store_result = true
    setting.print_opt = true
  end

  def setting_for_paired( setting )
    setting.libname = nil
    setting.envname = "sts_two"
    setting.func_name = "paired"
    setting.main_arg_and_how_to_treat = [ "vars" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data")}
    setting.store_result = true
    setting.print_opt = true
  end

  def setting_for_wilcox_test( setting )
    setting.libname = nil
    setting.envname = "sts_two"
    setting.func_name = "wilcox_test"
    setting.main_arg_and_how_to_treat = [ "vars" , :read_as_strvec, :no_nil]
    setting.runtime_args = {"data" => param("data")}
    setting.store_result = true
    setting.print_opt = true
  end

end

