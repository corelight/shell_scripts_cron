module ShellScriptCron;


function hourly_scripts()
	{
  system("suricata-update update -v");
  system("/root/input_files.sh");
  system("/root/intel_files.sh");
	schedule 1min { hourly_scripts() };
	}

function weekly_scripts()
  {
  system("/root/geoip.sh");
  schedule 7days { weekly_scripts() };
  }

event network_time_init() {
  schedule 1min { hourly_scripts() };
  schedule 7days { weekly_scripts() };
}
