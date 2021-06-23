module ShellScriptCron;


function hourly_scripts()
	{
	for ( script in hourly_shell_scripts_set )
    system(script);
	schedule 1min { hourly_scripts() };
	}

function weekly_scripts()
  {
  for ( script in weekly_shell_scripts_set )
    system(script);
  schedule 7days { weekly_scripts() };
  }

event network_time_init() &priority=5 {
  schedule 1min { hourly_scripts() };
  schedule 7days { weekly_scripts() };
}

########################################################
## begin Input Framework
# Use Input Framework to maintain list of ICANN TLD's
type Idx_hr: record {
	hourly_scripts: string;
};
type Idx_wk: record {
	weekly_scripts: string;
};
global hourly_shell_scripts_set: set[string] = set();
global weekly_shell_scripts_set: set[string] = set();

event zeek_init() &priority=10 {
	Input::add_table([$source="hourly_shell_scripts.dat", $name="hourly_shell_scripts_set",
					$idx=Idx_hr, $destination=hourly_shell_scripts_set,
					$mode=Input::REREAD]);
	Input::add_table([$source="weekly_shell_scripts.dat", $name="weekly_shell_scripts_set",
					$idx=Idx_wk, $destination=weekly_shell_scripts_set,
					$mode=Input::REREAD]);
}
## end Input Framework
########################################################
